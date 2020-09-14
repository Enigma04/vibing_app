import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String firstName;
  final String lastName;
  final String userId;
  final String email;
  final String password;
  final int age;
  //final int gender;
  final String bio;

  User({this.userId, this.firstName, this.lastName,this.email,this.password, this.age, this.bio});

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

  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      userId: doc.documentID,
      firstName: doc['first_name'],
      lastName: doc['last_name'],
      email: doc['email'],
      age: doc['age'],
      bio: doc['bio'],

    );
  }

  /*
  User.fromFirestore(Map<String, dynamic> firestore)
     : firstName = firestore['first_name'],
      lastName = firestore['last_name'];

   */

}