import 'package:flower/features/cart/data/model/response/cart_item_dto.dart';
import 'package:flower/features/cart/domain/entity/cart_item_entity.dart';

extension CartItemMapper on CartItemDto {
  CartItemEntity toDomain() {
    return CartItemEntity(
      product: product?.toDomain(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
