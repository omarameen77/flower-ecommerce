import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_with_cash_usecase.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_with_card_usecase.dart';
import 'package:flower/features/checkout_and_orders/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:flower/features/checkout_and_orders/presentation/checkout/cubit/checkout_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_cubit_test.mocks.dart';

@GenerateMocks([CheckoutWithCashUseCase, CheckoutWithCardUseCase])
void main() {
  late CheckoutCubit checkoutCubit;
  late MockCheckoutWithCashUseCase mockCheckoutWithCashUseCase;
  late MockCheckoutWithCardUseCase mockCheckoutWithCardUseCase;

  setUpAll(() {
    provideDummy<BaseResponse<CashOnDeliveryModel>>(
      SuccessBaseResponse<CashOnDeliveryModel>(
        data: CashOnDeliveryModel(message: "success"),
      ),
    );
    provideDummy<BaseResponse<CreditCardModel>>(
      SuccessBaseResponse<CreditCardModel>(
        data: CreditCardModel(message: "success"),
      ),
    );
  });

  setUp(() {
    mockCheckoutWithCashUseCase = MockCheckoutWithCashUseCase();
    mockCheckoutWithCardUseCase = MockCheckoutWithCardUseCase();
    checkoutCubit = CheckoutCubit(
      mockCheckoutWithCashUseCase,
      mockCheckoutWithCardUseCase,
    );
  });

  tearDown(() {
    checkoutCubit.close();
  });

  group('CheckoutCubit', () {
    test('initial state is correct', () {
      expect(checkoutCubit.state, const CheckoutState());
    });

    group('ChangePaymentMethod', () {
      test('changes selected payment method and clears error', () {
        checkoutCubit.doEvent(const ChangePaymentMethod(1));

        expect(checkoutCubit.state.selectedPayment, 1);
        expect(checkoutCubit.state.errorMessage, isNull);
        expect(checkoutCubit.state.paymentUrl, isNull);
      });

      test('changes to another payment method', () {
        checkoutCubit.doEvent(const ChangePaymentMethod(0));

        expect(checkoutCubit.state.selectedPayment, 0);
      });
    });

    group('ToggleGift', () {
      test('toggles gift from false to true', () {
        checkoutCubit.doEvent(const ToggleGift(true));

        expect(checkoutCubit.state.isGift, true);
      });

      test('toggles gift from true to false', () {
        checkoutCubit.doEvent(const ToggleGift(true));
        checkoutCubit.doEvent(const ToggleGift(false));

        expect(checkoutCubit.state.isGift, false);
      });
    });

    group('PlaceOrderWithCash', () {
      test(
        'emits loading then success when use case returns SuccessBaseResponse',
        () async {
          when(mockCheckoutWithCashUseCase.call(any)).thenAnswer(
            (_) async => SuccessBaseResponse<CashOnDeliveryModel>(
              data: CashOnDeliveryModel(
                message: "success",
                orderNumber: "ORD-123",
              ),
            ),
          );

          checkoutCubit.doEvent(
            const PlaceOrderWithCash(
              street: "123 Main St",
              phone: "1234567890",
              city: "New York",
              lat: "40.7128",
              long: "74.0060",
            ),
          );

          expect(checkoutCubit.state.status, CheckoutStatus.loading);

          await Future.delayed(Duration.zero);

          expect(checkoutCubit.state.status, CheckoutStatus.success);
          expect(checkoutCubit.state.paymentUrl, isNull);
          verify(mockCheckoutWithCashUseCase.call(any)).called(1);
        },
      );

      test(
        'emits loading then error when use case returns ErrorBaseResponse',
        () async {
          when(mockCheckoutWithCashUseCase.call(any)).thenAnswer(
            (_) async => ErrorBaseResponse<CashOnDeliveryModel>(
              failure: Failure(message: 'Checkout error'),
            ),
          );

          checkoutCubit.doEvent(
            const PlaceOrderWithCash(
              street: "123 Main St",
              phone: "1234567890",
              city: "New York",
              lat: "40.7128",
              long: "74.0060",
            ),
          );

          expect(checkoutCubit.state.status, CheckoutStatus.loading);

          await Future.delayed(Duration.zero);

          expect(checkoutCubit.state.status, CheckoutStatus.error);
          expect(checkoutCubit.state.errorMessage, 'Checkout error');
        },
      );
    });

    group('PlaceOrderWithCard', () {
      test(
        'emits loading then paymentPending when use case returns SuccessBaseResponse',
        () async {
          when(mockCheckoutWithCardUseCase.call(any)).thenAnswer(
            (_) async => SuccessBaseResponse<CreditCardModel>(
              data: CreditCardModel(
                message: "success",
                url: "https://checkout.stripe.com/test",
              ),
            ),
          );

          checkoutCubit.doEvent(
            const PlaceOrderWithCard(
              street: "123 Main St",
              phone: "1234567890",
              city: "New York",
              lat: "40.7128",
              long: "74.0060",
            ),
          );

          expect(checkoutCubit.state.status, CheckoutStatus.loading);

          await Future.delayed(Duration.zero);

          expect(checkoutCubit.state.status, CheckoutStatus.paymentPending);
          expect(
            checkoutCubit.state.paymentUrl,
            "https://checkout.stripe.com/test",
          );
          verify(mockCheckoutWithCardUseCase.call(any)).called(1);
        },
      );

      test(
        'emits loading then error when use case returns ErrorBaseResponse',
        () async {
          when(mockCheckoutWithCardUseCase.call(any)).thenAnswer(
            (_) async => ErrorBaseResponse<CreditCardModel>(
              failure: Failure(message: 'Card error'),
            ),
          );

          checkoutCubit.doEvent(
            const PlaceOrderWithCard(
              street: "123 Main St",
              phone: "1234567890",
              city: "New York",
              lat: "40.7128",
              long: "74.0060",
            ),
          );

          expect(checkoutCubit.state.status, CheckoutStatus.loading);

          await Future.delayed(Duration.zero);

          expect(checkoutCubit.state.status, CheckoutStatus.error);
          expect(checkoutCubit.state.errorMessage, 'Card error');
        },
      );
    });

    group('PaymentCompleted', () {
      test('emits success status when payment completed successfully', () {
        checkoutCubit.doEvent(const PaymentCompleted(success: true));

        expect(checkoutCubit.state.status, CheckoutStatus.success);
        expect(checkoutCubit.state.paymentUrl, isNull);
      });

      test('emits error status when payment failed', () {
        checkoutCubit.doEvent(const PaymentCompleted(success: false));

        expect(checkoutCubit.state.status, CheckoutStatus.error);
      });
    });
  });
}
