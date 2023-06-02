import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';

part 'domain/data/app_route.dart';

part 'domain/logic/redirects_manager.dart';

abstract final class AppRouter {
  static final RouterConfig<Object> routerConfig = RouterConfig(
    routerDelegate: router.routerDelegate,
    backButtonDispatcher: router.backButtonDispatcher,
    routeInformationParser: router.routeInformationParser,
    routeInformationProvider: router.routeInformationProvider,
  );

  static GoRouter get router => _router;

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _navigatorKey,
  redirect: _NavigationRedirectsManager.baseRedirect,
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoute.onboarding.path,
      name: AppRoute.onboarding.name,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
