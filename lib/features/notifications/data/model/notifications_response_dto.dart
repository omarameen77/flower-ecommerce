import 'package:flower/features/notifications/data/model/metadata_notification_dto.dart';
import 'package:flower/features/notifications/data/model/notifications_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notifications_response_dto.g.dart';

@JsonSerializable()
class NotificationsResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "metadata")
  MetadataNotificationDto? metadata;
  @JsonKey(name: "notifications")
  List<NotificationsDto>? notifications;

  NotificationsResponse({this.message, this.metadata, this.notifications});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
