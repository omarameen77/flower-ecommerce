import 'package:json_annotation/json_annotation.dart';
part 'update_cart_quantity_request_dto.g.dart';

@JsonSerializable()
class UpdateCartQuantityRequestDto {
  @JsonKey(name: "quantity")
  int? quantity;

  UpdateCartQuantityRequestDto({this.quantity});

  factory UpdateCartQuantityRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartQuantityRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartQuantityRequestDtoToJson(this);
}
