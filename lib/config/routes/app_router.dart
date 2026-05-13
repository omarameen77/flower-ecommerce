import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/page_transitions.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/widgets/not_found_screen.dart';
import 'package:flower/features/app_sections/presentation/pages/app_sections_page.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/pages/forget_password_screen.dart';
import 'package:flower/features/auth/presentation/login/pages/login_screen.dart';
import 'package:flower/features/auth/presentation/register/pages/register_page.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/pages/reset_password_screen.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_cubit.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/pages/verify_reset_code_screen.dart';
import 'package:flower/features/product_sections/presentation/best_sellers/pages/best_sellers_page.dart';
import 'package:flower/features/product_sections/presentation/occasions/pages/occasions_page.dart';
import 'package:flower/features/product_sections/presentation/product_details/pages/product_details_page.dart';
import 'package:flower/features/product_sections/presentation/search/search_screen.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/search_cubit/search_cubit.dart';
import 'package:flower/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.login:
          return PageTransitions.fade(const LoginScreen());
        case Routes.splash:
          return PageTransitions.fade(const SplashScreen());

        case Routes.signup:
          return PageTransitions.slide(const RegisterPage());

        case Routes.bestSellers:
          return PageTransitions.slide(const BestSellersPage());

        case Routes.productDetails:
          final id = settings.arguments as String? ?? '';
          return PageTransitions.slide(ProductDetailsPage(productId: id));

        case Routes.appSections:
          return PageTransitions.slide(const AppSectionsPage());

        case Routes.occasions:
          return PageTransitions.slide(const OccasionsPage());

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
        case Routes.searchScreen:
          return PageTransitions.search(
            BlocProvider(
              create: (_) => SearchCubit(getIt()),
              child: const SearchScreen(),
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
