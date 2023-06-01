import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  routes: [],
);
