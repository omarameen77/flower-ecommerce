import 'package:json_annotation/json_annotation.dart';
part 'add_address_request.g.dart';

@JsonSerializable()
class AddAddressRequestDto {
  @JsonKey(name: 'street')
  final String? street;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'lat')
  final String? lat;
  @JsonKey(name: 'long')
  final String? long;
  @JsonKey(name: 'username')
  final String? username;

  AddAddressRequestDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddAddressRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressRequestDtoToJson(this);
}
