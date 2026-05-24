import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:flower/features/cart/domain/usecases/update_cart_item_quantity_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'update_cart_item_quantity_use_case_test.mocks.dart';

@GenerateMocks([CartRepoContract])
void main() {
  late MockCartRepoContract mockRepo;
  late UpdateCartItemQuantityUseCase useCase;
  late CartResponseEntity cartResponse;
  setUpAll(() {
    cartResponse = CartResponseEntity();
    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessBaseResponse<CartResponseEntity>(data: CartResponseEntity()),
    );
  });
  setUp(() {
    mockRepo = MockCartRepoContract();
    useCase = UpdateCartItemQuantityUseCase(mockRepo);
  });
  group('update cart item quantity usecase', () {
    test('should call repo.updateCartItemQuantity', () async {
      when(
        mockRepo.updateCartItemQuantity(cartItemId: '1', quantity: 5),
      ).thenAnswer(
        (_) async =>
            SuccessBaseResponse<CartResponseEntity>(data: cartResponse),
      );
      final result = await useCase.call(cartItemId: '1', quantity: 5);
      expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
      verify(
        mockRepo.updateCartItemQuantity(cartItemId: '1', quantity: 5),
      ).called(1);
    });
  });
}
