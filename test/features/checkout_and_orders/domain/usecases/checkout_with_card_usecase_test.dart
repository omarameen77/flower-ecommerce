import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/checkout_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_with_card_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_with_card_usecase_test.mocks.dart';

@GenerateMocks([CheckoutRepo])
void main() {
  late CheckoutWithCardUseCase checkoutWithCardUseCase;
  late MockCheckoutRepo mockCheckoutRepo;

  setUpAll(() {
    provideDummy<BaseResponse<CreditCardModel>>(
      SuccessBaseResponse<CreditCardModel>(
        data: CreditCardModel(message: "success"),
      ),
    );
  });

  setUp(() {
    mockCheckoutRepo = MockCheckoutRepo();
    checkoutWithCardUseCase = CheckoutWithCardUseCase(mockCheckoutRepo);
  });

  final tCheckoutParams = CheckoutParams(
    street: "123 Main St",
    phone: "1234567890",
    city: "New York",
    lat: "40.7128",
    long: "74.0060",
  );

  final tCreditCardModel = CreditCardModel(
    message: "success",
    url: "https://checkout.stripe.com/test",
  );

  test(
      'should return SuccessBaseResponse when repository call is successful',
      () async {
    when(mockCheckoutRepo.checkoutWithCreditCard(tCheckoutParams))
        .thenAnswer((_) async =>
            SuccessBaseResponse<CreditCardModel>(data: tCreditCardModel));

    final result = await checkoutWithCardUseCase.call(tCheckoutParams);

    expect(result, isA<SuccessBaseResponse<CreditCardModel>>());
    final successResult = result as SuccessBaseResponse<CreditCardModel>;
    expect(successResult.data, tCreditCardModel);
    verify(mockCheckoutRepo.checkoutWithCreditCard(tCheckoutParams)).called(1);
    verifyNoMoreInteractions(mockCheckoutRepo);
  });

  test('should return ErrorBaseResponse when repository call fails', () async {
    final tFailure = Failure(message: 'Checkout failed');
    when(mockCheckoutRepo.checkoutWithCreditCard(tCheckoutParams))
        .thenAnswer((_) async =>
            ErrorBaseResponse<CreditCardModel>(failure: tFailure));

    final result = await checkoutWithCardUseCase.call(tCheckoutParams);

    expect(result, isA<ErrorBaseResponse<CreditCardModel>>());
    final errorResult = result as ErrorBaseResponse<CreditCardModel>;
    expect(errorResult.failure, tFailure);
    verify(mockCheckoutRepo.checkoutWithCreditCard(tCheckoutParams)).called(1);
    verifyNoMoreInteractions(mockCheckoutRepo);
  });
}
