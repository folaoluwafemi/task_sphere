import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/entities/app/ui/components/spade/spade.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: context.palette.primary,
      ),
      backgroundColor: context.neutralColors.$100,
      // backgroundColor: context.palette.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            Transform.scale(
              scale: 1,
              child: Spade.linked(),
            ),
            30.boxHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: DateRangePicker(
                onStartDatePressed: () {},
              ),
            ),
            60.boxHeight,
          ],
        ),
      ),
    );
  }
}
