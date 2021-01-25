import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibing_app/model/user.dart';
class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUsers(AppUser user) {
    return _db.collection('user').doc(user.userId).set(user.toMap());
  }


 /* Stream<List<userNames>> getUserNames()
  {
    return _db.collection('user').snapshots().map((snapshot) => snapshot.documents.map((document) => null))
  }

  */




}
