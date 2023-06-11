import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class SmallButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? gutterWidth;
  final Color? color;
  final VoidCallback? onPressed;

  const SmallButton({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.gutterWidth,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            clipper: const ButtonBezierClipper(
              horizontalLength: 20,
              verticalHeight: 10,
            ),
            child: ClipPath(
              clipper: SmallButtonGutterClipper(
                horizontalLength: 0.1266 * (width ?? 158.w),
                verticalHeight: 0.2 * (height ?? 50.h),
                depth: 2,
                radius: 1,
              ),
              child: Container(
                color: onPressed == null
                    ? (color ?? context.palette.primary).withOpacity(0.5)
                    : (color ?? context.palette.primary),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
