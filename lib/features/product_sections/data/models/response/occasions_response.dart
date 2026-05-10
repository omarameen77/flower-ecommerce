
import 'package:flower/features/product_sections/data/models/metadata/metadata_dto.dart';
import 'package:flower/features/product_sections/data/models/dtos/occasion_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasions_response.g.dart';

@JsonSerializable()
class OccasionsResponse {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "metadata")
  final MetadataDto? metadata;

  @JsonKey(name: "occasions")
  final List<OccasionDto>? occasions;

  const OccasionsResponse({
    this.message,
    this.metadata,
    this.occasions,
  });

  factory OccasionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionsResponseToJson(this);
}