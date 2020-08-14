/*
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService
{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userInfo = Firestore.instance.collection('users');
  Future updateUserInfo(String firstName, String lastName, String age) async
  {
      return await userInfo.document(uid).setData({
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
      });
  }
  Future updateUserInfo2(String email, String password) async {
    return await userInfo.document(uid).setData({
      'email': email,
      'password': password,
    });
  }
}
 */