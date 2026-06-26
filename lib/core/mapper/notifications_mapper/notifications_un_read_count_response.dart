import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';
import 'package:flower/features/notifications/domain/entity/notification_unread_count_entity.dart';

extension NotificationsUnreadCountResponseMapper
    on NotificationUnreadCountResponse {
  NotificationUnReadCountEntity toDomain() {
    return NotificationUnReadCountEntity(
      message: message ?? '',
      unreadCount: unreadCount ?? 0,
    );
  }
}
