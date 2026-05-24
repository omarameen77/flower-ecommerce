import 'package:equatable/equatable.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';

class CartState extends Equatable {
  final Set<String> loadingProducts;

  final Set<String> deletingCartItemIds;

  final Set<String> addedProducts;

  final CartResponseEntity? cart;

  final DateTime? lastUpdated;

  final String? errorMessage;

  final String? successMessage;

  const CartState({
    this.loadingProducts = const {},
    this.deletingCartItemIds = const {},
    this.addedProducts = const {},
    this.cart,
    this.lastUpdated,
    this.errorMessage,
    this.successMessage,
  });

  CartState copyWith({
    Set<String>? loadingProducts,
    Set<String>? deletingCartItemIds,
    Set<String>? addedProducts,
    CartResponseEntity? cart,
    DateTime? lastUpdated,
    String? errorMessage,
    String? successMessage,
  }) {
    return CartState(
      loadingProducts: loadingProducts ?? this.loadingProducts,

      deletingCartItemIds: deletingCartItemIds ?? this.deletingCartItemIds,

      addedProducts: addedProducts ?? this.addedProducts,

      cart: cart ?? this.cart,

      lastUpdated: lastUpdated ?? this.lastUpdated,

      errorMessage: errorMessage,

      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadingProducts,
    deletingCartItemIds,
    addedProducts,
    cart,
    lastUpdated,
    errorMessage,
    successMessage,
  ];
}
