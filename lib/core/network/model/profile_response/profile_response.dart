import 'package:flower/core/network/model/user_models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  UserDto? user;

  ProfileResponseDto({
    this.message,
    this.user,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseDtoToJson(this);
}
