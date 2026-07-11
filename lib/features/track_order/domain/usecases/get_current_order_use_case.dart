import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentOrderUseCase {
  final TrackOrderRepoContract repo;

  GetCurrentOrderUseCase(this.repo);

  Future<BaseResponse<TrackOrderEntity?>> call({
    required String orderId,
  }) {
    return repo.getCurrentOrder(orderId: orderId);
  }
}
