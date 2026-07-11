import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkNotificationAsReadUseCase {
  final NotificationsRepoContract repository;

  MarkNotificationAsReadUseCase(this.repository);

  Future<void> call({required String userId, required String notificationId}) {
    return repository.markAsRead(
      userId: userId,
      notificationId: notificationId,
    );
  }
}
