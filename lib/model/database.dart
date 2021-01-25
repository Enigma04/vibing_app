
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibing_app/model/auth.dart';
/*
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
class DataBaseService {

  String uid = Auth().getCurrentUserUID().toString();

  Future getCurrentUserData() async{
    try{
      DocumentSnapshot ds =  await FirebaseFirestore.instance.collection('user').doc(uid).collection('user info').doc().get();
      String firstName = ds.get('first_name');
      String lastName = ds.get('last_name');
      return[firstName,lastName];
    }
    catch(c)
    {
      print(c.toString());
      return null;
    }
  }
}

