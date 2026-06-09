import 'package:flower/features/notifications/data/model/notifications_dto.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';

extension NotificationsMapper on NotificationsDto {
  NotificationsEntity toDomain() {
    return NotificationsEntity(
      id: id,
      title: title,
      body: body,
      type: type,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}
