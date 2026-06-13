import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/data/datasources/checkout_remote_data_source.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/cash_on_delivery_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/credit_card_dto.dart';
import 'package:flower/features/checkout_and_orders/data/repositories/checkout_repo_impl.dart';
import 'package:flower/features/checkout_and_orders/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_repo_impl_test.mocks.dart';

@GenerateMocks([CheckoutRemoteDataSourceContract])
void main() {
  late CheckoutRepoImpl checkoutRepoImpl;
  late MockCheckoutRemoteDataSourceContract
  mockCheckoutRemoteDataSourceContract;

  setUpAll(() {
    provideDummy<BaseResponse<CashOnDeliveryDto>>(
      SuccessBaseResponse<CashOnDeliveryDto>(
        data: CashOnDeliveryDto(message: "success"),
      ),
    );
    provideDummy<BaseResponse<CreditCardDto>>(
      SuccessBaseResponse<CreditCardDto>(
        data: CreditCardDto(message: "success"),
      ),
    );
  });

  setUp(() {
    mockCheckoutRemoteDataSourceContract =
        MockCheckoutRemoteDataSourceContract();
    checkoutRepoImpl = CheckoutRepoImpl(
      remoteDataSource: mockCheckoutRemoteDataSourceContract,
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
      'should return SuccessBaseResponse<CashOnDeliveryModel> when remote data source is successful',
      () async {
        when(
          mockCheckoutRemoteDataSourceContract.checkoutWithCashOnDelivery(
            tCheckoutParams,
          ),
        ).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CashOnDeliveryDto>(data: tCashOnDeliveryDto),
        );

        final result = await checkoutRepoImpl.checkoutWithCashOnDelivery(
          tCheckoutParams,
        );

        expect(result, isA<SuccessBaseResponse<CashOnDeliveryModel>>());
        final successResult =
            result as SuccessBaseResponse<CashOnDeliveryModel>;
        expect(successResult.data.orderNumber, "ORD-123");
        expect(successResult.data.paymentType, "cash");
        verify(
          mockCheckoutRemoteDataSourceContract.checkoutWithCashOnDelivery(
            tCheckoutParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCheckoutRemoteDataSourceContract);
      },
    );

    test(
      'should return ErrorBaseResponse<CashOnDeliveryModel> when remote data source fails',
      () async {
        final tFailure = Failure(message: 'Remote Error');
        when(
          mockCheckoutRemoteDataSourceContract.checkoutWithCashOnDelivery(
            tCheckoutParams,
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<CashOnDeliveryDto>(failure: tFailure),
        );

        final result = await checkoutRepoImpl.checkoutWithCashOnDelivery(
          tCheckoutParams,
        );

        expect(result, isA<ErrorBaseResponse<CashOnDeliveryModel>>());
        final errorResult = result as ErrorBaseResponse<CashOnDeliveryModel>;
        expect(errorResult.failure, tFailure);
        verify(
          mockCheckoutRemoteDataSourceContract.checkoutWithCashOnDelivery(
            tCheckoutParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCheckoutRemoteDataSourceContract);
      },
    );
  });

  group('checkoutWithCreditCard', () {
    test(
      'should return SuccessBaseResponse<CreditCardModel> when remote data source is successful',
      () async {
        when(
          mockCheckoutRemoteDataSourceContract.checkoutWithCreditCard(
            tCheckoutParams,
          ),
        ).thenAnswer(
          (_) async => SuccessBaseResponse<CreditCardDto>(data: tCreditCardDto),
        );

        final result = await checkoutRepoImpl.checkoutWithCreditCard(
          tCheckoutParams,
        );

        expect(result, isA<SuccessBaseResponse<CreditCardModel>>());
        final successResult = result as SuccessBaseResponse<CreditCardModel>;
        expect(successResult.data.url, "https://checkout.stripe.com/test");
        verify(
          mockCheckoutRemoteDataSourceContract.checkoutWithCreditCard(
            tCheckoutParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCheckoutRemoteDataSourceContract);
      },
    );

    test(
      'should return ErrorBaseResponse<CreditCardModel> when remote data source fails',
      () async {
        final tFailure = Failure(message: 'Remote Error');
        when(
          mockCheckoutRemoteDataSourceContract.checkoutWithCreditCard(
            tCheckoutParams,
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<CreditCardDto>(failure: tFailure),
        );

        final result = await checkoutRepoImpl.checkoutWithCreditCard(
          tCheckoutParams,
        );

        expect(result, isA<ErrorBaseResponse<CreditCardModel>>());
        final errorResult = result as ErrorBaseResponse<CreditCardModel>;
        expect(errorResult.failure, tFailure);
        verify(
          mockCheckoutRemoteDataSourceContract.checkoutWithCreditCard(
            tCheckoutParams,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockCheckoutRemoteDataSourceContract);
      },
    );
  });
}
