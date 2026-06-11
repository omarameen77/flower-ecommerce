import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/notifications/domain/entity/notification_unread_count_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:flower/features/notifications/domain/usecases/get_un_read_notification_count_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_un_read_notification_count_use_case_test.mocks.dart';

@GenerateMocks([NotificationsRepoContract])
void main() {
  late MockNotificationsRepoContract mockRepo;
  late GetUnReadNotificationCountUseCase useCase;
  late NotificationUnReadCountEntity responseEntity;

  setUpAll(() {
    responseEntity = const NotificationUnReadCountEntity(
      message: '',
      unreadCount: 0,
    );

    provideDummy<BaseResponse<NotificationUnReadCountEntity>>(
      SuccessBaseResponse<NotificationUnReadCountEntity>(data: responseEntity),
    );
  });

  setUp(() {
    mockRepo = MockNotificationsRepoContract();
    useCase = GetUnReadNotificationCountUseCase(mockRepo);
  });

  group('get unread notification count usecase', () {
    test('should call repo.getUnReadNotificationsCount', () async {
      when(mockRepo.getUnReadNotificationsCount()).thenAnswer(
        (_) async => SuccessBaseResponse<NotificationUnReadCountEntity>(
          data: responseEntity,
        ),
      );

      final result = await useCase.call();

      expect(result, isA<SuccessBaseResponse<NotificationUnReadCountEntity>>());
      verify(mockRepo.getUnReadNotificationsCount()).called(1);
    });

    test('should propagate error when repo fails', () async {
      final failure = Failure(message: 'error');

      when(mockRepo.getUnReadNotificationsCount()).thenAnswer(
        (_) async =>
            ErrorBaseResponse<NotificationUnReadCountEntity>(failure: failure),
      );

      final result = await useCase.call();

      expect(result, isA<ErrorBaseResponse<NotificationUnReadCountEntity>>());
      expect(
        (result as ErrorBaseResponse<NotificationUnReadCountEntity>)
            .failure
            .message,
        'error',
      );
    });
  });
}
