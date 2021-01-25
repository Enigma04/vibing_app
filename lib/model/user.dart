import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {

  String firstName;
  String lastName;
  String userId;
  String email;
  String password;
  int age;
  //final int gender;
  String bio;

  AppUser({this.userId, this.firstName, this.lastName,this.email,this.password, this.age, this.bio});

  Map<String,dynamic> toMap()
  {
    return {
      'userId' : userId,
      'first_name' : firstName,
      'last_name' : lastName,
      'emailid' : email,
      'password': password,
      'age' : age,
      'bio': bio,
      //'gender' : gender,
    };

  }

  factory AppUser.fromDocument(DocumentSnapshot docu){
    return AppUser(
      userId: docu.data()['uid'],
      firstName: docu.data()['first_name'],
      lastName: docu.data()['last_name'],
      email: docu.data()['email'],
      age: docu.data()['age'],
      bio: docu.data()['bio'],

    );
  }
  




  /*
  User.fromFirestore(Map<String, dynamic> firestore)
     : firstName = firestore['first_name'],
      lastName = firestore['last_name'];

   */

}