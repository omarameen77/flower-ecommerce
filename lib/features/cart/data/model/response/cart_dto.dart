import 'package:flower/features/cart/data/model/response/cart_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "user")
  String? user;
  @JsonKey(name: "cartItems")
  List<CartItemDto>? cartItems;
  @JsonKey(name: "appliedCoupons")
  List<dynamic>? appliedCoupons;
  @JsonKey(name: "discount")
  int? discount;
  @JsonKey(name: "totalPrice")
  int? totalPrice;
  @JsonKey(name: "totalPriceAfterDiscount")
  int? totalPriceAfterDiscount;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  CartDto({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}
