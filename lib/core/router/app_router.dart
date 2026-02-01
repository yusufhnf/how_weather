import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/login/login.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../cubit/app_cubit.dart';

class AppRouter {
  static const String loginRoute = '/';
  static const String dashboardRoute = '/dashboard';

  static GoRouter router(AppCubit appCubit) {
    return GoRouter(
      initialLocation: loginRoute,
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(appCubit.stream),
      redirect: (context, state) {
        final isLoggedIn = appCubit.state.userLogged != null;

        final isLoginRoute = state.uri.path == loginRoute;
        final isDashboardRoute = state.uri.path == dashboardRoute;

        if (isLoggedIn && isLoginRoute) {
          return dashboardRoute;
        } else if (!isLoggedIn && isDashboardRoute) {
          return loginRoute;
        }

        return null;
      },
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
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
