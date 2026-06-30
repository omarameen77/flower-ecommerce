import 'package:flower/features/address/data/models/response/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'addresses_response.g.dart';

@JsonSerializable()
class AddressesResponseDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'addresses')
  final List<AddressDto>? addresses;
  @JsonKey(name: 'address')
  final List<AddressDto>? address;

  AddressesResponseDto({this.message, this.addresses, this.address});

  factory AddressesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddressesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesResponseDtoToJson(this);

  List<AddressDto> get all => addresses ?? address ?? const [];
}
