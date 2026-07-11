import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flower/core/notifications/firestore_notification_service.dart';
import 'package:flower/core/notifications/local_notification_service.dart';
import 'package:flower/core/storage/secure_storage_service.dart';

@lazySingleton
class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotificationService;
  final FirestoreService _firestoreService;

  FcmService(this._localNotificationService, this._firestoreService);

  Future<void> initialize() async {
    await _requestPermissions();
    await _setupForegroundOptions();
    _listenToForegroundNotifications();
    _listenToNotificationOpened();
    _listenToTokenRefresh();
    await _handleInitialMessage();

    final token = await getToken();

    debugPrint("FCM TOKEN = $token");
    debugPrint("TOKEN LENGTH = ${token?.length}");
  }

  //================ Permissions =================

  Future<void> _requestPermissions() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  //================ Foreground =================

  Future<void> _setupForegroundOptions() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _listenToForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification == null) return;

      _localNotificationService.showNotification(
        title: notification.title,
        body: notification.body,
        payload: message.data['orderId'],
      );
    });
  }

  //================ Notification Click =================

  void _listenToNotificationOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationNavigation(message);
    });
  }

  Future<void> _handleInitialMessage() async {
    final message = await _messaging.getInitialMessage();

    if (message != null) {
      _handleNotificationNavigation(message);
    }
  }

  void _handleNotificationNavigation(RemoteMessage message) {
    final orderId = message.data['orderId'];

    if (orderId != null) {
      debugPrint("Navigate To Order : $orderId");
    }
  }

  //================ Token =================

  Future<String?> getToken() async {
    return _messaging.getToken();
  }

  Future<void> saveCurrentUserToken() async {
    final token = await getToken();
    final userId = await SecureStorageService.getUserId();
    if (token == null || userId == null || userId.isEmpty) return;
    await _firestoreService.saveUserToken(userId: userId, token: token);
  }

  void _listenToTokenRefresh() {
    _messaging.onTokenRefresh.listen((token) async {
      final userId = await SecureStorageService.getUserId();

      if (userId == null || userId.isEmpty) return;

      await _firestoreService.saveUserToken(userId: userId, token: token);
    });
  }

  //================ Topics =================

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }
}
