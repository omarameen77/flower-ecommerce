import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/api/api_clint/cart_api_clint.dart';
import 'package:flower/features/cart/api/datasource/cart_remote_data_source_impl.dart';
import 'package:flower/features/cart/data/model/request/add_to_cart_request_dto.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CartApiClient, SafeApiCaller])
void main() {
  late MockCartApiClient mockApiClient;
  late MockSafeApiCaller mockSafeApiCaller;

  late CartRemoteDataSourceImpl dataSource;

  setUpAll(() {
    provideDummy<BaseResponse<CartResponseDto>>(
      SuccessBaseResponse<CartResponseDto>(data: CartResponseDto()),
    );
    provideDummy<BaseResponse<dynamic>>(
      SuccessBaseResponse<dynamic>(data: CartResponseDto()),
    );
  });

  setUp(() {
    mockApiClient = MockCartApiClient();
    mockSafeApiCaller = MockSafeApiCaller();

    dataSource = CartRemoteDataSourceImpl(mockApiClient, mockSafeApiCaller);
  });

  group('cart remote data source impl', () {
    group('getCart', () {
      test(
        'should return SuccessBaseResponse<CartResponseDto> when api call succeeds',
        () async {
          final responseDto = CartResponseDto();

          when(mockSafeApiCaller.safeCall(any)).thenAnswer(
            (_) async =>
                SuccessBaseResponse<CartResponseDto>(data: responseDto),
          );

          final result = await dataSource.getCart();

          expect(result, isA<SuccessBaseResponse<CartResponseDto>>());

          verify(mockSafeApiCaller.safeCall(any)).called(1);
        },
      );
    });

    group('addProductToCart', () {
      test(
        'should return SuccessBaseResponse<CartResponseDto> when add succeeds',
        () async {
          final request = AddToCartRequestDto(product: '1', quantity: 2);

          final responseDto = CartResponseDto();

          when(mockSafeApiCaller.safeCall(any)).thenAnswer(
            (_) async =>
                SuccessBaseResponse<CartResponseDto>(data: responseDto),
          );

          final result = await dataSource.addProductToCart(request: request);

          expect(result, isA<SuccessBaseResponse<CartResponseDto>>());

          verify(mockSafeApiCaller.safeCall(any)).called(1);
        },
      );
    });

    group('updateCartItemQuantity', () {
      test(
        'should return SuccessBaseResponse<CartResponseDto> when update succeeds',
        () async {
          final responseDto = CartResponseDto();

          when(mockSafeApiCaller.safeCall(any)).thenAnswer(
            (_) async =>
                SuccessBaseResponse<CartResponseDto>(data: responseDto),
          );

          final result = await dataSource.updateCartItemQuantity(
            cartItemId: '1',
            quantity: 5,
          );

          expect(result, isA<SuccessBaseResponse<CartResponseDto>>());

          verify(mockSafeApiCaller.safeCall(any)).called(1);
        },
      );
    });

    group('removeCartItem', () {
      test(
        'should return SuccessBaseResponse<CartResponseDto> when remove succeeds',
        () async {
          final responseDto = CartResponseDto();

          when(mockSafeApiCaller.safeCall(any)).thenAnswer(
            (_) async =>
                SuccessBaseResponse<CartResponseDto>(data: responseDto),
          );

          final result = await dataSource.removeCartItem(cartItemId: '1');

          expect(result, isA<SuccessBaseResponse<CartResponseDto>>());

          verify(mockSafeApiCaller.safeCall(any)).called(1);
        },
      );
    });
  });
}
