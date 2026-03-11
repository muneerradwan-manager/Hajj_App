import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubits/forget_password/forget_password_cubit.dart';
import '../../features/auth/presentation/cubits/register/register_cubit.dart';
import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/complaints/presentation/cubits/complaint_details/complaint_details_cubit.dart';
import '../../features/complaints/presentation/views/complaint_details.dart';
import '../../features/complaints/presentation/views/complaints_view.dart';
import '../../features/complaints/presentation/views/create_complaint.dart';
import '../../features/evaluations/presentation/views/evaluations_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/home/presentation/views/navigation_bottom.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../constants/app_routes.dart';
import '../di/dependency_injection.dart';

enum PageTransitionDirection {
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop,
  none,
}

class AppRouter {
  const AppRouter._();

  static CustomTransitionPage<void> fadeSlidePage({
    required GoRouterState state,
    required Widget child,
    PageTransitionDirection direction = PageTransitionDirection.rightToLeft,
    Duration duration = const Duration(milliseconds: 320),
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
          duration: const Duration(milliseconds: 450),
        ),
      ),

      GoRoute(
        name: AppRoutes.forgetPasswordName,
        path: AppRoutes.forgetPasswordPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordView(),
          ),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.registerName,
        path: AppRoutes.registerPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: BlocProvider(
            create: (_) => getIt<RegisterCubit>()..initialize(),
            child: const RegisterView(),
          ),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.navigationBottomName,
        path: AppRoutes.navigationBottomPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const NavigationBottom(),
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

      GoRoute(
        name: AppRoutes.profileName,
        path: AppRoutes.profilePath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const ProfileView(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.complaintsName,
        path: AppRoutes.complaintsPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const ComplaintsView(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.createComplaintName,
        path: AppRoutes.createComplaintPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const CreateComplaint(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),

      GoRoute(
        name: AppRoutes.complaintDetailsName,
        path: AppRoutes.complaintDetailsPath,
        pageBuilder: (context, state) {
          final idParam = state.pathParameters['id'];
          final complaintId = int.tryParse(idParam ?? '') ?? 0;

          return fadeSlidePage(
            state: state,
            child: BlocProvider(
              create: (_) =>
                  getIt<ComplaintDetailsCubit>()..loadComplaint(complaintId),
              child: const ComplaintDetails(),
            ),
            direction: PageTransitionDirection.bottomToTop,
          );
        },
      ),

      GoRoute(
        name: AppRoutes.evaluationsName,
        path: AppRoutes.evaluationsPath,
        pageBuilder: (context, state) => fadeSlidePage(
          state: state,
          child: const EvaluationsView(),
          direction: PageTransitionDirection.bottomToTop,
        ),
      ),
    ],
  );
}
