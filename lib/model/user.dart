
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {

  String firstName;
  String lastName;
  String userId;
  String email;
  String password;
  String bio;
  String photoURL;
  String fullName;

  AppUser({this.userId, this.firstName, this.lastName,this.email,this.password, this.bio, this.photoURL, this.fullName});

  Map<String,dynamic> toMap()
  {
    return {
      'userId' : userId,
      'first_name' : firstName,
      'last_name' : lastName,
      'emailid' : email,
      'password': password,
      'bio': bio,
      //'gender' : gender,
    };

  }

  factory AppUser.fromDocument(DocumentSnapshot docu){
    return AppUser(
      userId: docu.data()['userId'],
      //userId: docu.id,
      fullName: docu.data()['full_name'],
      firstName: docu.data()['first_name'],
      lastName: docu.data()['last_name'],
      email: docu.data()['email'],
      bio: docu.data()['bio'],
      photoURL: docu.data()['profile_picture'],

    );
  }
  




  /*
  User.fromFirestore(Map<String, dynamic> firestore)
     : firstName = firestore['first_name'],
      lastName = firestore['last_name'];

   */

}