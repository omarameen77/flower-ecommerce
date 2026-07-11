import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserNotificationsUseCase {
  final NotificationsRepoContract repository;

  GetUserNotificationsUseCase(this.repository);

  Stream<List<NotificationsEntity>> call(String userId) {
    return repository.getUserNotifications(userId);
  }
}
