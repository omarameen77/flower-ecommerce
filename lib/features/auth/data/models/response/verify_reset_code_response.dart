import 'package:flower/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_code_response.g.dart';

@JsonSerializable()
class VerifyResetCodeResponseDto {
  @JsonKey(name: "status")
  String? status;

  VerifyResetCodeResponseDto({this.status});

  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeResponseDtoToJson(this);

  VerifyResetCodeEntity toEntity() {
    return VerifyResetCodeEntity(status: status ?? '');
  }
}
