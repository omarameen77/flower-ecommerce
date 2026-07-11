import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/checkout_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_with_cash_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_with_cash_usecase_test.mocks.dart';

@GenerateMocks([CheckoutRepo])
void main() {
  late CheckoutWithCashUseCase checkoutWithCashUseCase;
  late MockCheckoutRepo mockCheckoutRepo;

  setUpAll(() {
    provideDummy<BaseResponse<CashOnDeliveryModel>>(
      SuccessBaseResponse<CashOnDeliveryModel>(
        data: CashOnDeliveryModel(message: "success"),
      ),
    );
  });

  setUp(() {
    mockCheckoutRepo = MockCheckoutRepo();
    checkoutWithCashUseCase = CheckoutWithCashUseCase(mockCheckoutRepo);
  });

  final tCheckoutParams = CheckoutParams(
    street: "123 Main St",
    phone: "1234567890",
    city: "New York",
    lat: "40.7128",
    long: "74.0060",
  );

  final tCashOnDeliveryModel = CashOnDeliveryModel(
    message: "success",
    orderNumber: "ORD-123",
    paymentType: "cash",
  );

  test(
    'should return SuccessBaseResponse when repository call is successful',
    () async {
      when(
        mockCheckoutRepo.checkoutWithCashOnDelivery(tCheckoutParams),
      ).thenAnswer(
        (_) async => SuccessBaseResponse<CashOnDeliveryModel>(
          data: tCashOnDeliveryModel,
        ),
      );

      final result = await checkoutWithCashUseCase.call(tCheckoutParams);

      expect(result, isA<SuccessBaseResponse<CashOnDeliveryModel>>());
      final successResult = result as SuccessBaseResponse<CashOnDeliveryModel>;
      expect(successResult.data, tCashOnDeliveryModel);
      verify(
        mockCheckoutRepo.checkoutWithCashOnDelivery(tCheckoutParams),
      ).called(1);
      verifyNoMoreInteractions(mockCheckoutRepo);
    },
  );

  test('should return ErrorBaseResponse when repository call fails', () async {
    final tFailure = Failure(message: 'Checkout failed');
    when(
      mockCheckoutRepo.checkoutWithCashOnDelivery(tCheckoutParams),
    ).thenAnswer(
      (_) async => ErrorBaseResponse<CashOnDeliveryModel>(failure: tFailure),
    );

    final result = await checkoutWithCashUseCase.call(tCheckoutParams);

    expect(result, isA<ErrorBaseResponse<CashOnDeliveryModel>>());
    final errorResult = result as ErrorBaseResponse<CashOnDeliveryModel>;
    expect(errorResult.failure, tFailure);
    verify(
      mockCheckoutRepo.checkoutWithCashOnDelivery(tCheckoutParams),
    ).called(1);
    verifyNoMoreInteractions(mockCheckoutRepo);
  });
}
