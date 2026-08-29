import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/orders/domain/models/order_model.dart';

abstract class OrdersRepo {
  Future<BaseResponse<List<OrderModel>>> getOrders(int page, int limit);
}
