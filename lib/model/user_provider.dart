import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/model/firestore_service.dart';
import 'user.dart';
import 'auth.dart';

class UserProvider{
  final firestoreService = new FirestoreService();
   String firstName;
   String lastName;
   String email;
   String password;
   String bio;
   String age;
  int _gender;
  var uid = FirebaseAuth.instance.currentUser.uid.toString();
  //Getters
UserProvider(this.firstName, this.lastName, this.email, this.password, this.age, this.bio, this.uid);

/*
saveUser() {
  var newUser = AppUser(firstName: firstName, lastName: lastName, age: age, email: email, password: password, userId: uid, bio: bio);
  firestoreService.saveUsers(newUser);
  print("$firstName, $lastName, $age, $email, $password");
}

 */
  Map<String,dynamic> toMap() {
    return {
      'userId' : uid,
      'first_name': firstName,
      'last_name': lastName,
      'emailid': email,
      'password': password,
      'age': age,
      'bio': bio,
      //'gender' : gender,
    };
  }

/*
  factory UserProvider.fromDocument(DocumentSnapshot docu){
    return UserProvider(
      uid: docu.data()['uid'],
      firstName: docu.data()['first_name'],
      lastName: docu.data()['last_name'],
      email: docu.data()['email'],
      age: docu.data()['age'],
      bio: docu.data()['bio'],

    );
  }

 */


}