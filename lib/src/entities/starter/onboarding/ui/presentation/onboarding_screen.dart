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
        backgroundColor: context.palette.secondary,
      ),
      backgroundColor: context.neutralColors.$100,
      // backgroundColor: context.palette.alerts.success,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            30.boxHeight,
            Center(
              child: Transform.scale(
                scale: 1,
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Alert.error(
                    text:
                        'Alert are we adsa alsdkfaj dfasd flads a asdlfa sdfalsd ffdjfa dsfladsjf aldsjf asdldoing to day ',
                  ),
                ),
              ),
            ),
            60.boxHeight,
            LargeButton(
              onPressed: () => AlertType.success.show(
                context,
                text: 'Balablu!!',
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 38.w,
                  vertical: 13.h,
                ),
                child: Text(
                  'Show overlay',
                  style: context.primaryTypography.paragraph.medium.asMedium.copyWith(
                    color: context.bgColors.$50,
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
