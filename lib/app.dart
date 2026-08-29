import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/app_router.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/theme/app_theme.dart';
import 'package:flower/features/address/presentation/saved_addresses/cubit/saved_addresses_cubit.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>.value(value: getIt<CartCubit>()),
        BlocProvider<SavedAddressesCubit>.value(
          value: getIt<SavedAddressesCubit>(),
        ),
      ],
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
