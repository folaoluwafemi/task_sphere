import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('asdasd${37.3.h}');
    print('asdas${107.7.w}');
    //128
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: context.palette.primary,
      ),
      // backgroundColor: context.neutralColors.$100,
      backgroundColor: context.palette.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            30.boxHeight,
            Center(
              child: Transform.scale(
                scale: 5,
                child: SmallButton(
                  width: 70.w,
                  height: 37.3.h,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
            60.boxHeight,
          ],
        ),
      ),
    );
  }
}
