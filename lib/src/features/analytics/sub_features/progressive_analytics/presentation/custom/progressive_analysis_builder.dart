import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'calendar_viewer.dart';

class ProgressiveAnalysisBuilder extends StatefulWidget {
  final List<ProductivitySnapshot> snapshots;

  const ProgressiveAnalysisBuilder({
    Key? key,
    required this.snapshots,
  }) : super(key: key);

  @override
  State<ProgressiveAnalysisBuilder> createState() =>
      _ProgressiveAnalysisBuilderState();
}

class _ProgressiveAnalysisBuilderState
    extends State<ProgressiveAnalysisBuilder> {
  late final List<ProductivitySnapshot> snapshots = widget.snapshots;

  final List<ProductivitySnapshot> completeSnapshots = [];

  @override
  void initState() {
    super.initState();
    completeSnapshotsWith(snapshots);
  }

  List<DateTime> getDaysInYearOf([DateTime? dayOfLatestProductivitySnapshot]) {
    final DateTime now = dayOfLatestProductivitySnapshot ?? DateTime.now();
    final DateTime firstDayOfYear = DateTime(now.year, 1, 1);
    final DateTime lastDayOfYear = DateTime(now.year, 12, 31);

    final Set<DateTime> daysInCurrentYear = {};

    for (DateTime day = firstDayOfYear;
        day.isBefore(lastDayOfYear);
        day = day.add(const Duration(days: 1))) {
      daysInCurrentYear.add(day);
    }
    daysInCurrentYear.add(lastDayOfYear);

    return daysInCurrentYear.toList();
  }

  ProductivitySnapshot getEarliestDayInLatestYear(
    List<ProductivitySnapshot> feeder,
  ) {
    final int currentYearInSnapshot = feeder.last.dateTime.year;
    return feeder.firstWhere((element) {
      return element.dateTime.year == currentYearInSnapshot;
    });
  }

  List<ProductivitySnapshot> getAllSnapshotsInLatestYear(
    List<ProductivitySnapshot> seed,
  ) {
    final int indexOfLatestDay = seed.indexWhere((element) {
      return element.dateTime.year == seed.last.dateTime.year;
    });

    return seed.sublist(indexOfLatestDay);
  }

  List<ProductivitySnapshot> fillEmptyDayGaps(
    List<ProductivitySnapshot> feeder,
  ) {
    feeder = feeder.copy..sort(ProductivitySnapshotUtils.compare);
    final List<ProductivitySnapshot> temp = [];
    for (int i = 0; i < feeder.length; i++) {
      final ProductivitySnapshot? previousItem = feeder.elementAtOrNull(i - 1);
      final currentItem = feeder[i];

      if (previousItem == null ||

          /// if current day is one day after the previous one
          currentItem.dateTime.dateEquality(
            previousItem.dateTime.copyAdd(days: 1),
          )) {
        temp.add(currentItem);
        continue;
      }

      final DateTime currentDate = currentItem.dateTime;
      final DateTime previousDate = previousItem.dateTime;

      final Duration durationDifference = currentDate.difference(previousDate);
      final List<ProductivitySnapshot> dates = [];

      for (int i = 1; i <= durationDifference.inDays; i++) {
        dates.add(
          (dateTime: previousDate.copyAdd(days: i), value: 0),
        );
      }

      temp.addAll([
        previousItem,
        ...dates,
        currentItem,
      ]);
    }
    return temp;
  }

  void padRightWith(List<ProductivitySnapshot> feeder) {
    feeder = feeder.copy..sort(ProductivitySnapshotUtils.compare);

    final List<ProductivitySnapshot> allDaysInYearEmpty = [];
    for (int i = 1; i <= 12; i++) {
      final DateTime now = feeder.firstOrNull?.dateTime ?? DateTime.now();
      final month = List.generate(
        now.copyWith(month: i + 1, day: 0).day,
        (index) => (
          dateTime: now.copyWith(month: i, day: index + 1),
          value: 0,
        ),
      );
      allDaysInYearEmpty.addAll(month);
    }

    if (feeder.isEmpty) {
      completeSnapshots.pushAllFront(allDaysInYearEmpty);
      return;
    }
    final DateTime earliestDay = feeder.first.dateTime;

    final List validList = allDaysInYearEmpty.sublist(
      0,
      allDaysInYearEmpty.indexWhere((element) {
        return element.dateTime.dateEquality(earliestDay);
      }),
    );
    completeSnapshots.pushAllFront(allDaysInYearEmpty);
  }

  /// Completes [feeder] with a list of empty [ProductivitySnapshot]s
  /// from next day to the end of the year
  void completeSnapshotsWith(List<ProductivitySnapshot> feeder) {
    feeder = fillEmptyDayGaps(feeder);
    padRightWith(feeder);
    feeder.sort(ProductivitySnapshotUtils.compare);

    final List<ProductivitySnapshot> newSnapshots = [];

    final List<DateTime> daysInCurrentYear = getDaysInYearOf(
      feeder.last.dateTime,
    );

    final earliestSnapshotForYear = getEarliestDayInLatestYear(feeder);

    print('earliest snapshot for year: ${earliestSnapshotForYear.dateTime}');

    // adding one since DateTime.weekday starts from 1 [Monday] and we are ordering from sunday
    final int earliestSnapshotDayOfWeek =
        earliestSnapshotForYear.dateTime.weekday;

    for (int i = 1; i < earliestSnapshotDayOfWeek; i++) {
      final dayOfNewSnapshot = feeder.first.dateTime.subtract(
        Duration(days: i),
      );
      newSnapshots.add(
        (dateTime: dayOfNewSnapshot, value: 0),
      );
    }

    final snapshotsInCurrentYear = getAllSnapshotsInLatestYear(feeder);

    completeSnapshots.addAll(newSnapshots);
    newSnapshots.clear();

    final int numberOfSnapshotsToAdd =
        daysInCurrentYear.length - (snapshotsInCurrentYear.length);

    final DateTime dayOfLastSnapshot = feeder.last.dateTime;

    for (int i = 1; i <= numberOfSnapshotsToAdd; i++) {
      final DateTime dayOfNewSnapshot = dayOfLastSnapshot.add(
        Duration(days: i),
      );
      newSnapshots.add(
        (dateTime: dayOfNewSnapshot, value: 0),
      );
    }

    completeSnapshots.addAll([...feeder, ...newSnapshots]);

    completeSnapshots.sort(ProductivitySnapshotUtils.compare);
  }

  int getEarliestMonthIn(List<ProductivitySnapshot> snapshots) {
    final List<int> months = snapshots.map((e) => e.dateTime.month).toList();
    return months.reduce(
      (value, element) => value < element ? value : element,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<int> values = completeSnapshots.map((e) => e.value).toList();
    final int maxValue = values.reduce(
      (value, element) => value > element ? value : element,
    );

    final int earliestMonth = getEarliestMonthIn(snapshots);
    final int earliestYear = snapshots
        .where((element) => element.dateTime.month == earliestMonth)
        .map((e) => e.dateTime.year)
        .reduce(
          (value, element) => value < element ? value : element,
        );

    final TextStyle weekDayStyle = context.secondaryTypography.footnote
        .withColor(context.neutralColors.$600)
        .withHeight(1);
    return Padding(
      padding: EdgeInsets.only(left: 18.w),
      child: Row(
        children: [
          SizedBox(
            height: (14.h * 7) + (6 * 3.h),
            child: Padding(
              padding: EdgeInsets.only(top: 26.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tue', style: weekDayStyle),
                  26.boxHeight,
                  Text('Thur', style: weekDayStyle),
                  26.boxHeight,
                  Text('Sat', style: weekDayStyle),
                ],
              ),
            ),
          ),
          5.boxWidth,
          Expanded(
            child: SizedBox(
              height: (14.h * 7) + (6 * 3.h) + 24.h,
              child: CalendarViewer(snapshots: completeSnapshots),
            ),
          ),
        ],
      ),
    );
  }
}
