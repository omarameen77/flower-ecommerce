import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';
import 'package:flower/features/notifications/domain/usecases/get_un_read_notification_count_use_case.dart';
import 'package:flower/features/notifications/domain/usecases/get_user_notifications_use_case.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_cubit.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notifications_cubit_test.mocks.dart';

@GenerateMocks([GetUserNotificationsUseCase, GetUnReadNotificationCountUseCase])
void main() {
  late MockGetUserNotificationsUseCase mockGetUserNotificationsUseCase;
  late MockGetUnReadNotificationCountUseCase
  mockGetUnReadNotificationCountUseCase;
  late NotificationsCubit notificationsCubit;

  setUp(() {
    mockGetUserNotificationsUseCase = MockGetUserNotificationsUseCase();
    mockGetUnReadNotificationCountUseCase =
        MockGetUnReadNotificationCountUseCase();

    notificationsCubit = NotificationsCubit(
      getUserNotificationsUseCase: mockGetUserNotificationsUseCase,
      getUnreadCountUseCase: mockGetUnReadNotificationCountUseCase,
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

  tearDown(() {
    notificationsCubit.close();
  });

  test('initial state has correct values', () {
    expect(notificationsCubit.state.notificationsState.isLoading, isFalse);
    expect(notificationsCubit.state.notificationsState.data, isNull);
    expect(notificationsCubit.state.notificationsState.errorMessage, isNull);
    expect(notificationsCubit.state.unreadCount, equals(0));
  });

  test('notificationsState can be updated', () {
    final newState = notificationsCubit.state.copyWith(
      notificationsState: const BaseState<NotificationsResponseEntity>(
        isLoading: true,
      ),
    );

    expect(newState.notificationsState.isLoading, isTrue);
  });

  test('unreadCount can be updated', () {
    final newState = notificationsCubit.state.copyWith(unreadCount: 5);

    expect(newState.unreadCount, equals(5));
  });

  test(
    'onEvent GetNotificationsEvent success updates notificationsState data',
    () async {
      final response = NotificationsResponseEntity();

      when(mockGetUserNotificationsUseCase.call()).thenAnswer(
        (_) async =>
            SuccessBaseResponse<NotificationsResponseEntity>(data: response),
      );

      final future = expectLater(
        notificationsCubit.stream,
        emitsThrough(
          predicate<NotificationsState>(
            (state) => state.notificationsState.data == response,
          ),
        ),
      );

      notificationsCubit.onEvent(GetNotificationsEvent());

      await future;

      expect(notificationsCubit.state.notificationsState.errorMessage, isNull);
    },
  );

  test('onEvent GetUnreadCountEvent success updates unreadCount', () async {
    final response = UnReadCountEntity(unreadCount: 7);

    when(mockGetUnReadNotificationCountUseCase.call()).thenAnswer(
      (_) async => SuccessBaseResponse<UnReadCountEntity>(data: response),
    );

    final future = expectLater(
      notificationsCubit.stream,
      emitsThrough(
        predicate<NotificationsState>((state) => state.unreadCount == 7),
      ),
    );

    notificationsCubit.onEvent(GetUnreadCountEvent());

    await future;
  });
}
