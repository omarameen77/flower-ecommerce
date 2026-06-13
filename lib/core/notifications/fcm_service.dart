import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower/core/notifications/local_notification_service.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final LocalNotificationService _localNotificationService;

  FcmService(this._localNotificationService);

  Future<void> initialize() async {
    await _requestPermissions();

    await _setupForegroundOptions();

    _listenToNotifications();

    _listenToTokenRefresh();

    await _handleInitialMessage();

    await _getDeviceToken();
  }

  Future<void> _requestPermissions() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<void> _setupForegroundOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _listenToNotifications() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification != null) {
        _localNotificationService.showNotification(
          title: notification.title,
          body: notification.body,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  Future<void> _handleInitialMessage() async {
    await _messaging.getInitialMessage();
  }

  Future<String?> _getDeviceToken() async {
    return _messaging.getToken();
  }

  void _listenToTokenRefresh() {
    _messaging.onTokenRefresh.listen((token) {});
  }
}
