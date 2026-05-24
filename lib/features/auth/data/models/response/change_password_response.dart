import 'package:flower/features/auth/domain/entities/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;

  ChangePasswordResponseDto({this.message, this.token});

  factory ChangePasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseDtoToJson(this);

  ChangePasswordEntity toEntity() {
    return ChangePasswordEntity(message: message ?? '', token: token ?? '');
  }
}
