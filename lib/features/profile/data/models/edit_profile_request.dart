import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequestDto {
  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'phone')
  final String phone;

  const EditProfileRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory EditProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestDtoToJson(this);
}
