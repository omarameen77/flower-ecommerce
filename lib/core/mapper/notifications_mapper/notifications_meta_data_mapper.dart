import 'package:flower/features/notifications/data/model/metadata_notification_dto.dart';
import 'package:flower/features/notifications/domain/entity/metadata_notification_entity.dart';

extension MetadataNotificationMapper on MetadataNotificationDto {
  MetadataNotificationEntity toDomain() {
    return MetadataNotificationEntity(
      currentPage: currentPage ?? 0,
      totalPages: totalPages ?? 0,
      limit: limit ?? 0,
      totalItems: totalItems ?? 0,
      unreadCount: unreadCount ?? 0,
    );
  }
}
