import 'package:flower/core/network/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  UserDto? user;
  @JsonKey(name: "token")
  String? token;

  RegisterResponseDto({this.message, this.user, this.token});

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseDtoToJson(this);
}
