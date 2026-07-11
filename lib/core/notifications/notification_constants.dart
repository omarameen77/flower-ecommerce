import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationConstants {
  NotificationConstants._();

  static const channelId = 'flower_notifications';
  static const channelName = 'Flower Notifications';
  static const channelDescription = 'General notifications for Flower App';

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    channelId,
    channelName,
    description: channelDescription,
    importance: Importance.max,
  );
}
