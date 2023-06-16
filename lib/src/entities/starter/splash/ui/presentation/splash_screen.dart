import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/app/ui/components/spade/spade.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaNotifierHolder<SplashVanilla>(
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
