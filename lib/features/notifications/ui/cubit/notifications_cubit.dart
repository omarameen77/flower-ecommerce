import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';
import 'package:flower/features/notifications/domain/usecases/delete_notifications_use_case.dart';
import 'package:flower/features/notifications/domain/usecases/get_un_read_notification_count_use_case.dart';
import 'package:flower/features/notifications/domain/usecases/get_user_notifications_use_case.dart';
import 'package:flower/features/notifications/domain/usecases/mark_as_reaed_notification_use_case.dart';
import 'package:flower/features/notifications/ui/cubit/notifications_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notifications_state.dart';

@injectable
@LazySingleton()
class NotificationsCubit extends Cubit<NotificationsState> {
  final GetUserNotificationsUseCase getUserNotificationsUseCase;
  final GetUnreadNotificationCountUseCase getUnreadCountUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  StreamSubscription<List<NotificationsEntity>>? _notificationsSubscription;
  StreamSubscription<int>? _unreadCountSubscription;

  NotificationsCubit({
    required this.getUserNotificationsUseCase,
    required this.getUnreadCountUseCase,
    required this.markNotificationAsReadUseCase,
    required this.deleteNotificationUseCase,
  }) : super(const NotificationsState());

  void onEvent(NotificationsEvent event) {
    switch (event) {
      case GetNotificationsEvent():
        _listenToNotifications();
        _listenToUnreadCount();

      case GetUnreadCountEvent():
        _listenToUnreadCount();
    }
  }

  Future<void> _listenToNotifications() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final userId = await SecureStorageService.getUserId();

    if (userId == null || userId.isEmpty) {
      emit(state.copyWith(isLoading: false, errorMessage: "User not found"));
      return;
    }

    await _notificationsSubscription?.cancel();

    _notificationsSubscription = getUserNotificationsUseCase(userId).listen(
      (notifications) {
        emit(
          state.copyWith(
            isLoading: false,
            notifications: notifications,
            clearError: true,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
      },
    );
  }

  Future<void> _listenToUnreadCount() async {
    final userId = await SecureStorageService.getUserId();

    if (userId == null || userId.isEmpty) return;

    await _unreadCountSubscription?.cancel();

    _unreadCountSubscription = getUnreadCountUseCase(userId).listen((count) {
      emit(state.copyWith(unreadCount: count));
    });
  }

  Future<void> markAsRead(String notificationId) async {
    final userId = await SecureStorageService.getUserId();

    if (userId == null || userId.isEmpty) return;

    await markNotificationAsReadUseCase(
      userId: userId,
      notificationId: notificationId,
    );
  }

  Future<void> deleteNotification(String notificationId) async {
    final userId = await SecureStorageService.getUserId();

    if (userId == null || userId.isEmpty) return;

    await deleteNotificationUseCase(
      userId: userId,
      notificationId: notificationId,
    );
  }

  @override
  Future<void> close() async {
    await _notificationsSubscription?.cancel();
    await _unreadCountSubscription?.cancel();
    return super.close();
  }
}
