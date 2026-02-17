import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hajj_app/core/constants/app_routes.dart';
import 'package:hajj_app/features/auth/presentation/views/forget_password_view.dart';
import 'package:hajj_app/features/auth/presentation/views/login_view.dart';
import 'package:hajj_app/features/home/presentation/views/home_view.dart';
import 'package:hajj_app/features/splash/presentation/views/splash_view.dart';

enum PageTransitionDirection {
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
  none,
}

class AppRouter {
  const AppRouter._();

  static CustomTransitionPage fadeSlidePage({
    required GoRouterState state,
    required Widget child,
    PageTransitionDirection direction = PageTransitionDirection.rightToLeft,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOut,
    double distance = 0.08,
    bool fade = true,
  }) {
    Offset beginOffset;
    switch (direction) {
      case PageTransitionDirection.rightToLeft:
        beginOffset = Offset(distance, 0);
        break;
      case PageTransitionDirection.leftToRight:
        beginOffset = Offset(-distance, 0);
        break;
      case PageTransitionDirection.topToBottom:
        beginOffset = Offset(0, -distance);
        break;
      case PageTransitionDirection.bottomToTop:
        beginOffset = Offset(0, distance);
        break;
      case PageTransitionDirection.none:
        beginOffset = Offset.zero;
        break;
    }

    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: curve);

        final slide = SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );

        if (!fade) return slide;

        return FadeTransition(opacity: curved, child: slide);
      },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashPath,
    routes: <RouteBase>[
      GoRoute(
        name: AppRoutes.splashName,
        path: AppRoutes.splashPath,
        builder: (context, state) => const SplashPage(), // no animation
      ),

      GoRoute(
        name: AppRoutes.loginName,
        path: AppRoutes.loginPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const LoginPage(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.forgetPasswordName,
        path: AppRoutes.forgetPasswordPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const ForgetPasswordView(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.homeName,
        path: AppRoutes.homePath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const HomeView(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),
    ],
  );
}
