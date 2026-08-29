import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchOrderStateUseCase {
  final TrackOrderRepoContract repo;

  WatchOrderStateUseCase(this.repo);

  Stream<TrackOrderEntity?> call({required String orderId}) {
    return repo.watchOrder(orderId: orderId);
  }
}
