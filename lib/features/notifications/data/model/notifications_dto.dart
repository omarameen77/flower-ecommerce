import 'package:json_annotation/json_annotation.dart';
part 'notifications_dto.g.dart';

@JsonSerializable()
class NotificationsDto {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "body")
  String? body;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "isRead")
  bool? isRead;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  NotificationsDto({
    this.id,
    this.title,
    this.body,
    this.type,
    this.isRead,
    this.createdAt,
  });

  factory NotificationsDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsDtoToJson(this);
}
