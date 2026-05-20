import 'package:flower/features/cart/data/model/request/add_to_cart_request_dto.dart';
import 'package:flower/features/cart/domain/entity/add_to_cart_request_entity.dart';

extension AddToCartRequestMapper on AddToCartRequestEntity {
  AddToCartRequestDto toDto() {
    return AddToCartRequestDto(product: product, quantity: quantity);
  }
}
