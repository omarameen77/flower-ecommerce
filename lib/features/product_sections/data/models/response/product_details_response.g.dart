// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponse _$ProductDetailsResponseFromJson(
  Map<String, dynamic> json,
) => ProductDetailsResponse(
  message: json['message'] as String?,
  product: json['product'] == null
      ? null
      : ProductDto.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductDetailsResponseToJson(
  ProductDetailsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'product': instance.product,
};
