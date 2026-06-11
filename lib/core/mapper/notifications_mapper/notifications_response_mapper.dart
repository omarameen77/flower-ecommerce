import 'package:flower/core/mapper/notifications_mapper/notifications_mapper.dart';
import 'package:flower/core/mapper/notifications_mapper/notifications_meta_data_mapper.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/domain/entity/metadata_notification_entity.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';

extension NotificationsResponseMapper on NotificationsResponse {
  NotificationsResponseEntity toDomain() {
    return NotificationsResponseEntity(
      message: message ?? '',
      metadata:
          metadata?.toDomain() ??
          const MetadataNotificationEntity(
            currentPage: 0,
            totalPages: 0,
            limit: 0,
            totalItems: 0,
            unreadCount: 0,
          ),
      notifications: notifications?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
