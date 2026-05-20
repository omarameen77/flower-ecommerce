import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/cart/data/model/request/add_to_cart_request_dto.dart';
import 'package:flower/features/cart/data/model/request/update_cart_quantity_request_dto.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_clint.g.dart';

@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  @GET(CartEndPoints.cart)
  Future<CartResponseDto> getCart();

  @POST(CartEndPoints.cart)
  Future<CartResponseDto> addProductToCart(@Body() AddToCartRequestDto request);

  @PUT(CartEndPoints.updateCartItem)
  Future<CartResponseDto> updateCartItemQuantity(
    @Path('id') String cartItemId,
    @Body() UpdateCartQuantityRequestDto request,
  );

  @DELETE(CartEndPoints.removeCartItem)
  Future<CartResponseDto> removeCartItem(@Path('id') String cartItemId);
}
