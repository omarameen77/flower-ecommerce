part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final BaseState<NotificationsResponseEntity> notificationsState;
  final int unreadCount;

  const NotificationsState({
    this.notificationsState = const BaseState<NotificationsResponseEntity>(
      isLoading: false,
    ),
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    BaseState<NotificationsResponseEntity>? notificationsState,
    int? unreadCount,
  }) {
    return NotificationsState(
      notificationsState: notificationsState ?? this.notificationsState,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [notificationsState, unreadCount];
}
