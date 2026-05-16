import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "wishlist")
  List<dynamic>? wishlist;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "addresses")
  List<dynamic>? addresses;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  UserDto({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toDomain() {
    return UserEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      wishlist: wishlist,
      addresses: addresses,
      createdAt: createdAt,
    );
  }
}
