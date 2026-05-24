import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/app_router.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/theme/app_theme.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (_) => getIt<CartCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: Routes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
