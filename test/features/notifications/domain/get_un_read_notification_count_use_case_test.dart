import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';
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
  late UnReadCountEntity responseEntity;

  setUpAll(() {
    responseEntity = UnReadCountEntity();

    provideDummy<BaseResponse<UnReadCountEntity>>(
      SuccessBaseResponse<UnReadCountEntity>(data: UnReadCountEntity()),
    );
  });

  setUp(() {
    mockRepo = MockNotificationsRepoContract();
    useCase = GetUnReadNotificationCountUseCase(mockRepo);
  });

  group('get unread notification count usecase', () {
    test('should call repo.getUnReadNotificationsCount', () async {
      when(mockRepo.getUnReadNotificationsCount()).thenAnswer(
        (_) async =>
            SuccessBaseResponse<UnReadCountEntity>(data: responseEntity),
      );

      final result = await useCase.call();

      expect(result, isA<SuccessBaseResponse<UnReadCountEntity>>());
      verify(mockRepo.getUnReadNotificationsCount()).called(1);
    });

    test('should propagate error when repo fails', () async {
      final failure = Failure(message: 'error');

      when(mockRepo.getUnReadNotificationsCount()).thenAnswer(
        (_) async => ErrorBaseResponse<UnReadCountEntity>(failure: failure),
      );

      final result = await useCase.call();

      expect(result, isA<ErrorBaseResponse<UnReadCountEntity>>());
      expect(
        (result as ErrorBaseResponse<UnReadCountEntity>).failure.message,
        'error',
      );
    });
  });
}
