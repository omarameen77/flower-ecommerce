import 'package:flower/features/cart/domain/entity/cart_item_entity.dart';

class CartEntity {
  String? id;
  String? user;
  List<CartItemEntity>? cartItems;
  List<dynamic>? appliedCoupons;
  int? discount;
  int? totalPrice;
  int? totalPriceAfterDiscount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CartEntity({
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
}
