import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/widgets/not_found_screen.dart';
import 'package:flower/features/app_sections/presentation/pages/app_sections_page.dart';
import 'package:flower/features/auth/login/ui/screen/login_screen.dart';
import 'package:flower/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //* example:
      case Routes.splash:
        return _fade(const SplashScreen());

      case Routes.appSections:
        return _slide(const AppSectionsPage());

      case Routes.login:
        return _slide(const LoginScreen());

      default:
        return _fade(NotFoundScreen(route: settings.name ?? ''));
    }
  }

  //  Transition
  static PageRoute<T> _fade<T>(Widget page) => PageRouteBuilder<T>(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, a, __, child) =>
        FadeTransition(opacity: a, child: child),
    transitionDuration: const Duration(milliseconds: 300),
  );

  static PageRoute<T> _slide<T>(Widget page) => PageRouteBuilder<T>(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, a, __, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
      child: child,
    ),
    transitionDuration: const Duration(milliseconds: 350),
  );
}
