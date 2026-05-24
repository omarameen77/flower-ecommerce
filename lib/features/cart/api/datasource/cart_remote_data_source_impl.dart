import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/cart/api/api_clint/cart_api_clint.dart';
import 'package:flower/features/cart/data/datasource/cart_remote_data_source_contract.dart';
import 'package:flower/features/cart/data/model/request/add_to_cart_request_dto.dart';
import 'package:flower/features/cart/data/model/request/update_cart_quantity_request_dto.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract {
  final CartApiClient apiClient;
  final SafeApiCaller caller;

  CartRemoteDataSourceImpl(this.apiClient, this.caller);

  @override
  Future<BaseResponse<CartResponseDto>> getCart() async {
    final response = await caller.safeCall(() async {
      final dto = await apiClient.getCart();
      return dto;
    });

    return response;
  }

  @override
  Future<BaseResponse<CartResponseDto>> addProductToCart({
    required AddToCartRequestDto request,
  }) async {
    final response = await caller.safeCall(() async {
      final dto = await apiClient.addProductToCart(request);
      return dto;
    });

    return response;
  }

  @override
  Future<BaseResponse<CartResponseDto>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    final response = await caller.safeCall(() async {
      final dto = await apiClient.updateCartItemQuantity(
        cartItemId,
        UpdateCartQuantityRequestDto(quantity: quantity),
      );

      return dto;
    });

    return response;
  }

  @override
  Future<BaseResponse<CartResponseDto>> removeCartItem({
    required String cartItemId,
  }) async {
    final response = await caller.safeCall(() async {
      final dto = await apiClient.removeCartItem(cartItemId);
      return dto;
    });

    return response;
  }
}
