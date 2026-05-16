// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequestDto _$EditProfileRequestDtoFromJson(
  Map<String, dynamic> json,
) => EditProfileRequestDto(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$EditProfileRequestDtoToJson(
  EditProfileRequestDto instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phone': instance.phone,
};
