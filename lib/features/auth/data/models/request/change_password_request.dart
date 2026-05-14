import 'package:json_annotation/json_annotation.dart';
part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequestDto {
  @JsonKey(name: "password")
  String? oldPassword;
  @JsonKey(name: "newPassword")
  String? newPassword;

  ChangePasswordRequestDto({this.oldPassword, this.newPassword});

  factory ChangePasswordRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestDtoToJson(this);
}
