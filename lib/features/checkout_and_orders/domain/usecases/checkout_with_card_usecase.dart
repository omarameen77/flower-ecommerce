import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/checkout_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutWithCardUseCase {
  final CheckoutRepo repo;

  CheckoutWithCardUseCase(this.repo);

  Future<BaseResponse<CreditCardModel>> call(CheckoutParams params) {
    return repo.checkoutWithCreditCard(params);
  }
}
