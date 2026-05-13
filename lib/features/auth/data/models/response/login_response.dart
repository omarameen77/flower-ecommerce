import 'package:flower/core/network/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  UserDto? user;
  @JsonKey(name: "token")
  String? token;

  LoginResponseDto({this.message, this.user, this.token});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}
