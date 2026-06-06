import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower/app.dart';
import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/core/notifications/notification_initializer.dart';
import 'package:flower/core/resources/app_value.dart';
import 'package:flower/core/service/crashlytics_service.dart';
import 'package:flower/firebase_options.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DioHelper.init();
  configureDependencies();
  await getIt<CrashlyticsService>().init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await EasyLocalization.ensureInitialized();
  await getIt<NotificationInitializer>().initialize();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppKeys.enLocale),
        Locale(AppKeys.arLocale),
      ],
      path: AppKeys.translationPath,
      child: const FlowerApp(),
    ),
  );
}
