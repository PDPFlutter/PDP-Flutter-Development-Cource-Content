import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/main/main_screen.dart';
part 'path_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

sealed class AppRoute {
  static String initialLocation = Routes.home;
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state, child) {
          return Main(
            key: state.pageKey,
            currentIndex: switch (state.uri.path) {
              final p when p.startsWith(Routes.home) => 0,
              final p when p.startsWith(Routes.catalog) => 1,
              final p when p.startsWith(Routes.cart) => 2,
              final p when p.startsWith(Routes.favorite) => 3,
              final p when p.startsWith(Routes.profile) => 4,
              _ => 0,
            },
            child: child,
          );
        },
        routes: [
          GoRoute(path: Routes.home, builder: (context, state) => const Scaffold()),
          GoRoute(path: Routes.catalog, builder: (context, state) => const Scaffold()),
          GoRoute(path: Routes.cart, builder: (context, state) => const Scaffold()),
          GoRoute(path: Routes.favorite, builder: (context, state) => const Scaffold()),
          GoRoute(path: Routes.profile, builder: (context, state) => const Scaffold()),
        ],
      ),
    ],
  );
}
