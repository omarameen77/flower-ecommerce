import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/orders_response_dto.dart';

abstract class OrdersRemoteDataSourceContract {
  Future<BaseResponse<OrdersResponseDto>> getOrders(int page, int limit);
}
