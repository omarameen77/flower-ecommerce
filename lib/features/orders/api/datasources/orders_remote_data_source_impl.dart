import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/orders/api/api_client/orders_api_client.dart';
import 'package:flower/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:flower/features/orders/data/models/response/orders_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrdersRemoteDataSourceContract)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSourceContract {
  final OrdersApiClient ordersApiClient;

  OrdersRemoteDataSourceImpl({required this.ordersApiClient});

  @override
  Future<BaseResponse<OrdersResponseDto>> getOrders(int page, int limit) async {
    try {
      final response = await ordersApiClient.getOrders(page, limit);
      return SuccessBaseResponse<OrdersResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<OrdersResponseDto>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
