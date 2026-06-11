import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/notifications/api/api_client/notifications_api_clint.dart';
import 'package:flower/features/notifications/data/datasource/notifications_remote_data_source_contract.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSourceContract {
  final NotificationsApiClient apiClient;
  final SafeApiCaller caller;

  NotificationsRemoteDataSourceImpl(this.apiClient, this.caller);
  @override
  Future<BaseResponse<NotificationsResponse>> getUserNotifications() async {
    final response = await caller.safeCall(() async {
      final dto = await apiClient.getUserNotifications();
      return dto;
    });

    return response;
  }

  @override
  Future<BaseResponse<NotificationUnreadCountResponse>>
  getUserNotificationsCount() {
    final response = caller.safeCall(() async {
      final dto = await apiClient.getUserNotificationsCount();
      return dto;
    });

    return response;
  }
}
