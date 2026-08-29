import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/checkout/data/datasources/order_user_info_firestore_data_source.dart';
import 'package:flower/features/checkout/domain/repositories/order_user_info_repo.dart';
import 'package:flower/features/checkout/domain/usecases/order_user_info_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderUserInfoRepo)
class OrderUserInfoRepoImpl implements OrderUserInfoRepo {
  final OrderUserInfoFirestoreDataSourceContract _firestoreDataSource;

  OrderUserInfoRepoImpl(this._firestoreDataSource);

  @override
  Future<BaseResponse<void>> saveOrderUserInfo({
    required String orderId,
    required OrderUserInfoParams params,
  }) {
    return _firestoreDataSource.saveOrderUserInfo(
      orderId: orderId,
      params: params,
    );
  }
}
