import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/widgets/not_found_screen.dart';
import 'package:flower/features/auth/presentation/forget_password/pages/forget_password_screen.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/pages/reset_password_screen.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/pages/verify_reset_code_screen.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.forgetPassword:
        return _fade(_forgetPasswordRoute());
      case Routes.verificationCode:
        return _slide(_verificationRoute(settings));
      case Routes.resetPassword:
        return _slide(_resetPasswordRoute(settings));
      default:
        return _fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }

  static Widget _forgetPasswordRoute() => BlocProvider(
    create: (_) => getIt<ForgetPasswordCubit>(),
    child: const ForgetPasswordScreen(),
  );

  static Widget _verificationRoute(RouteSettings settings) {
    final email = settings.arguments as String? ?? '';
    return BlocProvider(
      create: (_) => getIt<VerifyResetCodeCubit>(),
      child: VerifyResetCodeScreen(email: email),
    );
  }

  static Widget _resetPasswordRoute(RouteSettings settings) {
    final email = settings.arguments as String? ?? '';
    return BlocProvider(
      create: (_) => getIt<ResetPasswordCubit>(),
      child: ResetPasswordScreen(email: email),
    );
  }

  static PageRoute<T> _fade<T>(Widget page) => PageRouteBuilder<T>(
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, a, _, child) =>
        FadeTransition(opacity: a, child: child),
    transitionDuration: const Duration(milliseconds: 300),
  );

  static PageRoute<T> _slide<T>(Widget page) => PageRouteBuilder<T>(
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, a, _, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
      child: child,
    ),
    transitionDuration: const Duration(milliseconds: 350),
  );
}
