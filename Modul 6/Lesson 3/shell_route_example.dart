import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state, child) {
        return Main(
          key: state.pageKey,
          currentIndex: switch (state.uri.path) {
            final p when p.startsWith("/home") => 0,
            final p when p.startsWith("/category") => 1,
            final p when p.startsWith("/profile") => 2,
            _ => 0,
          },
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: "home",
          path: '/home',
          builder: (context, state) => const Home(),
          routes: [
            GoRoute(
              name: "details",
              path: 'details',
              parentNavigatorKey: rootNavigatorKey,
              builder: (context, state) => const Detail(),
            )
          ],
        ),
        GoRoute(
          name: "category",
          path: '/category',
          builder: (context, state) => const Category(),
        ),
        GoRoute(
          name: "profile",
          path: '/profile',
          builder: (context, state) => const Profile(),
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

class Main extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const Main({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          if (currentIndex != index) {
            String page = switch (index) {
              0 => "/home",
              1 => "/category",
              2 => "/profile",
              _ => "/home",
            };
            context.go(page);
          }
        },
      ),
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
          onPressed: () {
            context.go("/home/details");
          },
          child: const Text('Go to Detail'),
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Detail'),
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Category'),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
