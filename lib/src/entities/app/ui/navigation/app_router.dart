import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/features_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

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
      redirect: _NavigationRedirectsManager.authRedirect,
      builder: (context, state) => const OnboardingScreen(),
      routes: [
        GoRoute(
          path: AppRoute.login.path,
          name: AppRoute.login.name,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoute.signUp.path,
          name: AppRoute.signUp.name,
          builder: (context, state) => const SignUpScreen(),
          routes: [
            GoRoute(
              path: AppRoute.enterName.path,
              name: AppRoute.enterName.name,
              builder: (context, state) {
                final String? redirected = state.pathParameters['redirect'];
                print('redirected $redirected');
                return EnterNameScreen(
                  redirect: (redirected?.trim()).isNotNullOrEmpty,
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
