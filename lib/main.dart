import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower/app.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  DioHelper.init();
  configureDependencies();
  // // استدعاء وتشغيل الـ Notification Service
  // final notificationService = NotificationService();
  // await notificationService.requestPermissions();
  // await notificationService.initLocalNotifications();
  // notificationService.listenToNotifications();
  // await notificationService
  //     .getDeviceToken(); // عشان يطبعلك الـ Token في الـ Console

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
