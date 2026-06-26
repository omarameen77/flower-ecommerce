import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/entity/notification_unread_count_entity.dart';

abstract interface class NotificationsRepoContract {
  Future<BaseResponse<NotificationsResponseEntity>> getUserNotifications();
  Future<BaseResponse<NotificationUnReadCountEntity>>
  getUnReadNotificationsCount();
}
