import 'package:flower/features/notifications/data/model/un_read_count_response.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';

extension GetUnReadNotificationCountMapper on UnReadCountResponse {
  UnReadCountEntity toDomain() {
    return UnReadCountEntity(message: message, unreadCount: unreadCount);
  }
}
