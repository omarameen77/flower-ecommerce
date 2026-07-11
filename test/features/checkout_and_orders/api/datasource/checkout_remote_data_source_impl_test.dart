import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/api/api_client/checkout_api_client.dart';
import 'package:flower/features/checkout_and_orders/api/datasources/checkout_remote_data_source_impl.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/cash_on_delivery_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/credit_card_dto.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CheckoutApiClient])
void main() {
  late CheckoutRemoteDataSourceImpl checkoutRemoteDataSourceImpl;
  late MockCheckoutApiClient mockCheckoutApiClient;

  setUp(() {
    mockCheckoutApiClient = MockCheckoutApiClient();
    checkoutRemoteDataSourceImpl = CheckoutRemoteDataSourceImpl(
      checkoutApiClient: mockCheckoutApiClient,
    );
  });

  final tCheckoutParams = CheckoutParams(
    street: "123 Main St",
    phone: "1234567890",
    city: "New York",
    lat: "40.7128",
    long: "74.0060",
  );

  final tCashOnDeliveryDto = CashOnDeliveryDto(
    message: "success",
    order: Order(orderNumber: "ORD-123", paymentType: "cash"),
  );

  final tCreditCardDto = CreditCardDto(
    message: "success",
    session: Session(url: "https://checkout.stripe.com/test"),
  );

  group('checkoutWithCashOnDelivery', () {
    test(
      'should return SuccessBaseResponse when api client returns cash on delivery response',
      () async {
        when(
          mockCheckoutApiClient.checkoutWithCashOnDelivery(any),
        ).thenAnswer((_) async => tCashOnDeliveryDto);

        final result = await checkoutRemoteDataSourceImpl
            .checkoutWithCashOnDelivery(tCheckoutParams);

        expect(result, isA<SuccessBaseResponse<CashOnDeliveryDto>>());
        final successResult = result as SuccessBaseResponse<CashOnDeliveryDto>;
        expect(successResult.data, tCashOnDeliveryDto);
        verify(mockCheckoutApiClient.checkoutWithCashOnDelivery(any)).called(1);
        verifyNoMoreInteractions(mockCheckoutApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse when api client throws an exception',
      () async {
        when(
          mockCheckoutApiClient.checkoutWithCashOnDelivery(any),
        ).thenThrow(Exception('Network error'));

        final result = await checkoutRemoteDataSourceImpl
            .checkoutWithCashOnDelivery(tCheckoutParams);

        expect(result, isA<ErrorBaseResponse<CashOnDeliveryDto>>());
        verify(mockCheckoutApiClient.checkoutWithCashOnDelivery(any)).called(1);
        verifyNoMoreInteractions(mockCheckoutApiClient);
      },
    );
  });

  group('checkoutWithCreditCard', () {
    test(
      'should return SuccessBaseResponse when api client returns credit card response',
      () async {
        when(
          mockCheckoutApiClient.checkoutWithCreditCard(any),
        ).thenAnswer((_) async => tCreditCardDto);

        final result = await checkoutRemoteDataSourceImpl
            .checkoutWithCreditCard(tCheckoutParams);

        expect(result, isA<SuccessBaseResponse<CreditCardDto>>());
        final successResult = result as SuccessBaseResponse<CreditCardDto>;
        expect(successResult.data, tCreditCardDto);
        verify(mockCheckoutApiClient.checkoutWithCreditCard(any)).called(1);
        verifyNoMoreInteractions(mockCheckoutApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse when api client throws an exception',
      () async {
        when(
          mockCheckoutApiClient.checkoutWithCreditCard(any),
        ).thenThrow(Exception('Network error'));

        final result = await checkoutRemoteDataSourceImpl
            .checkoutWithCreditCard(tCheckoutParams);

        expect(result, isA<ErrorBaseResponse<CreditCardDto>>());
        verify(mockCheckoutApiClient.checkoutWithCreditCard(any)).called(1);
        verifyNoMoreInteractions(mockCheckoutApiClient);
      },
    );
  });
}
