part of '../../app_router.dart';

abstract final class _NavigationRedirectsManager {
  static String? baseRedirect(BuildContext context, GoRouterState state) {
    final User? user = UserManager().user;

    if ((user == null || user.displayName == null) &&
        !state.location.contains(AppRoute.onboarding.path)) {
      return AppRoute.onboarding.fullPath;
    }

    return null;
  }

  static String? authRedirect(BuildContext context, GoRouterState state) {
    final User? user = UserManager().user;

    final String destination = '/${state.location.split('/').last}';

    if (destination.contains(AppRoute.login.path) && user != null) {
      if (user.displayName == null) {
        return '${AppRoute.enterName.fullPath}=redirect';
      }
      return AppRoute.home.fullPath;
    }

    if (destination.contains(AppRoute.signUp.path) && user != null) {
      if (user.displayName == null) {
        return '${AppRoute.enterName.fullPath}=redirect';
      }
      return AppRoute.home.fullPath;
    }
    return null;
  }
}
