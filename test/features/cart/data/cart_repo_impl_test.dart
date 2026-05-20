import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/cart/data/datasource/cart_remote_data_source_contract.dart';
import 'package:flower/features/cart/data/model/response/cart_response_dto.dart';
import 'package:flower/features/cart/data/repository/cart_repo_impl.dart';
import 'package:flower/features/cart/domain/entity/add_to_cart_request_entity.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_repo_impl_test.mocks.dart';

@GenerateMocks([CartRemoteDataSourceContract])
void main() {
  late MockCartRemoteDataSourceContract mockRemoteDataSource;

  late CartRepoImpl repo;

  setUpAll(() {
    provideDummy<BaseResponse<CartResponseDto>>(
      SuccessBaseResponse<CartResponseDto>(data: CartResponseDto()),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockCartRemoteDataSourceContract();

    repo = CartRepoImpl(mockRemoteDataSource);
  });

  group('cart repo impl', () {
    group('getCart', () {
      test(
        'should return SuccessBaseResponse<CartResponseEntity> when datasource succeeds',
        () async {
          final dto = CartResponseDto();

          when(mockRemoteDataSource.getCart()).thenAnswer(
            (_) async => SuccessBaseResponse<CartResponseDto>(data: dto),
          );

          final result = await repo.getCart();

          expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());

          verify(mockRemoteDataSource.getCart()).called(1);
        },
      );

      test('should preserve failure when datasource fails', () async {
        final failure = Failure(message: 'error');

        when(mockRemoteDataSource.getCart()).thenAnswer(
          (_) async => ErrorBaseResponse<CartResponseDto>(failure: failure),
        );

        final result = await repo.getCart();

        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());

        expect(
          (result as ErrorBaseResponse<CartResponseEntity>).failure.message,
          'error',
        );
      });
    });

    group('addProductToCart', () {
      test(
        'should return SuccessBaseResponse<CartResponseEntity> when add succeeds',
        () async {
          final request = AddToCartRequestEntity(product: '1', quantity: 2);

          final dto = CartResponseDto();

          when(
            mockRemoteDataSource.addProductToCart(request: anyNamed('request')),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<CartResponseDto>(data: dto),
          );

          final result = await repo.addProductToCart(request);

          expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());

          verify(
            mockRemoteDataSource.addProductToCart(request: anyNamed('request')),
          ).called(1);
        },
      );

      test('should preserve failure when add fails', () async {
        final failure = Failure(message: 'error');

        final request = AddToCartRequestEntity(product: '1', quantity: 2);

        when(
          mockRemoteDataSource.addProductToCart(request: anyNamed('request')),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<CartResponseDto>(failure: failure),
        );

        final result = await repo.addProductToCart(request);

        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());

        expect(
          (result as ErrorBaseResponse<CartResponseEntity>).failure.message,
          'error',
        );
      });
    });

    group('updateCartItemQuantity', () {
      test(
        'should return SuccessBaseResponse<CartResponseEntity> when update succeeds',
        () async {
          final dto = CartResponseDto();

          when(
            mockRemoteDataSource.updateCartItemQuantity(
              cartItemId: anyNamed('cartItemId'),
              quantity: anyNamed('quantity'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<CartResponseDto>(data: dto),
          );

          final result = await repo.updateCartItemQuantity(
            cartItemId: '1',
            quantity: 5,
          );

          expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());

          verify(
            mockRemoteDataSource.updateCartItemQuantity(
              cartItemId: '1',
              quantity: 5,
            ),
          ).called(1);
        },
      );

      test('should preserve failure when update fails', () async {
        final failure = Failure(message: 'error');

        when(
          mockRemoteDataSource.updateCartItemQuantity(
            cartItemId: anyNamed('cartItemId'),
            quantity: anyNamed('quantity'),
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<CartResponseDto>(failure: failure),
        );

        final result = await repo.updateCartItemQuantity(
          cartItemId: '1',
          quantity: 5,
        );

        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());

        expect(
          (result as ErrorBaseResponse<CartResponseEntity>).failure.message,
          'error',
        );
      });
    });

    group('removeCartItem', () {
      test(
        'should return SuccessBaseResponse<CartResponseEntity> when remove succeeds',
        () async {
          final dto = CartResponseDto();

          when(
            mockRemoteDataSource.removeCartItem(
              cartItemId: anyNamed('cartItemId'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<CartResponseDto>(data: dto),
          );

          final result = await repo.removeCartItem(cartItemId: '1');

          expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());

          verify(
            mockRemoteDataSource.removeCartItem(cartItemId: '1'),
          ).called(1);
        },
      );

      test('should preserve failure when remove fails', () async {
        final failure = Failure(message: 'error');

        when(
          mockRemoteDataSource.removeCartItem(
            cartItemId: anyNamed('cartItemId'),
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<CartResponseDto>(failure: failure),
        );

        final result = await repo.removeCartItem(cartItemId: '1');

        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());

        expect(
          (result as ErrorBaseResponse<CartResponseEntity>).failure.message,
          'error',
        );
      });
    });
  });
}
