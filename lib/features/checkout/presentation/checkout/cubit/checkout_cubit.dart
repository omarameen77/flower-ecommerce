import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flower/features/checkout/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout/domain/usecases/checkout_params.dart';
import 'package:flower/features/checkout/domain/usecases/checkout_with_cash_usecase.dart';
import 'package:flower/features/checkout/domain/usecases/checkout_with_card_usecase.dart';
import 'package:flower/features/checkout/domain/usecases/order_user_info_params.dart';
import 'package:flower/features/checkout/domain/usecases/save_order_user_info_use_case.dart';
import 'package:flower/features/checkout/presentation/checkout/cubit/checkout_event.dart';
import 'package:injectable/injectable.dart';

part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutWithCashUseCase _checkoutWithCashUseCase;
  final CheckoutWithCardUseCase _checkoutWithCardUseCase;
  final SaveOrderUserInfoUseCase _saveOrderUserInfoUseCase;
  final GetProfileUseCase _getProfileUseCase;

  String? _pendingOrderId;
  CheckoutParams? _pendingCheckoutParams;

  CheckoutCubit(
    this._checkoutWithCashUseCase,
    this._checkoutWithCardUseCase,
    this._saveOrderUserInfoUseCase,
    this._getProfileUseCase,
  ) : super(const CheckoutState());

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
          await _saveUserInfoAfterPayment();
          emit(
            state.copyWith(status: CheckoutStatus.success, paymentUrl: null),
          );
        } else {
          _clearPendingOrder();
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
      case SuccessBaseResponse<CashOnDeliveryModel>():
        await _saveOrderUserInfo(
          orderId: response.data.orderId ?? '',
          params: params,
        );
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
        _pendingOrderId = response.data.orderId;
        _pendingCheckoutParams = params;
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

  Future<void> _saveUserInfoAfterPayment() async {
    if (_pendingOrderId == null || _pendingCheckoutParams == null) return;
    await _saveOrderUserInfo(
      orderId: _pendingOrderId!,
      params: _pendingCheckoutParams!,
    );
    _clearPendingOrder();
  }

  Future<void> _saveOrderUserInfo({
    required String orderId,
    required CheckoutParams params,
  }) async {
    final profileResponse = await _getProfileUseCase.call();

    String? userName;
    String? userPhone;
    String? userImage;

    if (profileResponse is SuccessBaseResponse) {
      final user = (profileResponse as SuccessBaseResponse).data;
      userName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
      userPhone = user.phone;
      userImage = user.photo;
    }

    final userInfoParams = OrderUserInfoParams(
      street: params.street,
      phone: params.phone,
      city: params.city,
      lat: params.lat,
      long: params.long,
      userName: userName,
      userPhone: userPhone,
      userImage: userImage,
    );

    await _saveOrderUserInfoUseCase.call(
      orderId: orderId,
      params: userInfoParams,
    );
  }

  void _clearPendingOrder() {
    _pendingOrderId = null;
    _pendingCheckoutParams = null;
  }
}
