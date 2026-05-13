import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_response.g.dart';

@JsonSerializable()
class ProductDetailsResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'product')
  final ProductDto? product;

  const ProductDetailsResponse({this.message, this.product});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseToJson(this);
}
