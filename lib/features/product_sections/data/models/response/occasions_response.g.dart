// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsResponse _$OccasionsResponseFromJson(Map<String, dynamic> json) =>
    OccasionsResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      occasions: (json['occasions'] as List<dynamic>?)
          ?.map((e) => OccasionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OccasionsResponseToJson(OccasionsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'occasions': instance.occasions,
    };
