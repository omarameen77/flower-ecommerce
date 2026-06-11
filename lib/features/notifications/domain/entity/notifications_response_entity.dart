import 'package:equatable/equatable.dart';
import 'package:flower/features/notifications/domain/entity/metadata_notification_entity.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';

class NotificationsResponseEntity extends Equatable {
  final String message;
  final MetadataNotificationEntity metadata;
  final List<NotificationsEntity> notifications;

  const NotificationsResponseEntity({
    required this.message,
    required this.metadata,
    required this.notifications,
  });

  @override
  List<Object> get props => [message, metadata, notifications];
}
