import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

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
            ProgressiveAnalysisBuilder(
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
    print('todo done today: $todosDoneToday');
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
