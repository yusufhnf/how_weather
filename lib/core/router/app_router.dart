import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/login/login.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';

class AppRouter {
  static const String loginRoute = '/';
  static const String dashboardRoute = '/dashboard';

  static final GoRouter router = GoRouter(
    initialLocation: loginRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: dashboardRoute,
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );
}
