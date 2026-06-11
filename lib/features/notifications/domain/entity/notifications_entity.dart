import 'package:equatable/equatable.dart';

class NotificationsEntity extends Equatable {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  const NotificationsEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, title, body, type, isRead, createdAt];
}
