import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibing_app/user.dart';
class FirestoreService {
  Firestore _db = Firestore.instance;
  Future<void> saveUsers(User user)
  {
    return _db.collection('user').document(user.userId).setData(user.toMap());
  }
}