import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platzi_store/screens/catalog/detail/catalog_detail_screen.dart';
import 'package:platzi_store/screens/home/home_screen.dart';
import 'package:platzi_store/screens/product/product_screen.dart';
import '../../screens/catalog/catalog_screen.dart';
import '../../screens/main/main_screen.dart';

part 'path_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

sealed class AppRoute {
  static final _product = GoRoute(
    path: Routes.product,
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) {
      return ProductScreen(
        id: state.pathParameters['id']!,
        key: ValueKey(state.pathParameters['id']!),
      );
    },
  );

  

  static String initialLocation = Routes.home;

  static final _authRoutes = [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
  ];
  
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
          GoRoute(
            path: Routes.home,
            builder: (context, state) => const HomeScreen(),
            routes: [_product],
          ),
          GoRoute(
            path: Routes.catalog,
            builder: (context, state) => const CatalogScreen(),
            routes: [
              GoRoute(
                path: Routes.categoryDetail,
                parentNavigatorKey: rootNavigatorKey,
                builder: (context, state) {
                  return CatalogDetailScreen(
                    categoryID: state.pathParameters['catalogID']!,
                    key: ValueKey(state.pathParameters['catalogID']!),
                  );
                },
                routes: [_product],
              ),
            ],
          ),
          GoRoute(path: Routes.cart, builder: (context, state) => const Scaffold()),
          GoRoute(path: Routes.favorite, builder: (context, state) => const Scaffold()),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      ..._authRoutes,
    ],
  );
}
