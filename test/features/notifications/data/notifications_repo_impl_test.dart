import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/notifications/data/datasource/notifications_remote_data_source_contract.dart';
import 'package:flower/features/notifications/data/model/notification_unread_count_response.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/repository/notifications_repo_impl.dart';
import 'package:flower/features/notifications/domain/entity/metadata_notification_entity.dart';
import 'package:flower/features/notifications/domain/entity/notification_unread_count_entity.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_repo_impl_test.mocks.dart';

@GenerateMocks([NotificationsRemoteDataSourceContract])
void main() {
  late MockNotificationsRemoteDataSourceContract mockRemoteDataSource;
  late NotificationsRepoImpl repo;

  setUpAll(() {
    provideDummy<BaseResponse<NotificationsResponse>>(
      SuccessBaseResponse<NotificationsResponse>(data: NotificationsResponse()),
    );
    provideDummy<BaseResponse<NotificationUnreadCountResponse>>(
      SuccessBaseResponse<NotificationUnreadCountResponse>(
        data: NotificationUnreadCountResponse(),
      ),
    );
    provideDummy<BaseResponse<NotificationsResponseEntity>>(
      SuccessBaseResponse<NotificationsResponseEntity>(
        data: NotificationsResponseEntity(
          message: '',
          metadata: const MetadataNotificationEntity(
            currentPage: 1,
            totalPages: 1,
            limit: 0,
            totalItems: 0,
            unreadCount: 0,
          ),
          notifications: const [],
        ),
      ),
    );
    provideDummy<BaseResponse<NotificationUnReadCountEntity>>(
      SuccessBaseResponse<NotificationUnReadCountEntity>(
        data: const NotificationUnReadCountEntity(message: '', unreadCount: 0),
      ),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockNotificationsRemoteDataSourceContract();
    repo = NotificationsRepoImpl(mockRemoteDataSource);
  });

  group('notifications repo impl', () {
    group('getUserNotifications', () {
      test(
        'should return SuccessBaseResponse<NotificationsResponseEntity> when datasource succeeds',
        () async {
          final dto = NotificationsResponse();

          when(mockRemoteDataSource.getUserNotifications()).thenAnswer(
            (_) async => SuccessBaseResponse<NotificationsResponse>(data: dto),
          );

          final result = await repo.getUserNotifications();

          expect(
            result,
            isA<SuccessBaseResponse<NotificationsResponseEntity>>(),
          );
          verify(mockRemoteDataSource.getUserNotifications()).called(1);
        },
      );

      test('should preserve failure when datasource fails', () async {
        final failure = Failure(message: 'error');

        when(mockRemoteDataSource.getUserNotifications()).thenAnswer(
          (_) async =>
              ErrorBaseResponse<NotificationsResponse>(failure: failure),
        );

        final result = await repo.getUserNotifications();

        expect(result, isA<ErrorBaseResponse<NotificationsResponseEntity>>());
        expect(
          (result as ErrorBaseResponse<NotificationsResponseEntity>)
              .failure
              .message,
          'error',
        );
      });
    });

    group('getUnReadNotificationsCount', () {
      test(
        'should return SuccessBaseResponse<UnReadCountEntity> when datasource succeeds',
        () async {
          final dto = NotificationUnreadCountResponse();

          when(mockRemoteDataSource.getUserNotificationsCount()).thenAnswer(
            (_) async =>
                SuccessBaseResponse<NotificationUnreadCountResponse>(data: dto),
          );

          final result = await repo.getUnReadNotificationsCount();

          expect(
            result,
            isA<SuccessBaseResponse<NotificationUnReadCountEntity>>(),
          );
          verify(mockRemoteDataSource.getUserNotificationsCount()).called(1);
        },
      );

      test('should preserve failure when datasource fails', () async {
        final failure = Failure(message: 'error');

        when(mockRemoteDataSource.getUserNotificationsCount()).thenAnswer(
          (_) async => ErrorBaseResponse<NotificationUnreadCountResponse>(
            failure: failure,
          ),
        );

        final result = await repo.getUnReadNotificationsCount();

        expect(result, isA<ErrorBaseResponse<NotificationUnReadCountEntity>>());
        expect(
          (result as ErrorBaseResponse<NotificationUnReadCountEntity>)
              .failure
              .message,
          'error',
        );
      });
    });
  });
}
