import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/notifications/domain/entity/metadata_notification_entity.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:flower/features/notifications/domain/usecases/get_user_notifications_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_notifications_use_case_test.mocks.dart';

@GenerateMocks([NotificationsRepoContract])
void main() {
  late MockNotificationsRepoContract mockRepo;
  late GetUserNotificationsUseCase useCase;
  late NotificationsResponseEntity responseEntity;

  setUpAll(() {
    responseEntity = NotificationsResponseEntity(
      message: '',
      metadata: const MetadataNotificationEntity(
        currentPage: 1,
        totalPages: 1,
        limit: 0,
        totalItems: 0,
        unreadCount: 0,
      ),
      notifications: const [],
    );

    provideDummy<BaseResponse<NotificationsResponseEntity>>(
      SuccessBaseResponse<NotificationsResponseEntity>(data: responseEntity),
    );
  });

  setUp(() {
    mockRepo = MockNotificationsRepoContract();
    useCase = GetUserNotificationsUseCase(mockRepo);
  });

  group('get user notifications usecase', () {
    test('should call repo.getUserNotifications', () async {
      when(mockRepo.getUserNotifications()).thenAnswer(
        (_) async => SuccessBaseResponse<NotificationsResponseEntity>(
          data: responseEntity,
        ),
      );

      final result = await useCase.call();

      expect(result, isA<SuccessBaseResponse<NotificationsResponseEntity>>());
      verify(mockRepo.getUserNotifications()).called(1);
    });

    test('should propagate error when repo fails', () async {
      final failure = Failure(message: 'error');

      when(mockRepo.getUserNotifications()).thenAnswer(
        (_) async =>
            ErrorBaseResponse<NotificationsResponseEntity>(failure: failure),
      );

      final result = await useCase.call();

      expect(result, isA<ErrorBaseResponse<NotificationsResponseEntity>>());
      expect(
        (result as ErrorBaseResponse<NotificationsResponseEntity>)
            .failure
            .message,
        'error',
      );
    });
  });
}
