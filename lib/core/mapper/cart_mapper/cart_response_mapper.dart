import 'package:flower/core/mapper/cart_mapper/cart_mapper.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';

extension CartResponseMapper on CartResponseDto {
  CartResponseEntity toDomain() {
    return CartResponseEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toDomain(),
    );
  }
}
