import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'views/onboarding_view.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: context.palette.bgAccent,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.05,
            child: SizedBox(
              width: 615.6.w,
              height: 615.h,
              child: Image.asset(
                Assets.onboardingCover,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SafeArea(
            child: _OnboardingView(),
          ),
        ],
      ),
    );
  }
}
