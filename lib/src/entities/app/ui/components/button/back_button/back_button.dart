import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class BackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool filledColor;

  const BackButton({
    Key? key,
    this.onPressed,
    this.filledColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Ui.circularBorder(88.m),
      child: FittedBox(
        child: Opacity(
          opacity: onPressed == null ? 0.1 : 1,
          child: Container(
            height: 32.h,
            padding: EdgeInsets.fromLTRB(
              5.w,
              6.h,
              10.w,
              6.h,
            ),
            decoration: BoxDecoration(
              color: filledColor ? context.bgColors.$50 : null,
              borderRadius: Ui.circularBorder(88.m),
              border: Border.all(
                width: 1.w,
                color: context.neutralColors.$400,
              ),
            ),
            child: SizedBox(
              height: 20.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: SizedBox.square(
                      dimension: 18.h,
                      child: SvgPicture.asset(
                        VectorAssets.arrowBack,
                      ),
                    ),
                  ),
                  2.boxWidth,
                  Text(
                    'Back',
                    style: context.secondaryTypography.paragraph.large,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
