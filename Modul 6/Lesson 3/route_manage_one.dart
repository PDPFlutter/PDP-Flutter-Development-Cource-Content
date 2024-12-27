import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class Routes {
  static const home = '/';
  static const detail = 'detail';
  static const review = 'review';
  static const category = '/category';
}

abstract final class AppRoute {
  static String initialLocation = Routes.home;

  static final _review = GoRoute(
    path: Routes.review,
    builder: (context, state) => const Review(),
  );

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const Home(),
        routes: [
          GoRoute(
            path: Routes.detail,
            builder: (context, state) => const Detail(),
            routes: [_review],
          )
        ],
      ),
      GoRoute(
        path: Routes.category,
        builder: (context, state) => const Category(),
        routes: [_review],
      )
    ],
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoute.router,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/detail'),
              child: const Text('Go to Details'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go("/category"),
              child: const Text('Go to Category'),
            )
          ],
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/detail/review'),
              child: const Text('Go to Review'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            )
          ],
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  const Review({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/category/review"),
          child: const Text('Review'),
        ),
      ),
    );
  }
}

