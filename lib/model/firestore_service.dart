import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
class FirestoreService extends ChangeNotifier{
  FirestoreService();
  static Future<dynamic> loadImage(BuildContext context, String uid) async{
    return await FirebaseStorage.instance.ref().child('user/$uid/profile pic').getDownloadURL();
  }

}
