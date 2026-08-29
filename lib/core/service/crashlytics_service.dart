import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CrashlyticsService {
  Future<void> init() async {
    if (kReleaseMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  Future<void> recordCustomError(
    dynamic error,
    StackTrace? stack, {
    dynamic reason,
  }) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      reason: reason,
    );
  }
}
