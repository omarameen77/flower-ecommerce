import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower/features/notifications/data/datasource/notifications_firestore_data_source_contract.dart';
import 'package:flower/features/notifications/data/model/notifications_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsFirestoreDataSourceContract)
class NotificationsFirestoreDataSourceImpl
    implements NotificationsFirestoreDataSourceContract {
  final FirebaseFirestore _firestore;

  NotificationsFirestoreDataSourceImpl(this._firestore);

  @override
  Stream<List<NotificationsDto>> getUserNotifications(String userId) {
    return _firestore
        .collection("notifications")
        .doc(userId)
        .collection("items")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final dto = NotificationsDto.fromJson(doc.data());
            dto.id = doc.id;
            return dto;
          }).toList(),
        );
  }

  @override
  Stream<int> getUnreadNotificationsCount(String userId) {
    return _firestore
        .collection("notifications")
        .doc(userId)
        .collection("items")
        .where("isRead", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Future<void> markAsRead({
    required String userId,
    required String notificationId,
  }) async {
    await _firestore
        .collection("notifications")
        .doc(userId)
        .collection("items")
        .doc(notificationId)
        .update({"isRead": true});
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    await _firestore
        .collection("notifications")
        .doc(userId)
        .collection("items")
        .doc(notificationId)
        .delete();
  }
}
