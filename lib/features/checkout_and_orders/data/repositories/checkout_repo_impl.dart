import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/data/datasources/checkout_remote_data_source.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/cash_on_delivery_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/credit_card_dto.dart';
import 'package:flower/features/checkout_and_orders/domain/models/cash_on_delivery_model.dart';
import 'package:flower/features/checkout_and_orders/domain/models/credit_card_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/checkout_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckoutRepo)
class CheckoutRepoImpl implements CheckoutRepo {
  final CheckoutRemoteDataSourceContract remoteDataSource;

  CheckoutRepoImpl({required this.remoteDataSource});

  @override
  Future<BaseResponse<CashOnDeliveryModel>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  ) async {
    final response = await remoteDataSource.checkoutWithCashOnDelivery(params);
    return switch (response) {
      SuccessBaseResponse<CashOnDeliveryDto>() => SuccessBaseResponse<CashOnDeliveryModel>(
        data: response.data.toModel(),
      ),
      ErrorBaseResponse<CashOnDeliveryDto>() => ErrorBaseResponse<CashOnDeliveryModel>(
        failure: response.failure,
      ),
    };
  }

  @override
  Future<BaseResponse<CreditCardModel>> checkoutWithCreditCard(
    CheckoutParams params,
  ) async {
    final response = await remoteDataSource.checkoutWithCreditCard(params);
    return switch (response) {
      SuccessBaseResponse<CreditCardDto>() => SuccessBaseResponse<CreditCardModel>(
        data: response.data.toModel(),
      ),
      ErrorBaseResponse<CreditCardDto>() => ErrorBaseResponse<CreditCardModel>(
        failure: response.failure,
      ),
    };
  }
}
