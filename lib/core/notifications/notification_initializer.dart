import 'package:flower/core/notifications/fcm_service.dart';
import 'package:flower/core/notifications/local_notification_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationInitializer {
  final FcmService _fcmService;
  final LocalNotificationService _localNotificationService;

  NotificationInitializer(this._fcmService, this._localNotificationService);

  Future<void> initialize() async {
    await _localNotificationService.initialize();

    await _fcmService.initialize();
  }
}
