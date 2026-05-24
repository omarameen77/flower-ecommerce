import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/add_to_cart_request_entity.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';

abstract class CartRepoContract {
  Future<BaseResponse<CartResponseEntity>> getCart();

  Future<BaseResponse<CartResponseEntity>> addProductToCart(
    AddToCartRequestEntity request,
  );

  Future<BaseResponse<CartResponseEntity>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  });

  Future<BaseResponse<CartResponseEntity>> removeCartItem({
    required String cartItemId,
  });
}
