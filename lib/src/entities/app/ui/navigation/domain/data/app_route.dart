part of '../../app_router.dart';

enum AppRoute {
  splash('/'),
  onboarding('/onboarding'),
  login('login'),

  ///
  signUp('signUp'),
  enterName('enterName'),
  ;

  final String path;

  const AppRoute(this.path);
}
