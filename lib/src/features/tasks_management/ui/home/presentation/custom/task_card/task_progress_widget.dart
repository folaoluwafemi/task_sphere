import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'progress_painter.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50.l,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: 50.l,
            child: CustomPaint(
              painter: TaskProgressPainter(
                context: context,
                percentage: task.progressPercentage + 30,
                progressColor: switch (task.progressPercentage + 30) {
                  < 25 => context.alertColors.error,
                  < 50 => context.alertColors.info,
                  _ => context.alertColors.success,
                },
                thinLineColor: context.neutralColors.$400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text.rich(
              TextSpan(
                text: task.progressPercentage.ceil().toString(),
                style: context.primaryTypography.paragraph.medium.copyWith(
                  color: context.neutralColors.$800,
                  height: 1.7001,
                  fontSize: 14.sp,
                  letterSpacing: -0.6,
                ),
                children: [
                  TextSpan(
                    text: '%',
                    style: context.primaryTypography.paragraph.medium.copyWith(
                      color: context.neutralColors.$800,
                      height: 2.381,
                      fontSize: 10.sp,
                      letterSpacing: -0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              'Done',
              style: context.primaryTypography.paragraph.medium.copyWith(
                color: context.neutralColors.$600,
                height: 2.976,
                fontSize: 8.sp,
                letterSpacing: -0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
