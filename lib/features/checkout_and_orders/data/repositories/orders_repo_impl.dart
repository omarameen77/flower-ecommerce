import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/data/datasources/orders_remote_data_source.dart';
import 'package:flower/features/checkout_and_orders/data/models/response/orders_response_dto.dart';
import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSourceContract remoteDataSource;

  OrdersRepoImpl({required this.remoteDataSource});

  @override
  Future<BaseResponse<List<OrderModel>>> getOrders(int page, int limit) async {
    final response = await remoteDataSource.getOrders(page, limit);
    return switch (response) {
      SuccessBaseResponse<OrdersResponseDto>() => SuccessBaseResponse<List<OrderModel>>(
        data: (response.data.orders ?? [])
            .map((e) => e.toModel())
            .toList(),
      ),
      ErrorBaseResponse<OrdersResponseDto>() => ErrorBaseResponse<List<OrderModel>>(
        failure: response.failure,
      ),
    };
  }
}
