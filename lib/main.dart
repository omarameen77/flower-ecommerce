import 'package:easy_localization/easy_localization.dart';
import 'package:flower/app.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DioHelper.init();
  configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const FlowerApp(),
    ),
  );
}
