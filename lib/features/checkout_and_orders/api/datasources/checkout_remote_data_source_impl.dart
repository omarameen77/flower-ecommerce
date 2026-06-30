import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/api/api_client/checkout_api_client.dart';
import 'package:flower/features/checkout_and_orders/data/datasources/checkout_remote_data_source.dart';
import 'package:flower/features/checkout_and_orders/data/models/request/checkout_request_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/cash_on_delivery_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/credit_card_dto.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckoutRemoteDataSourceContract)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSourceContract {
  final CheckoutApiClient checkoutApiClient;

  CheckoutRemoteDataSourceImpl({required this.checkoutApiClient});

  @override
  Future<BaseResponse<CashOnDeliveryDto>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  ) async {
    try {
      final response = await checkoutApiClient.checkoutWithCashOnDelivery(
        CheckoutRequestDto(
          shippingAddress: ShippingAddressDto(
            street: params.street,
            phone: params.phone,
            city: params.city,
            lat: params.lat,
            long: params.long,
          ),
        ),
      );
      return SuccessBaseResponse<CashOnDeliveryDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CashOnDeliveryDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<CreditCardDto>> checkoutWithCreditCard(
    CheckoutParams params,
  ) async {
    try {
      final response = await checkoutApiClient.checkoutWithCreditCard(
        CheckoutRequestDto(
          shippingAddress: ShippingAddressDto(
            street: params.street,
            phone: params.phone,
            city: params.city,
            lat: params.lat,
            long: params.long,
          ),
        ),
      );
      return SuccessBaseResponse<CreditCardDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CreditCardDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
