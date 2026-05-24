import 'package:flower/core/mapper/cart_mapper/cart_item_mapper.dart';
import 'package:flower/features/cart/data/model/response/cart_dto.dart';
import 'package:flower/features/cart/domain/entity/cart_entity.dart';

extension CartMapper on CartDto {
  CartEntity toDomain() {
    return CartEntity(
      id: id,
      user: user,
      cartItems: cartItems?.map((e) => e.toDomain()).toList(),
      appliedCoupons: appliedCoupons,
      discount: discount,
      totalPrice: totalPrice,
      totalPriceAfterDiscount: totalPriceAfterDiscount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}
