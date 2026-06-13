import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';

abstract interface class NotificationsRemoteDataSourceContract {
  Future<BaseResponse<NotificationsResponse>> getUserNotifications();
  Future<BaseResponse<NotificationUnreadCountResponse>>
  getUserNotificationsCount();
}
