import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveCurrentOrderUseCase {
  final TrackOrderRepoContract repo;

  SaveCurrentOrderUseCase(this.repo);

  Future<BaseResponse<void>> call({
    required String orderId,
    required TrackOrderEntity order,
  }) {
    return repo.saveCurrentOrder(orderId: orderId, order: order);
  }
}
