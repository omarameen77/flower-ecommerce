import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConfirmDeliveryUseCase {
  final TrackOrderRepoContract repo;

  ConfirmDeliveryUseCase(this.repo);

  Future<BaseResponse<void>> call({required String orderId}) {
    return repo.confirmDelivery(orderId: orderId);
  }
}
