import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class LargeButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? gutterWidth;
  final Color? color;
  final VoidCallback? onPressed;
  final Alignment? alignment;

  const LargeButton({
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.gutterWidth,
    this.color,
    this.alignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = this.width ?? 354.w;
    return RawMaterialButton(
      splashColor: context.bgColors.$50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(30, 7.9),
          bottomLeft: Radius.elliptical(30, 7.9),
          bottomRight: Radius.elliptical(30, 7.9),
          topRight: Radius.elliptical(30, 8),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        child: SizedBox(
          width: width,
          height: height,
          child: ClipPath(
            key: UniqueKey(),
            clipper: const ButtonBezierClipper(
              horizontalLength: 20,
              verticalHeight: 10,
            ),
            child: ClipPath(
              clipper: LargeButtonGutterClipper(
                horizontalLength: 0.2599 * width,
                verticalHeight: 0.2 * (height ?? 50.h),
                depth: 3,
                radius: 1,
              ),
              child: Container(
                color: onPressed == null
                    ? (color ?? context.palette.secondary).withOpacity(0.5)
                    : (color ?? context.palette.secondary),
                alignment: alignment ?? Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
