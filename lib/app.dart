import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/routes/app_router.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
