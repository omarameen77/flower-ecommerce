import 'package:easy_localization/easy_localization.dart';

class NotificationsConstants {
  NotificationsConstants._();
  static String get title => 'notifications.title'.tr();
  static String get noNotificationsFound =>
      'notifications.no_notifications_found'.tr();
  static String get errorTitle => 'notifications.error_title'.tr();
  static String get retry => 'notifications.retry'.tr();
  static String get userNotFound => 'notifications.user_not_found'.tr();
  static String get notificationDeleted =>
      'notifications.notification_deleted'.tr();

  // Skeleton-loading placeholder shapes only; never actually shown to users.
  static const String dummyLoadingId = 'skeleton';
  static const String dummyLoadingTitle =
      'This is a dummy long title for loading';
  static const String dummyLoadingBody =
      'This is a dummy long description body to test the skeletonizer effect layout clearly.';
}
