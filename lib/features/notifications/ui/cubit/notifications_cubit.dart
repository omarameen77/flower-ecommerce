import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/entity/notification_unread_count_entity.dart';
import 'package:flower/features/notifications/domain/usecases/get_un_read_notification_count_use_case.dart';
import 'package:flower/features/notifications/domain/usecases/get_user_notifications_use_case.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

part 'notifications_state.dart';

@injectable
@LazySingleton()
class NotificationsCubit extends Cubit<NotificationsState> {
  final GetUserNotificationsUseCase getUserNotificationsUseCase;
  final GetUnReadNotificationCountUseCase getUnreadCountUseCase;
  NotificationsCubit({
    required this.getUserNotificationsUseCase,
    required this.getUnreadCountUseCase,
  }) : super(const NotificationsState());

  void onEvent(NotificationsEvent event) {
    switch (event) {
      case GetNotificationsEvent():
        _getNotifications();
      case GetUnreadCountEvent():
        _getNotificationCount();
    }
  }

  Future<void> _getNotifications() async {
    emit(state.copyWith(notificationsState: const BaseState(isLoading: true)));

    final response = await getUserNotificationsUseCase();

    switch (response) {
      case SuccessBaseResponse<NotificationsResponseEntity>():
        emit(
          state.copyWith(notificationsState: BaseState(data: response.data)),
        );

      case ErrorBaseResponse<NotificationsResponseEntity>():
        emit(
          state.copyWith(
            notificationsState: BaseState(
              errorMessage: response.failure.message,
            ),
          ),
        );
    }
  }

  Future<void> _getNotificationCount() async {
    final response = await getUnreadCountUseCase.call();

    switch (response) {
      case SuccessBaseResponse<NotificationUnReadCountEntity>():
        emit(state.copyWith(unreadCount: response.data.unreadCount));

      case ErrorBaseResponse<NotificationUnReadCountEntity>():
        emit(state.copyWith(unreadCount: 0));
    }
  }
}
