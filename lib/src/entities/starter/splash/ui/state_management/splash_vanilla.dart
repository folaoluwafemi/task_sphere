import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class SplashVanilla extends VanillaNotifier<AppRoute> {
  SplashVanilla() : super(AppRoute.splash);

  Future<void> navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    state = AppRoute.onboarding;
  }
}
