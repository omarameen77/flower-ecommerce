import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/orders/domain/models/order_model.dart';
import 'package:flower/features/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrdersUseCase {
  final OrdersRepo repo;

  GetOrdersUseCase(this.repo);

  Future<BaseResponse<List<OrderModel>>> call(int page, int limit) {
    return repo.getOrders(page, limit);
  }
}
