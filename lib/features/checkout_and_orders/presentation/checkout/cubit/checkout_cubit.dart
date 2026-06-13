import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_with_cash_usecase.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_with_card_usecase.dart';
import 'package:flower/features/checkout_and_orders/presentation/checkout/cubit/checkout_event.dart';
import 'package:injectable/injectable.dart';

part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutWithCashUseCase _checkoutWithCashUseCase;
  final CheckoutWithCardUseCase _checkoutWithCardUseCase;

  CheckoutCubit(this._checkoutWithCashUseCase, this._checkoutWithCardUseCase)
    : super(const CheckoutState());

  Future<void> doEvent(CheckoutEvent event) async {
    switch (event) {
      case ChangePaymentMethod():
        emit(
          state.copyWith(
            selectedPayment: event.index,
            clearError: true,
            paymentUrl: null,
          ),
        );
      case ToggleGift():
        emit(state.copyWith(isGift: event.value, clearError: true));
      case PlaceOrderWithCash():
        await _placeOrderWithCash(event);
      case PlaceOrderWithCard():
        await _placeOrderWithCard(event);
      case PaymentCompleted():
        if (event.success) {
          emit(
            state.copyWith(status: CheckoutStatus.success, paymentUrl: null),
          );
        } else {
          emit(
            state.copyWith(status: CheckoutStatus.error, errorMessage: null),
          );
        }
    }
  }

  Future<void> _placeOrderWithCash(PlaceOrderWithCash event) async {
    emit(state.copyWith(status: CheckoutStatus.loading));

    final params = CheckoutParams(
      street: event.street,
      phone: event.phone,
      city: event.city,
      lat: event.lat,
      long: event.long,
    );

    final response = await _checkoutWithCashUseCase.call(params);

    switch (response) {
      case SuccessBaseResponse():
        emit(state.copyWith(status: CheckoutStatus.success, paymentUrl: null));
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: CheckoutStatus.error,
            errorMessage: response.failure.message,
          ),
        );
    }
  }

  Future<void> _placeOrderWithCard(PlaceOrderWithCard event) async {
    emit(state.copyWith(status: CheckoutStatus.loading));

    final params = CheckoutParams(
      street: event.street,
      phone: event.phone,
      city: event.city,
      lat: event.lat,
      long: event.long,
    );

    final response = await _checkoutWithCardUseCase.call(params);

    switch (response) {
      case SuccessBaseResponse<CreditCardModel>():
        emit(
          state.copyWith(
            status: CheckoutStatus.paymentPending,
            paymentUrl: response.data.url,
            successUrl: response.data.successUrl,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: CheckoutStatus.error,
            errorMessage: response.failure.message,
          ),
        );
    }
  }
}
