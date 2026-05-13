import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';
import 'package:flower/features/product_sections/data/models/metadata/product_metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "metadata")
  ProductMetadataDto? metadata;

  @JsonKey(name: "products")
  List<ProductDto>? products;

  ProductsResponse({this.message, this.metadata, this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
