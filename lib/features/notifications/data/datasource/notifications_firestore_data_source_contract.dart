import 'package:flower/features/notifications/data/model/notifications_dto.dart';

abstract interface class NotificationsFirestoreDataSourceContract {
  Stream<List<NotificationsDto>> getUserNotifications(String userId);

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
