import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;

  ResetPasswordResponseDto({this.message, this.token});

  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseDtoToJson(this);

  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(message: message ?? '', token: token ?? '');
  }
}
