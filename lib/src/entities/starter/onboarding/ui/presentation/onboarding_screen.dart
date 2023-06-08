import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/entities/app/ui/components/inputs/input_field.dart';
import 'package:task_sphere/src/entities/app/ui/components/inputs/otp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: context.palette.bgAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.m),
              child: InputField(
                hintText: 'Your Email Address',
                palette: context.inputPalette.singleFieldPalette,
                prefixIconBuilder: (context, color) => SvgPicture.asset(
                  VectorAssets.profileFilled,
                  color: color,
                ),
              ),
            ),
            30.boxHeight,
            CodeFields(
              onChanged: (value) {},
            ),
            10.boxHeight,
          ],
        ),
      ),
    );
  }
}
