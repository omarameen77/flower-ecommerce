import 'package:flower/features/notifications/domain/entity/metadata_notification_entity.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';

class NotificationsResponseEntity {
  String? message;
  MetadataNotificationEntity? metadata;
  List<NotificationsEntity>? notifications;

  NotificationsResponseEntity({
    this.message,
    this.metadata,
    this.notifications,
  });
}
