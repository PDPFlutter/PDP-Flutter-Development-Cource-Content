import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: "home",
      path: '/',
      builder: (context, state) => const Home(),
      routes: [
        GoRoute(
          name: "details",
          path: 'details',
          builder: (context, state) => Detail(extra: state.extra as String),
          routes: [
            GoRoute(
              name: "review",
              path: 'review',
              builder: (context, state) => const Review(),
            )
          ],
        )
      ],
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
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
        child: ElevatedButton(
          onPressed: () => context.goNamed('details', extra: "Hello"),
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final String extra;
  const Detail({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail: $extra')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details/review'),
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
