import 'package:equatable/equatable.dart';

class MetadataNotificationEntity extends Equatable {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;
  final int unreadCount;

  const MetadataNotificationEntity({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
    required this.unreadCount,
  });

  @override
  List<Object> get props => [
    currentPage,
    totalPages,
    limit,
    totalItems,
    unreadCount,
  ];
}
