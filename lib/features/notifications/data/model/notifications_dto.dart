import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_dto.g.dart';

@JsonSerializable()
class NotificationsDto {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? id;

  String? title;
  String? body;
  String? type;
  bool? isRead;

  @JsonKey(fromJson: _fromTimestamp, toJson: _toTimestamp)
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

  static DateTime? _fromTimestamp(dynamic value) {
    if (value == null) return null;

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is String) {
      return DateTime.parse(value);
    }

    return null;
  }

  static dynamic _toTimestamp(DateTime? value) {
    if (value == null) return null;
    return Timestamp.fromDate(value);
  }
}
