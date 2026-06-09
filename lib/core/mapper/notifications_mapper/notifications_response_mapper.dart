import 'package:flower/core/mapper/notifications_mapper/notifications_mapper.dart';
import 'package:flower/core/mapper/notifications_mapper/notifications_meta_data_mapper.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';

extension NotificationsResponseMapper on NotificationsResponse {
  NotificationsResponseEntity toDomain() {
    return NotificationsResponseEntity(
      message: message,
      metadata: metadata?.toDomain(),
      notifications: notifications?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
