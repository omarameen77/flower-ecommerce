import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/track_order/data/datasources/track_order_firestore_data_source.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/entities/tracking_status.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderDataSourceContract)
class TrackOrderDataSourceImpl implements TrackOrderDataSourceContract {
  final FirebaseFirestore firestore;

  static const _collection = "current_orders";

  TrackOrderDataSourceImpl({required this.firestore});

  @override
  Stream<TrackOrderEntity?> watchOrder({required String orderId}) {
    return firestore.collection(_collection).doc(orderId).snapshots().map((
      snapshot,
    ) {
      final data = snapshot.data();
      if (data == null) return null;
      return TrackOrderEntity.fromMap({...data, 'orderId': orderId});
    });
  }

  @override
  Future<BaseResponse<void>> confirmDelivery({required String orderId}) async {
    try {
      await firestore.collection(_collection).doc(orderId).update({
        'driverRequestedDelivery': true,
        'isDelivered': true,
        'state': TrackingStatus.completed.name,
        'order.isDelivered': true,
        'order.state': TrackingStatus.completed.name,
      });
      return SuccessBaseResponse<void>(data: null);
    } catch (e) {
      return ErrorBaseResponse<void>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<void>> saveCurrentOrder({
    required String orderId,
    required TrackOrderEntity order,
  }) async {
    try {
      await firestore
          .collection(_collection)
          .doc(orderId)
          .set(order.toMap(), SetOptions(merge: true));
      return SuccessBaseResponse<void>(data: null);
    } catch (e) {
      return ErrorBaseResponse<void>(failure: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<TrackOrderEntity?>> getCurrentOrder({
    required String orderId,
  }) async {
    try {
      final snapshot = await firestore
          .collection(_collection)
          .doc(orderId)
          .get();

      if (!snapshot.exists) {
        return SuccessBaseResponse<TrackOrderEntity?>(data: null);
      }

      final data = snapshot.data();
      if (data == null) {
        return SuccessBaseResponse<TrackOrderEntity?>(data: null);
      }

      return SuccessBaseResponse<TrackOrderEntity?>(
        data: TrackOrderEntity.fromMap({...data, 'orderId': orderId}),
      );
    } catch (e) {
      return ErrorBaseResponse<TrackOrderEntity?>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<void>> deleteCurrentOrder({
    required String orderId,
  }) async {
    try {
      await firestore.collection(_collection).doc(orderId).delete();
      return SuccessBaseResponse<void>(data: null);
    } catch (e) {
      return ErrorBaseResponse<void>(failure: ErrorHandler.handle(e));
    }
  }
}
