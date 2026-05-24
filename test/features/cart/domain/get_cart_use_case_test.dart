import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/cart/domain/entity/cart_response_entity.dart';
import 'package:flower/features/cart/domain/repository/cart_repo_contract.dart';
import 'package:flower/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_cart_use_case_test.mocks.dart';

@GenerateMocks([CartRepoContract])
void main() {
  late MockCartRepoContract mockRepo;

  late GetCartUseCase useCase;

  late CartResponseEntity cartResponse;

  setUpAll(() {
    cartResponse = CartResponseEntity();

    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessBaseResponse<CartResponseEntity>(data: CartResponseEntity()),
    );
  });

  setUp(() {
    mockRepo = MockCartRepoContract();

    useCase = GetCartUseCase(mockRepo);
  });

  group('get cart usecase', () {
    test('should call repo.getCart', () async {
      when(mockRepo.getCart()).thenAnswer(
        (_) async =>
            SuccessBaseResponse<CartResponseEntity>(data: cartResponse),
      );

      final result = await useCase.call();

      expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());

      verify(mockRepo.getCart()).called(1);
    });

    test('should propagate error when repo fails', () async {
      final failure = Failure(message: 'error');

      when(mockRepo.getCart()).thenAnswer(
        (_) async => ErrorBaseResponse<CartResponseEntity>(failure: failure),
      );

      final result = await useCase.call();

      expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());

      expect(
        (result as ErrorBaseResponse<CartResponseEntity>).failure.message,
        'error',
      );
    });
  });
}
