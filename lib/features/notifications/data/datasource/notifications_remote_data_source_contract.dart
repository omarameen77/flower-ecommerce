import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/un_read_count_response.dart';

abstract class NotificationsRemoteDataSourceContract {
  Future<BaseResponse<NotificationsResponse>> getUserNotifications();
  Future<BaseResponse<UnReadCountResponse>> getUserNotificationsCount();
}
