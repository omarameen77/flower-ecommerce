import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/notifications/domain/entity/notifications_response_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserNotificationsUseCase {
  final NotificationsRepoContract repository;

  GetUserNotificationsUseCase(this.repository);

  Future<BaseResponse<NotificationsResponseEntity>> call() async {
    return await repository.getUserNotifications();
  }
}
