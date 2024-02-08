part of '../../app_router.dart';

enum AppRoute {
  splash('/', '/'),
  onboarding('/onboarding', '/onboarding'),
  login('login', '/onboarding/login'),
  forgotPassword('forgot-password', '/onboarding/forgot-password'),

  ///
  signUp('signUp', '/onboarding/signUp'),
  enterName('enterName:redirect', '/onboarding/signUp/enterName '),

  ///
  home('/home', '/home'),
  task('task', '/home/task'),
  search('search', '/home/search'),
  about('about', '/home/about'),
  aboutDesignAndDev('about-des-dev', '/home/about/about-des-dev'),
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
