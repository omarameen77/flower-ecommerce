import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/mapper/cart_mapper/add_to_cart_request_mapper.dart';
import 'package:flower/core/mapper/cart_mapper/cart_response_mapper.dart';
import 'package:flower/features/cart/data/datasource/cart_remote_data_source_contract.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';
import 'package:flower/features/cart/domain/entity/add_to_cart_request_entity.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepoContract)
class CartRepoImpl implements CartRepoContract {
  final CartRemoteDataSourceContract remoteDataSource;
  CartRepoImpl(this.remoteDataSource);

  @override
  Future<BaseResponse<CartResponseEntity>> addProductToCart(
    AddToCartRequestEntity request,
  ) async {
    final response = await remoteDataSource.addProductToCart(
      request: request.toDto(),
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> getCart() async {
    final response = await remoteDataSource.getCart();
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> removeCartItem({
    required String cartItemId,
  }) async {
    final response = await remoteDataSource.removeCartItem(
      cartItemId: cartItemId,
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    final response = await remoteDataSource.updateCartItemQuantity(
      cartItemId: cartItemId,
      quantity: quantity,
    );

    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(failure: response.failure);
    }
  }
}
