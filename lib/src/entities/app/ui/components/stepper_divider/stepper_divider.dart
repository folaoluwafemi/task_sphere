import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'stepper_divider_painter.dart';

class StepperDivider extends StatelessWidget {
  final double? spacing;
  final double? stepWidth;
  final double? thickness;
  final Color? color;
  final double? width;

  const StepperDivider({
    Key? key,
    this.spacing,
    this.stepWidth,
    this.thickness,
    this.color,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CustomPaint(
        size: Size(width ?? context.screenWidth, thickness ?? 1.h),
        painter: StepperDividerPainter(
          spacing: spacing ?? 3.w,
          stepWidth: stepWidth ?? 3.w,
          thickness: thickness ?? 1.h,
          spacingColor: context.bgColors.$50,
          color: color ?? context.neutralColors.$400,
        ),
      ),
    );
  }
}
