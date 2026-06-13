import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'notifications_api_clint.g.dart';

@RestApi()
abstract class NotificationsApiClient {
  @factoryMethod
  factory NotificationsApiClient(Dio dio, {String baseUrl}) =
      _NotificationsApiClient;

  @GET(NotificationsEndPoints.getUserNotifications)
  Future<NotificationsResponse> getUserNotifications();

  @GET(NotificationsEndPoints.unReadCount)
  Future<NotificationUnreadCountResponse> getUserNotificationsCount();
}
