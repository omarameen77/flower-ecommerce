import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/checkout_and_orders/data/models/request/checkout_request_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/cash_on_delivery_dto.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/credit_card_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'checkout_api_client.g.dart';

@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio, {String baseUrl}) = _CheckoutApiClient;

  @POST(CheckoutEndPoints.createCashOrder)
  Future<CashOnDeliveryDto> checkoutWithCashOnDelivery(
    @Body() CheckoutRequestDto request,
  );

  @POST(CheckoutEndPoints.checkoutSession)
  Future<CreditCardDto> checkoutWithCreditCard(
    @Body() CheckoutRequestDto request,
  );
}
