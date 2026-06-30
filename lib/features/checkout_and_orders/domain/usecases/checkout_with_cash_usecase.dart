import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/checkout_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutWithCashUseCase {
  final CheckoutRepo repo;

  CheckoutWithCashUseCase(this.repo);

  Future<BaseResponse<CashOnDeliveryModel>> call(CheckoutParams params) {
    return repo.checkoutWithCashOnDelivery(params);
  }
}
