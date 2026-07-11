import 'package:injectable/injectable.dart';
import 'fcm_service.dart';
import 'local_notification_service.dart';

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
