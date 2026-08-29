part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final List<NotificationsEntity> notifications;

  final bool isLoading;

  final String? errorMessage;

  final int unreadCount;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.errorMessage,
    this.unreadCount = 0,
  });

  NotificationsState copyWith({
    List<NotificationsEntity>? notifications,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    int? unreadCount,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
    notifications,
    isLoading,
    errorMessage,
    unreadCount,
  ];
}
