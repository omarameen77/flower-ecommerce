import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/domain/entity/un_read_count_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUnReadNotificationCountUseCase {
  final NotificationsRepoContract notificationsRepoContract;

  GetUnReadNotificationCountUseCase(this.notificationsRepoContract);

  Future<BaseResponse<UnReadCountEntity>> call() async {
    return await notificationsRepoContract.getUnReadNotificationsCount();
  }
}
