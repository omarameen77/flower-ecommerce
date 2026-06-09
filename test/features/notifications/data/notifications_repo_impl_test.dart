import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/notifications/data/datasource/notifications_remote_data_source_contract.dart';
import 'package:flower/features/notifications/data/model/notifications_response_dto.dart';
import 'package:flower/features/notifications/data/model/un_read_count_response.dart';
import 'package:flower/features/notifications/data/repository/notifications_repo_impl.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';
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
    provideDummy<BaseResponse<UnReadCountResponse>>(
      SuccessBaseResponse<UnReadCountResponse>(data: UnReadCountResponse()),
    );
    provideDummy<BaseResponse<NotificationsResponseEntity>>(
      SuccessBaseResponse<NotificationsResponseEntity>(
        data: NotificationsResponseEntity(),
      ),
    );
    provideDummy<BaseResponse<UnReadCountEntity>>(
      SuccessBaseResponse<UnReadCountEntity>(data: UnReadCountEntity()),
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
          final dto = UnReadCountResponse();

          when(mockRemoteDataSource.getUserNotificationsCount()).thenAnswer(
            (_) async => SuccessBaseResponse<UnReadCountResponse>(data: dto),
          );

          final result = await repo.getUnReadNotificationsCount();

          expect(result, isA<SuccessBaseResponse<UnReadCountEntity>>());
          verify(mockRemoteDataSource.getUserNotificationsCount()).called(1);
        },
      );

      test('should preserve failure when datasource fails', () async {
        final failure = Failure(message: 'error');

        when(mockRemoteDataSource.getUserNotificationsCount()).thenAnswer(
          (_) async => ErrorBaseResponse<UnReadCountResponse>(failure: failure),
        );

        final result = await repo.getUnReadNotificationsCount();

        expect(result, isA<ErrorBaseResponse<UnReadCountEntity>>());
        expect(
          (result as ErrorBaseResponse<UnReadCountEntity>).failure.message,
          'error',
        );
      });
    });
  });
}
