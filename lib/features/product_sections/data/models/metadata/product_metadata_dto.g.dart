// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_metadata_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMetadataDto _$ProductMetadataDtoFromJson(Map<String, dynamic> json) =>
    ProductMetadataDto(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      totalItems: (json['totalItems'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductMetadataDtoToJson(ProductMetadataDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'limit': instance.limit,
      'totalItems': instance.totalItems,
    };
