import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/notifications/api/api_client/notifications_api_clint.dart';
import 'package:flower/features/notifications/api/datasource/notifications_remote_data_source_impl.dart';
import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([NotificationsApiClient, SafeApiCaller])
void main() {
  late MockNotificationsApiClient mockApiClient;
  late MockSafeApiCaller mockSafeApiCaller;
  late NotificationsRemoteDataSourceImpl dataSource;

  setUpAll(() {
    provideDummy<BaseResponse<NotificationsResponse>>(
      SuccessBaseResponse<NotificationsResponse>(data: NotificationsResponse()),
    );
    provideDummy<BaseResponse<NotificationUnreadCountResponse>>(
      SuccessBaseResponse<NotificationUnreadCountResponse>(
        data: NotificationUnreadCountResponse(),
      ),
    );
    provideDummy<BaseResponse<dynamic>>(
      SuccessBaseResponse<dynamic>(data: NotificationsResponse()),
    );
  });

  setUp(() {
    mockApiClient = MockNotificationsApiClient();
    mockSafeApiCaller = MockSafeApiCaller();

    dataSource = NotificationsRemoteDataSourceImpl(
      mockApiClient,
      mockSafeApiCaller,
    );
  });

  group('notifications remote data source impl', () {
    group('getUserNotifications', () {
      test(
        'should return SuccessBaseResponse<NotificationsResponse> when api call succeeds',
        () async {
          final responseDto = NotificationsResponse();

          when(mockSafeApiCaller.safeCall(any)).thenAnswer(
            (_) async =>
                SuccessBaseResponse<NotificationsResponse>(data: responseDto),
          );

          final result = await dataSource.getUserNotifications();

          expect(result, isA<SuccessBaseResponse<NotificationsResponse>>());
          verify(mockSafeApiCaller.safeCall(any)).called(1);
        },
      );
    });

    group('getUserNotificationsCount', () {
      test(
        'should return SuccessBaseResponse<UnReadCountResponse> when api call succeeds',
        () async {
          final responseDto = NotificationUnreadCountResponse();

          when(mockSafeApiCaller.safeCall(any)).thenAnswer(
            (_) async => SuccessBaseResponse<NotificationUnreadCountResponse>(
              data: responseDto,
            ),
          );

          final result = await dataSource.getUserNotificationsCount();

          expect(
            result,
            isA<SuccessBaseResponse<NotificationUnreadCountResponse>>(),
          );
          verify(mockSafeApiCaller.safeCall(any)).called(1);
        },
      );
    });
  });
}
