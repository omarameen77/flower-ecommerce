import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUnreadNotificationCountUseCase {
  final NotificationsRepoContract repository;

  GetUnreadNotificationCountUseCase(this.repository);

  Stream<int> call(String userId) {
    return repository.getUnreadNotificationsCount(userId);
  }
}
