import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/productivity_snapshot.dart';
import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/utils/functions/extensions/extensions.dart';

class DailySnapshotWidget extends StatelessWidget {
  final ProductivitySnapshot snapshot;
  final int maxValue;

  const DailySnapshotWidget({
    required this.snapshot,
    required this.maxValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.l),
      child: ProductivityUnit.fromValue(
        snapshot.value,
        maxValue: maxValue,
      ).widget,
    );
  }
}

typedef WeeklySnapshotsEntry = MapEntry<int, ProductivitySnapshots>;

class WeeklySnapshotWidget extends StatelessWidget {
  final int maxValue;
  final WeeklySnapshots snapshots;

  const WeeklySnapshotWidget({
    required this.snapshots,
    required this.maxValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final element =
        snapshots.entries.toList().elementAtOrNull(0)?.value.lastOrNull;

    return MultiSliver(
      children: [
        Column(
          children: [
            Text(
              DateFormat.MMM().format(
                (snapshots.entries.toList().elementAtOrNull(1) ??
                        snapshots.entries.toList().elementAtOrNull(0))!
                    .value
                    .first
                    .dateTime,
              ),
              style: context.secondaryTypography.footnote
                  .withColor(context.neutralColors.$600),
            ),
            const Spacer(),
            Row(
              children: [
                ...snapshots.entries.map(
                  (entry) {
                    return SizedBox(
                      height: (14.h * 7) + (2.h * 7),
                      child: Column(
                        mainAxisAlignment:
                            (element != null && element.dateTime.weekday == 1)
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                        children: [
                          ...entry.value.map(
                            (snapshot) => DailySnapshotWidget(
                              maxValue: maxValue,
                              snapshot: snapshot,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class MonthlySnapshotWidget extends StatelessWidget {
  final int maxValue;
  final MonthlySnapshots monthlySnapshots;

  const MonthlySnapshotWidget({
    required this.monthlySnapshots,
    required this.maxValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        ...monthlySnapshots.entries.map(
          (monthlyEntry) {
            return WeeklySnapshotWidget(
              maxValue: maxValue,
              snapshots: monthlyEntry.value,
            );
          },
        ),
      ],
    );
  }
}

class YearlySnapshotWidget extends StatelessWidget {
  final int maxValue;
  final YearlySnapshots yearlySnapshots;

  const YearlySnapshotWidget({
    required this.yearlySnapshots,
    required this.maxValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int latestYear = yearlySnapshots.keys.last;

    final MonthlySnapshots snapshots = yearlySnapshots[latestYear]!;
    return MultiSliver(
      children: [
        ...yearlySnapshots.entries.map(
          (e) => MonthlySnapshotWidget(
            monthlySnapshots: e.value,
            maxValue: maxValue,
          ),
        ),
        // MonthlySnapshotWidget(
        //   monthlySnapshots: snapshots,
        //   maxValue: maxValue,
        // ),
      ],
    );
  }
}
