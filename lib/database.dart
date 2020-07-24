/*import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices
{
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference userInfo = Firestore.instance.collection('users');
  Future updateUserInfo(String firstName, String lastName, int age) async
  {
      return await userInfo.document(uid);
  }
}

 */