import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:flower/features/cart/domain/usecases/remove_cart_item_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'remove_cart_item_use_case_test.mocks.dart';

@GenerateMocks([CartRepoContract])
void main() {
  late MockCartRepoContract mockRepo;
  late RemoveCartItemUseCase useCase;
  late CartResponseEntity cartResponse;
  setUpAll(() {
    cartResponse = CartResponseEntity();
    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessBaseResponse<CartResponseEntity>(data: CartResponseEntity()),
    );
  });
  setUp(() {
    mockRepo = MockCartRepoContract();
    useCase = RemoveCartItemUseCase(mockRepo);
  });
  group('remove cart item usecase', () {
    test('should call repo.removeCartItem', () async {
      when(mockRepo.removeCartItem(cartItemId: '1')).thenAnswer(
        (_) async =>
            SuccessBaseResponse<CartResponseEntity>(data: cartResponse),
      );
      final result = await useCase.call(cartItemId: '1');
      expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
      verify(mockRepo.removeCartItem(cartItemId: '1')).called(1);
    });
  });
}
