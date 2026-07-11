import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout_and_orders/domain/repositories/order_user_info_repo.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/order_user_info_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveOrderUserInfoUseCase {
  final OrderUserInfoRepo _repo;

  SaveOrderUserInfoUseCase(this._repo);

  Future<BaseResponse<void>> call({
    required String orderId,
    required OrderUserInfoParams params,
  }) {
    return _repo.saveOrderUserInfo(orderId: orderId, params: params);
  }
}
