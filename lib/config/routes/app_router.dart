import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/page_transitions.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/widgets/not_found_screen.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/pages/forget_password_screen.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/pages/reset_password_screen.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/pages/verify_reset_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.forgetPassword:
          return PageTransitions.fade(
            BlocProvider(
              create: (_) => getIt<ForgetPasswordCubit>(),
              child: const ForgetPasswordScreen(),
            ),
          );

        case Routes.verificationCode:
          final email = settings.arguments as String? ?? '';
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<VerifyResetCodeCubit>(),
              child: VerifyResetCodeScreen(email: email),
            ),
          );

        case Routes.resetPassword:
          final email = settings.arguments as String? ?? '';
          return PageTransitions.slide(
            BlocProvider(
              create: (_) => getIt<ResetPasswordCubit>(),
              child: ResetPasswordScreen(email: email),
            ),
          );

        default:
          return PageTransitions.fade(
            NotFoundScreen(route: settings.name ?? ''),
          );
      }
    } catch (_) {
      return PageTransitions.fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }
}
