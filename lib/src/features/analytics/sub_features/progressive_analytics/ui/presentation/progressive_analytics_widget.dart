import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class ProgressiveAnalyticsWidget extends StatelessWidget {
  const ProgressiveAnalyticsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(8.w, 1.h, 8.w, 3.h),
                decoration: BoxDecoration(
                  color: context.bgColors.$50,
                  borderRadius: Ui.circularBorderLeft(3.l),
                ),
                child: Text(
                  'YOUR PERFORMANCE',
                  style: context.primaryTypography.paragraph.small.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    height: 2,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              8.boxWidth,
              Container(
                decoration: BoxDecoration(
                  color: context.bgColors.$50,
                  borderRadius: Ui.circularBorderRight(3.l),
                ),
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                child: Text.rich(
                  TextSpan(
                    text: formatDate(),
                    children: [
                      TextSpan(
                        text: ' • ',
                        style: context.secondaryTypography.caption.medium
                            .copyWith(color: context.neutralColors.$500),
                      ),
                      TextSpan(
                        text: '12n todos done',
                        style: context.secondaryTypography.caption.medium
                            .copyWith(color: context.palette.primary),
                      ),
                    ],
                  ),
                  style: context.secondaryTypography.caption.medium,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 140.h,
          width: 433.w,
          margin: EdgeInsets.only(left: 18.w),
          color: context.palette.secondary.withOpacity(0.3),
        ),
      ],
    );
  }

  String formatDate() {
    final DateTime now = DateTime.now();
    final String day = now.day.toOrdinal();
    final String month = DateFormat.MMMM().format(now);

    return '$day $month';
  }
}
