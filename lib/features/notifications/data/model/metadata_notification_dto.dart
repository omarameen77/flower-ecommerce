import 'package:json_annotation/json_annotation.dart';

part 'metadata_notification_dto.g.dart';

@JsonSerializable()
class MetadataNotificationDto {
  @JsonKey(name: "currentPage")
  int? currentPage;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "limit")
  int? limit;
  @JsonKey(name: "totalItems")
  int? totalItems;
  @JsonKey(name: "unreadCount")
  int? unreadCount;

  MetadataNotificationDto({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
    this.unreadCount,
  });

  factory MetadataNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$MetadataNotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataNotificationDtoToJson(this);
}
