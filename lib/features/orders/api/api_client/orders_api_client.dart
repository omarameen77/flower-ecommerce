import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/core/resources/app_strings.dart';
import 'package:flower/features/orders/data/models/response/orders_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'orders_api_client.g.dart';

@RestApi()
abstract class OrdersApiClient {
  @factoryMethod
  factory OrdersApiClient(Dio dio, {String baseUrl}) = _OrdersApiClient;

  @GET(OrdersEndPoints.getOrders)
  Future<OrdersResponseDto> getOrders(
    @Query(AppStrings.page) int page,
    @Query(AppStrings.limit) int limit,
  );
}
