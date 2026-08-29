import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
