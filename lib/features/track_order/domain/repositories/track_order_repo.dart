import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';

abstract interface class TrackOrderRepoContract {
  Stream<TrackOrderEntity?> watchOrder({required String orderId});

  Future<BaseResponse<void>> confirmDelivery({required String orderId});

  Future<BaseResponse<void>> saveCurrentOrder({
    required String orderId,
    required TrackOrderEntity order,
  });

  Future<BaseResponse<TrackOrderEntity?>> getCurrentOrder({
    required String orderId,
  });

  Future<BaseResponse<void>> deleteCurrentOrder({required String orderId});
}
