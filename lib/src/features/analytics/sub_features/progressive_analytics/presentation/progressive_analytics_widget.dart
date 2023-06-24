import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/productivity_unit_widget.dart';

class ProgressiveAnalyticsWidget extends StatelessWidget {
  const ProgressiveAnalyticsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<ProgressiveAnalyticsVanilla,
        ProgressiveAnalysisState>(
      builder: (context, state) {
        final List<ProductivitySnapshot> snapshots = List.from(
          state.historySnapshots.isEmpty
              ? [ProductivitySnapshotUtils.empty]
              : state.historySnapshots,
        );

        if (state.loading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: LoaderWidget(
                color: context.palette.primary,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PerformanceWidget(todosDoneToday: state.numberOfTodosDoneToday),
            _ProgressiveAnalysisBuilder(
              snapshots: snapshots,
              key: ValueKey(snapshots),
            ),
          ],
        );
      },
    );
  }
}

class _PerformanceWidget extends StatelessWidget {
  final int todosDoneToday;

  const _PerformanceWidget({
    Key? key,
    required this.todosDoneToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 3.w,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.bgColors.$50,
              borderRadius: Ui.circularBorderLeft(3.l),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Text(
              'YOUR PERFORMANCE',
              style: context.secondaryTypography.caption.medium,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.bgColors.$50,
              borderRadius: Ui.circularBorderRight(3.l),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Text.rich(
              TextSpan(
                text: '${DateTime.now().day.toOrdinal()}'
                    ' ${DateFormat.MMMM().format(DateTime.now())} ',
                children: [
                  TextSpan(
                    text: '• ',
                    style: context.secondaryTypography.caption.medium
                        .withColor(context.neutralColors.$500),
                  ),
                  TextSpan(
                    text: ' $todosDoneToday todo${todosDoneToday.pluralS} done',
                    style: context.secondaryTypography.caption.medium
                        .withColor(context.palette.primary),
                  ),
                ],
              ),
              style: context.secondaryTypography.caption.medium,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressiveAnalysisBuilder extends StatefulWidget {
  final List<ProductivitySnapshot> snapshots;

  const _ProgressiveAnalysisBuilder({
    Key? key,
    required this.snapshots,
  }) : super(key: key);

  @override
  State<_ProgressiveAnalysisBuilder> createState() =>
      _ProgressiveAnalysisBuilderState();
}

class _ProgressiveAnalysisBuilderState
    extends State<_ProgressiveAnalysisBuilder> {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setControllerInitialOffset();
  }

  void setControllerInitialOffset() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController2.jumpTo(getInitialScrollPosition());
    });
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

  List<DateTime> getDaysInCurrentYear() {
    final DateTime now = DateTime.now();
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

  void completeSnapshotsWith(
    List<ProductivitySnapshot> feeder,
  ) {
    feeder.sort(ProductivitySnapshotUtils.compare);

    final List<ProductivitySnapshot> newSnapshots = [];

    final List<DateTime> daysInCurrentYear = getDaysInCurrentYear();

    // adding one since DateTime.weekday starts from 1 [Monday] and we are ordering from sunday
    final int earliestSnapshotDayOfWeek = feeder.first.dateTime.weekday + 1;

    for (int i = 1; i < earliestSnapshotDayOfWeek; i++) {
      final DateTime dayOfNewSnapshot = feeder.first.dateTime.subtract(
        Duration(days: i),
      );
      newSnapshots.add(
        (dateTime: dayOfNewSnapshot, value: 0),
      );
    }

    completeSnapshots.addAll(newSnapshots);
    newSnapshots.clear();

    final int numberOfSnapshotsToAdd =
        daysInCurrentYear.length - (feeder.length + completeSnapshots.length);

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

    return Padding(
      padding: EdgeInsets.only(left: 18.w),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: SizedBox(
              height: (14.h * 7) + (6 * 3.h) + 23.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...['Mon', 'Wed', 'Fri'].map(
                    (e) => Text(
                      e,
                      textAlign: TextAlign.center,
                      strutStyle: const StrutStyle(leading: 1.87, height: 1.01),
                      style: context.secondaryTypography.footnote
                          .withColor(context.neutralColors.$600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          5.boxWidth,
          Expanded(
            child: SizedBox(
              height: (14.h * 7) + (6 * 3.h) + 24.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 24.h,
                    child: AbsorbPointer(
                      child: Builder(
                        builder: (context) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: (1 +
                                      (earliestDay /
                                          totalDaysInEarliestMonth)) *
                                  38.w,
                            ),
                            controller: scrollController1,
                            scrollDirection: Axis.horizontal,
                            itemCount: 12,
                            separatorBuilder: (context, index) => 70.boxWidth,
                            itemBuilder: (context, index) {
                              final String text = DateFormat.MMM().format(
                                DateTime.now().copyWith(
                                  month: (index + 1) +
                                      getEarliestMonthIn(snapshots),
                                ),
                              );
                              return Text(
                                text,
                                style: context.secondaryTypography.footnote
                                    .withColor(context.neutralColors.$600),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (14.h * 7) + (6 * 3.h),
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController2,
                      itemCount: values.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 3.h,
                        mainAxisSpacing: 3.w,
                        mainAxisExtent: 18.w,
                        childAspectRatio: 18.w / 14.h,
                      ),
                      itemBuilder: (context, index) {
                        return ProductivityUnit.fromValue(
                          values[index],
                          maxValue: maxValue,
                        ).widget;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
