import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_code_request.g.dart';

@JsonSerializable()
class VerifyResetCodeRequestDto {
  @JsonKey(name: "resetCode")
  String? resetCode;

  VerifyResetCodeRequestDto({this.resetCode});

  factory VerifyResetCodeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestDtoToJson(this);
}
