import 'package:json_annotation/json_annotation.dart';
part 'un_read_count_response.g.dart';

@JsonSerializable()
class UnReadCountResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "unreadCount")
  int? unreadCount;

  UnReadCountResponse({this.message, this.unreadCount});

  factory UnReadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnReadCountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnReadCountResponseToJson(this);
}
