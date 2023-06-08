import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/splash_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaNotifierHolder<SplashVanilla>(
      notifier: SplashVanilla()..navigateToNext(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black87.withBlue(255).withOpacity(0.2),
        body: const _SplashView(),
      ),
    );
  }
}
