class NotificationsEntity {
  String? id;
  String? title;
  String? body;
  String? type;
  bool? isRead;
  DateTime? createdAt;

  NotificationsEntity({
    this.id,
    this.title,
    this.body,
    this.type,
    this.isRead,
    this.createdAt,
  });
}
