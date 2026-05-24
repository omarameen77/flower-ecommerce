import 'package:flower/features/cart/domain/entity/cart_entity.dart';

class CartResponseEntity {
  String? message;
  int? numOfCartItems;
  CartEntity? cart;

  CartResponseEntity({this.message, this.numOfCartItems, this.cart});
}
