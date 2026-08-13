import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout/domain/usecases/checkout_params.dart';

abstract class CheckoutRepo {
  Future<BaseResponse<CashOnDeliveryModel>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  );

  Future<BaseResponse<CreditCardModel>> checkoutWithCreditCard(
    CheckoutParams params,
  );
}
