import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String productId;

  final int quantity;

  const AddToCartEvent({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

class GetCartEvent extends CartEvent {
  const GetCartEvent();
}

class RemoveCartItemEvent extends CartEvent {
  final String cartItemId;

  const RemoveCartItemEvent({required this.cartItemId});

  @override
  List<Object?> get props => [cartItemId];
}

class UpdateCartQuantityEvent extends CartEvent {
  final String cartItemId;
  final int quantity;

  const UpdateCartQuantityEvent({
    required this.cartItemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [cartItemId, quantity];
}
