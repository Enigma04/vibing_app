
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibing_app/model/auth.dart';

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

