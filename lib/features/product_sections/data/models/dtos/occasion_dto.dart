// data/models/occasion/occasion_dto.dart

import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_dto.g.dart';

@JsonSerializable()
class OccasionDto {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "slug")
  final String? slug;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;

  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;

  @JsonKey(name: "productsCount")
  final int? productsCount;

  const OccasionDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  factory OccasionDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionDtoToJson(this);

  OccasionEntity toDomain() {
    return OccasionEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      isSuperAdmin: isSuperAdmin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      productsCount: productsCount,
    );
  }
}