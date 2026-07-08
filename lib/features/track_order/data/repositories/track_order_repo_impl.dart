import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/track_order/data/datasources/track_order_firestore_data_source.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRepoContract)
class TrackOrderRepoImpl implements TrackOrderRepoContract {
  final TrackOrderDataSourceContract dataSource;

  TrackOrderRepoImpl({required this.dataSource});

  @override
  Stream<TrackOrderEntity?> watchOrder({required String orderId}) {
    return dataSource.watchOrder(orderId: orderId);
  }

  @override
  Future<BaseResponse<void>> confirmDelivery({required String orderId}) {
    return dataSource.confirmDelivery(orderId: orderId);
  }

  @override
  Future<BaseResponse<void>> saveCurrentOrder({
    required String orderId,
    required TrackOrderEntity order,
  }) {
    return dataSource.saveCurrentOrder(orderId: orderId, order: order);
  }

  @override
  Future<BaseResponse<TrackOrderEntity?>> getCurrentOrder({
    required String orderId,
  }) {
    return dataSource.getCurrentOrder(orderId: orderId);
  }

  @override
  Future<BaseResponse<void>> deleteCurrentOrder({required String orderId}) {
    return dataSource.deleteCurrentOrder(orderId: orderId);
  }
}
