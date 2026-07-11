import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserToken({
    required String userId,
    required String token,
  }) async {
    await _firestore.collection('user_tokens').doc(userId).set({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getUserToken(String userId) async {
    final doc = await _firestore.collection('user_tokens').doc(userId).get();

    if (!doc.exists) return null;

    return doc.data()?['token'];
  }
}
