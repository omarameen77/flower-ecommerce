import 'package:json_annotation/json_annotation.dart';

part 'product_metadata_dto.g.dart';

@JsonSerializable()
class ProductMetadataDto {
  @JsonKey(name: "currentPage")
  int? currentPage;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "limit")
  int? limit;

  @JsonKey(name: "totalItems")
  int? totalItems;

  ProductMetadataDto({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory ProductMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$ProductMetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMetadataDtoToJson(this);
}
