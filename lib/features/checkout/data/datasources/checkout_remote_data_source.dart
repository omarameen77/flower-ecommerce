import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout/data/models/response/cash_on_delivery_dto.dart';
import 'package:flower/features/checkout/data/models/response/credit_card_dto.dart';
import 'package:flower/features/checkout/domain/usecases/checkout_params.dart';

abstract class CheckoutRemoteDataSourceContract {
  Future<BaseResponse<CashOnDeliveryDto>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  );

  Future<BaseResponse<CreditCardDto>> checkoutWithCreditCard(
    CheckoutParams params,
  );
}
