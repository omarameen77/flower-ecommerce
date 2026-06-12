import 'package:json_annotation/json_annotation.dart';
part 'notification_unread_count_response.g.dart';

@JsonSerializable()
class NotificationUnreadCountResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "unreadCount")
  int? unreadCount;

  NotificationUnreadCountResponse({this.message, this.unreadCount});

  factory NotificationUnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationUnreadCountResponseFromJson(json);
}
