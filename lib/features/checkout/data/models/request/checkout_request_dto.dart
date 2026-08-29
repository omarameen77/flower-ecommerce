import 'package:json_annotation/json_annotation.dart';

part 'checkout_request_dto.g.dart';

@JsonSerializable()
class CheckoutRequestDto {
  @JsonKey(name: "shippingAddress")
  final ShippingAddressDto shippingAddress;

  CheckoutRequestDto({required this.shippingAddress});

  factory CheckoutRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestDtoToJson(this);
}

@JsonSerializable()
class ShippingAddressDto {
  @JsonKey(name: "street")
  final String street;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "lat")
  final String lat;
  @JsonKey(name: "long")
  final String long;

  ShippingAddressDto({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressDtoToJson(this);
}
