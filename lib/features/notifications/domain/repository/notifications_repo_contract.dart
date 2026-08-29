import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';

abstract interface class NotificationsRepoContract {
  Stream<List<NotificationsEntity>> getUserNotifications(String userId);

  Stream<int> getUnreadNotificationsCount(String userId);

  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  });
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  });
}
