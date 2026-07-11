import 'package:flower/core/mapper/notifications_mapper/notifications_mapper.dart';
import 'package:flower/features/notifications/data/datasource/notifications_firestore_data_source_contract.dart';
import 'package:flower/features/notifications/domain/entity/notifications_entity.dart';
import 'package:flower/features/notifications/domain/repository/notifications_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepoContract)
class NotificationsRepoImpl implements NotificationsRepoContract {
  final NotificationsFirestoreDataSourceContract firestoreDataSource;

  NotificationsRepoImpl(this.firestoreDataSource);

  @override
  Stream<List<NotificationsEntity>> getUserNotifications(String userId) {
    return firestoreDataSource
        .getUserNotifications(userId)
        .map((event) => event.map((e) => e.toDomain()).toList());
  }

  @override
  Stream<int> getUnreadNotificationsCount(String userId) {
    return firestoreDataSource.getUnreadNotificationsCount(userId);
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) {
    return firestoreDataSource.markAsRead(
      userId: userId,
      notificationId: notificationId,
    );
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) {
    return firestoreDataSource.deleteNotification(
      userId: userId,
      notificationId: notificationId,
    );
  }
}
