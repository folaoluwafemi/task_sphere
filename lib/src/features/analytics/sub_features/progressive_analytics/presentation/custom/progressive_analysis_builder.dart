import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'balablu_viewer.dart';

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
  late final ScrollController scrollController1 = ScrollController();
  late final ScrollController scrollController2 = ScrollController();

  final List<ProductivitySnapshot> completeSnapshots = [];

  @override
  void initState() {
    super.initState();
    scrollController2.addListener(controller2Listener);
    completeSnapshotsWith(snapshots);
  }

  double getInitialScrollPosition() {
    double wholeRatio = snapshots.length / completeSnapshots.length;

    wholeRatio = wholeRatio < (14 / 365) ? 0 : wholeRatio;

    final double initialPositionValue =
        scrollController2.position.maxScrollExtent * wholeRatio;

    return initialPositionValue;
  }

  void controller2Listener() {
    final double ratio2 =
        scrollController2.offset / scrollController2.position.maxScrollExtent;

    scrollController1.position.jumpTo(
      ratio2 * scrollController1.position.maxScrollExtent,
    );
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  List<DateTime> getDaysInYearOf([
    DateTime? dayOfLatestProductivitySnapshot,
  ]) {
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

  /// Completes [feeder] with a list of empty [ProductivitySnapshot]s
  /// from next day to the end of the year
  void completeSnapshotsWith(List<ProductivitySnapshot> feeder) {
    feeder.sort(ProductivitySnapshotUtils.compare);

    final List<ProductivitySnapshot> newSnapshots = [];

    final List<DateTime> daysInCurrentYear = getDaysInYearOf(
      feeder.last.dateTime,
    );

    final earliestSnapshotForYear = getEarliestDayInLatestYear(feeder);

    // adding one since DateTime.weekday starts from 1 [Monday] and we are ordering from sunday
    final int earliestSnapshotDayOfWeek =
        earliestSnapshotForYear.dateTime.weekday + 1;

    for (int i = 1; i < earliestSnapshotDayOfWeek; i++) {
      final dayOfNewSnapshot = feeder.first.dateTime.subtract(
        Duration(days: i),
      );
      newSnapshots.add(
        (dateTime: dayOfNewSnapshot, value: 0),
      );
    }

    final List<ProductivitySnapshot> snapshotsInCurrentYear =
        getAllSnapshotsInLatestYear(feeder);

    completeSnapshots.addAll(newSnapshots);
    newSnapshots.clear();

    final int numberOfSnapshotsToAdd = daysInCurrentYear.length -
        (snapshotsInCurrentYear.length + completeSnapshots.length);

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
                  Text('Mon', style: weekDayStyle),
                  26.boxHeight,
                  Text('Wed', style: weekDayStyle),
                  26.boxHeight,
                  Text('Fri', style: weekDayStyle),
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
          // Expanded(
          //   child: SizedBox(
          //     height: (14.h * 7) + (6 * 3.h) + 24.h,
          //     child: Column(
          //       children: [
          //         // SizedBox(
          //         //   height: 24.h,
          //         //   child: AbsorbPointer(
          //         //     child: Builder(
          //         //       builder: (context) => Balablu(
          //         //         snapshots: completeSnapshots,
          //         //         earliestYear: earliestYear,
          //         //         earliestMonth: earliestMonth,
          //         //         scrollController: scrollController1,
          //         //       ),
          //         //     ),
          //         //   ),
          //         // ),
          //         // SizedBox(
          //         //   height: (14.h * 7) + (6 * 3.h),
          //         //   child: GridView.builder(
          //         //     physics: const ClampingScrollPhysics(),
          //         //     controller: scrollController2,
          //         //     itemCount: values.length,
          //         //     scrollDirection: Axis.horizontal,
          //         //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         //       crossAxisCount: 7,
          //         //       crossAxisSpacing: 3.h,
          //         //       mainAxisSpacing: 3.w,
          //         //       mainAxisExtent: 18.w,
          //         //       childAspectRatio: 18.w / 14.h,
          //         //     ),
          //         //     itemBuilder: (context, index) {
          //         //       return ProductivityUnit.fromValue(
          //         //         values[index],
          //         //         maxValue: maxValue,
          //         //       ).widget;
          //         //     },
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Balablu extends StatelessWidget {
  final ScrollController scrollController;
  final int earliestYear;
  final int earliestMonth;
  final List<ProductivitySnapshot> snapshots;

  const Balablu({
    required this.earliestYear,
    required this.earliestMonth,
    required this.snapshots,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  List<int> getSnapshotMonths() {
    final List<int> result = [];

    final DateTime normalizedDate = snapshots.last.dateTime.copyWith(
      day: 0,
      hour: 0,
      minute: 0,
      microsecond: 0,
      millisecond: 0,
      second: 0,
    );
    for (DateTime i = snapshots.first.dateTime;
        i.millisecondsSinceEpoch < normalizedDate.millisecondsSinceEpoch;
        i = i.copyAdd(months: 1)) {
      result.add(i.month);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final int earliestDay = snapshots
        .where((element) => element.dateTime.month == earliestMonth)
        .map((e) => e.dateTime.day)
        .reduce(
          (value, element) => value < element ? value : element,
        );

    final int totalDaysInEarliestMonth = DateTime(
      earliestYear,
      earliestMonth + 1,
      0,
    ).day;

    final List<int> months = getSnapshotMonths();

    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: (1 + (earliestDay / totalDaysInEarliestMonth)) * 38.w,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: months.length,
      separatorBuilder: (context, index) => SizedBox(
        width: (1 + (earliestDay / totalDaysInEarliestMonth)) * 38.w * 2,
      ),
      itemBuilder: (context, index) {
        final String text = DateFormat.MMM().format(
          DateTime.now().copyWith(month: months[index]),
        );
        return Text(
          text,
          style: context.secondaryTypography.footnote
              .withColor(context.neutralColors.$600),
        );
      },
    );
  }
}
