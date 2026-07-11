import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/checkout_and_orders/data/datasources/order_user_info_firestore_data_source.dart';
import 'package:flower/features/checkout_and_orders/domain/usecases/order_user_info_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderUserInfoFirestoreDataSourceContract)
class OrderUserInfoFirestoreDataSourceImpl
    implements OrderUserInfoFirestoreDataSourceContract {
  final FirebaseFirestore firestore;

  static const _collection = "order's_user_info";

  OrderUserInfoFirestoreDataSourceImpl({required this.firestore});

  @override
  Future<BaseResponse<void>> saveOrderUserInfo({
    required String orderId,
    required OrderUserInfoParams params,
  }) async {
    try {
      await firestore
          .collection(_collection)
          .doc(orderId)
          .set(params.toMap(), SetOptions(merge: true));
      return SuccessBaseResponse<void>(data: null);
    } catch (e) {
      return ErrorBaseResponse<void>(failure: ErrorHandler.handle(e));
    }
  }
}
