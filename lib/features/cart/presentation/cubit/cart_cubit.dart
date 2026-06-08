import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/add_to_cart_request_entity.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:flower/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower/features/cart/domain/usecases/remove_cart_item_use_case.dart';
import 'package:flower/features/cart/domain/usecases/update_cart_item_quantity_use_case.dart';
import 'cart_events.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final AddProductToCartUseCase addProductToCartUseCase;

  final GetCartUseCase getCartUseCase;

  final RemoveCartItemUseCase removeCartItemUseCase;

  final UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase;

  CartCubit(
    this.addProductToCartUseCase,
    this.getCartUseCase,
    this.removeCartItemUseCase,
    this.updateCartItemQuantityUseCase,
  ) : super(const CartState());

  void reset() => emit(const CartState());

  Future<void> onEvent(CartEvent event) async {
    switch (event) {
      case GetCartEvent():
        await _onGetCart();

      case AddToCartEvent():
        await _onAddToCart(event);

      case RemoveCartItemEvent():
        await _onRemoveCartItem(event);

      case UpdateCartQuantityEvent():
        await _onUpdateQuantity(event);
    }
  }

  Future<void> _onGetCart() async {
    final response = await getCartUseCase();

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        final cartItems = response.data.cart?.cartItems ?? [];

        final addedProducts = cartItems.map((e) => e.product?.id ?? '').toSet();

        emit(
          state.copyWith(
            cart: response.data,
            addedProducts: addedProducts,
            errorMessage: null,
            lastUpdated: DateTime.now(),
          ),
        );

      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            errorMessage: response.failure.message,
            lastUpdated: DateTime.now(),
          ),
        );
    }
  }

  Future<void> _onAddToCart(AddToCartEvent event) async {
    if (state.addedProducts.contains(event.productId)) {
      return;
    }

    final updatedLoadingProducts = Set<String>.from(state.loadingProducts)
      ..add(event.productId);

    emit(
      state.copyWith(
        loadingProducts: updatedLoadingProducts,
        errorMessage: null,
      ),
    );

    final response = await addProductToCartUseCase(
      AddToCartRequestEntity(
        product: event.productId,
        quantity: event.quantity,
      ),
    );

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        final loadingProducts = Set<String>.from(state.loadingProducts)
          ..remove(event.productId);

        final addedProducts = Set<String>.from(state.addedProducts)
          ..add(event.productId);

        emit(
          state.copyWith(
            loadingProducts: loadingProducts,

            addedProducts: addedProducts,

            cart: response.data,
            lastUpdated: DateTime.now(),
          ),
        );

      case ErrorBaseResponse<CartResponseEntity>():
        final loadingProducts = Set<String>.from(state.loadingProducts)
          ..remove(event.productId);

        emit(
          state.copyWith(
            loadingProducts: loadingProducts,

            errorMessage: response.failure.message,
            lastUpdated: DateTime.now(),
          ),
        );
    }
  }

  Future<void> _onRemoveCartItem(RemoveCartItemEvent event) async {
    final deleting = Set<String>.from(state.deletingCartItemIds)
      ..add(event.cartItemId);

    emit(state.copyWith(deletingCartItemIds: deleting));

    final item = state.cart?.cart?.cartItems?.firstWhere(
      (e) => e.product?.id == event.cartItemId,
    );
    final productName = item?.product?.title ?? 'Item';

    final response = await removeCartItemUseCase(cartItemId: event.cartItemId);

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        final updatedDeleting = Set<String>.from(state.deletingCartItemIds)
          ..remove(event.cartItemId);

        emit(
          state.copyWith(
            deletingCartItemIds: updatedDeleting,
            lastUpdated: DateTime.now(),
            successMessage: '$productName removed from cart',
          ),
        );

        await _onGetCart();

      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            deletingCartItemIds: {...state.deletingCartItemIds}
              ..remove(event.cartItemId),
            lastUpdated: DateTime.now(),
            errorMessage: response.failure.message,
          ),
        );
    }
  }

  Future<void> _onUpdateQuantity(UpdateCartQuantityEvent event) async {
    final loading = Set<String>.from(state.loadingProducts)
      ..add(event.cartItemId);

    emit(state.copyWith(loadingProducts: loading));

    final response = await updateCartItemQuantityUseCase(
      cartItemId: event.cartItemId,
      quantity: event.quantity,
    );

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        final updatedLoading = Set<String>.from(state.loadingProducts)
          ..remove(event.cartItemId);

        emit(
          state.copyWith(
            loadingProducts: updatedLoading,
            lastUpdated: DateTime.now(),
          ),
        );

        await _onGetCart();

      case ErrorBaseResponse<CartResponseEntity>():
        final updated = Set<String>.from(state.loadingProducts)
          ..remove(event.cartItemId);

        emit(
          state.copyWith(
            loadingProducts: updated,
            errorMessage: response.failure.message,
            lastUpdated: DateTime.now(),
          ),
        );
    }
  }
}
