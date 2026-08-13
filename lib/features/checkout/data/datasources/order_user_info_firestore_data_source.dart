import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout/domain/usecases/order_user_info_params.dart';

abstract class OrderUserInfoFirestoreDataSourceContract {
  Future<BaseResponse<void>> saveOrderUserInfo({
    required String orderId,
    required OrderUserInfoParams params,
  });
}
