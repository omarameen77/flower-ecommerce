import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';

@JsonSerializable()
class LoginRequestDto {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;

  LoginRequestDto({this.email, this.password});

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);
}
