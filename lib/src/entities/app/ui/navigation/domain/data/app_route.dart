part of '../../app_router.dart';

enum AppRoute {
  splash('/', '/'),
  onboarding('/onboarding', '/onboarding'),
  login('login', '/onboarding/login'),

  ///
  signUp('signUp', '/onboarding/signUp'),
  enterName('enterName:redirect', '/onboarding/signUp/enterName '),

  ///
  home('/home', '/home'),
  trash('/trash', '/home/trash'),
  settings('/settings', '/home/settings'),
  ;

  final String path;
  final String fullPath;

  const AppRoute(this.path, this.fullPath);

  ///adds each route to the full path in order of entry
  static String buildPath(List<AppRoute> routes) {
    assert(routes.isNotEmpty, 'route path must not be empty');
    String path = '';
    if (routes.first.path.chars.first != '/') path += '/';
    for (int i = 0; i < (routes.length - 1); i++) {
      path += '${routes[i].path}/';
    }
    path += routes.last.path;
    return path;
  }
}
