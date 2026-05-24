import 'package:json_annotation/json_annotation.dart';
part 'add_to_cart_request_dto.g.dart';

@JsonSerializable()
class AddToCartRequestDto {
  @JsonKey(name: "product")
  String? product;
  @JsonKey(name: "quantity")
  int? quantity;

  AddToCartRequestDto({this.product, this.quantity});

  factory AddToCartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestDtoToJson(this);
}
