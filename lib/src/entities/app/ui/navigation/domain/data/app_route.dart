part of '../../app_router.dart';

enum AppRoute {
  splash('/'),
  onboarding('/onboarding'),
  ;

  final String path;

  const AppRoute(this.path);
}
