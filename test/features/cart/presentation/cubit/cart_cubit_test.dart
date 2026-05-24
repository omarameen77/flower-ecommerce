import 'package:flutter_test/flutter_test.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:flower/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower/features/cart/domain/usecases/remove_cart_item_use_case.dart';
import 'package:flower/features/cart/domain/usecases/update_cart_item_quantity_use_case.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';

import 'package:mockito/mockito.dart';

class MockAddProductToCartUseCase extends Mock
    implements AddProductToCartUseCase {}

class MockGetCartUseCase extends Mock implements GetCartUseCase {}

class MockRemoveCartItemUseCase extends Mock implements RemoveCartItemUseCase {}

class MockUpdateCartItemQuantityUseCase extends Mock
    implements UpdateCartItemQuantityUseCase {}

void main() {
  group('CartCubit', () {
    late MockAddProductToCartUseCase mockAddProductToCartUseCase;
    late MockGetCartUseCase mockGetCartUseCase;
    late MockRemoveCartItemUseCase mockRemoveCartItemUseCase;
    late MockUpdateCartItemQuantityUseCase mockUpdateCartItemQuantityUseCase;
    late CartCubit cartCubit;

    setUp(() {
      mockAddProductToCartUseCase = MockAddProductToCartUseCase();
      mockGetCartUseCase = MockGetCartUseCase();
      mockRemoveCartItemUseCase = MockRemoveCartItemUseCase();
      mockUpdateCartItemQuantityUseCase = MockUpdateCartItemQuantityUseCase();

      cartCubit = CartCubit(
        mockAddProductToCartUseCase,
        mockGetCartUseCase,
        mockRemoveCartItemUseCase,
        mockUpdateCartItemQuantityUseCase,
      );

      provideDummy<BaseResponse<CartResponseEntity>>(
        SuccessBaseResponse<CartResponseEntity>(data: CartResponseEntity()),
      );
    });

    tearDown(() {
      cartCubit.close();
    });

    test('initial state has correct values', () {
      expect(cartCubit.state.cart, isNull);
      expect(cartCubit.state.loadingProducts, isEmpty);
      expect(cartCubit.state.addedProducts, isEmpty);
      expect(cartCubit.state.deletingCartItemIds, isEmpty);
      expect(cartCubit.state.errorMessage, isNull);
      expect(cartCubit.state.successMessage, isNull);
    });

    test('loadingProducts set can be updated', () {
      final newState = cartCubit.state.copyWith(
        loadingProducts: {'product1', 'product2'},
      );

      expect(newState.loadingProducts, contains('product1'));
      expect(newState.loadingProducts, contains('product2'));
      expect(newState.loadingProducts.length, equals(2));
    });

    test('addedProducts set can be updated', () {
      final newState = cartCubit.state.copyWith(addedProducts: {'product1'});

      expect(newState.addedProducts, contains('product1'));
    });

    test('deletingCartItemIds set can be updated', () {
      final newState = cartCubit.state.copyWith(deletingCartItemIds: {'item1'});

      expect(newState.deletingCartItemIds, contains('item1'));
    });

    test('errorMessage can be set in state', () {
      final newState = cartCubit.state.copyWith(
        errorMessage: 'Test error message',
      );

      expect(newState.errorMessage, equals('Test error message'));
    });

    test('successMessage can be set in state', () {
      final newState = cartCubit.state.copyWith(
        successMessage: 'Test success message',
      );

      expect(newState.successMessage, equals('Test success message'));
    });
  });
}
