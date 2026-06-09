import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';

abstract class NotificationsRepoContract {
  Future<BaseResponse<NotificationsResponseEntity>> getUserNotifications();
  Future<BaseResponse<UnReadCountEntity>> getUnReadNotificationsCount();
}
