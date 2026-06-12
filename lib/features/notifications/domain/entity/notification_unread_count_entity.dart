import 'package:equatable/equatable.dart';

class NotificationUnReadCountEntity extends Equatable {
  final String message;
  final int unreadCount;

  const NotificationUnReadCountEntity({
    required this.message,
    required this.unreadCount,
  });

  @override
  List<Object> get props => [message, unreadCount];
}
