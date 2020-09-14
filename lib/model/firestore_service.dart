import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibing_app/model/user.dart';
class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveUsers(User user) {
    return _db.collection('user').document(user.userId).setData(user.toMap());
  }


 /* Stream<List<userNames>> getUserNames()
  {
    return _db.collection('user').snapshots().map((snapshot) => snapshot.documents.map((document) => null))
  }

  */




}
