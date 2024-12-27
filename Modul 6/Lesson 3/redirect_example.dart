import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthState {
  bool isSignedIn = false;

  static AuthState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AuthStateWidget>()!.state;
}

class AuthStateWidget extends InheritedWidget {
  final AuthState state;

  const AuthStateWidget({
    super.key,
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(AuthStateWidget oldWidget) => oldWidget.state != state;
}

void main() {
  final authState = AuthState(); 

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
    // Top-level redirect
    redirect: (context, state) {
      final auth = AuthState.of(context);
      final isSignedIn = auth.isSignedIn;
      final isOnSignInPage = state.uri.path == '/signin';

      if (!isSignedIn && !isOnSignInPage) {
        return '/signin';
      }

      if (isSignedIn && isOnSignInPage) {
        return '/dashboard';
      }

      return null;
    },
  );

  runApp(MyApp(authState: authState, router: router));
}

class MyApp extends StatelessWidget {
  final AuthState authState;
  final GoRouter router;

  const MyApp({super.key, required this.authState, required this.router});

  @override
  Widget build(BuildContext context) {
    return AuthStateWidget(
      state: authState,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/signin');
          },
          child: const Text('Go to Sign In'),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthState.of(context).isSignedIn = true;
            context.go('/dashboard');
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthState.of(context).isSignedIn = false;
            context.go('/');
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
