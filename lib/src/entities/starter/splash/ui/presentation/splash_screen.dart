import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'custom/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedVanilla<SplashVanilla>(
      createNotifier: () => SplashVanilla()..navigateToNext(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: context.palette.bg.$50,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        backgroundColor: context.palette.bg.$50,
        extendBodyBehindAppBar: true,
        body: const _SplashView(),
      ),
    );
  }
}
