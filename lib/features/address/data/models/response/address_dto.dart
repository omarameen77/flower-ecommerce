import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_dto.g.dart';

@JsonSerializable()
class AddressDto {
  @JsonKey(name: '_id')
  final String? id;
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

  AddressDto({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}
