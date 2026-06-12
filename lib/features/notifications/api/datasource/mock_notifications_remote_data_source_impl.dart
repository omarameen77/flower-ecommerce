import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/data/datasource/notifications_remote_data_source_contract.dart';
import 'package:flower/features/notifications/data/model/notifications_dto.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRemoteDataSourceContract)
class MockNotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSourceContract {
  @override
  Future<BaseResponse<NotificationsResponse>> getUserNotifications() async {
    await Future.delayed(const Duration(seconds: 2));

    final mockResponse = NotificationsResponse(
      message: "success",
      notifications: [
        NotificationsDto(
          id: "mock_1",
          title: "New offer 😍",
          body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          type: "offer",
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
        NotificationsDto(
          id: "mock_2",
          title: "Order Shipped 🚚",
          body: "Your flower order #54321 has been delivered safely.",
          type: "order",
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        NotificationsDto(
          id: "mock_3",
          title: "New Message 💬",
          body: "You have a new message from our support team.",
          type: "message",
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        NotificationsDto(
          id: "mock_4",
          title: "Spring Sale 🌸",
          body: "Enjoy 20% off on all spring collection items.",
          type: "offer",
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        NotificationsDto(
          id: "mock_5",
          title: "Order Delivered 📦",
          body: "Your flower order #12345 has been delivered successfully.",
          type: "order",
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ],
    );

    return SuccessBaseResponse<NotificationsResponse>(data: mockResponse);
  }

  @override
  Future<BaseResponse<NotificationUnreadCountResponse>>
  getUserNotificationsCount() async {
    await Future.delayed(const Duration(seconds: 1));

    final mockCountResponse = NotificationUnreadCountResponse(
      message: "success",
      unreadCount: 5,
    );

    return SuccessBaseResponse<NotificationUnreadCountResponse>(
      data: mockCountResponse,
    );
  }
}
