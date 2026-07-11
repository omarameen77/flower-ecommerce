import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteNotificationUseCase {
  final NotificationsRepoContract repository;

  DeleteNotificationUseCase(this.repository);

  Future<void> call({required String userId, required String notificationId}) {
    return repository.deleteNotification(
      userId: userId,
      notificationId: notificationId,
    );
  }
}
