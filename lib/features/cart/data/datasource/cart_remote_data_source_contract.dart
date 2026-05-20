import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/data/model/request/add_to_cart_request_dto.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';

abstract class CartRemoteDataSourceContract {
  Future<BaseResponse<CartResponseDto>> getCart();

  Future<BaseResponse<CartResponseDto>> addProductToCart({
    required AddToCartRequestDto request,
  });

  Future<BaseResponse<CartResponseDto>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  });

  Future<BaseResponse<CartResponseDto>> removeCartItem({
    required String cartItemId,
  });
}
