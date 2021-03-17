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
  //String uid = FirebaseAuth.instance.currentUser.uid;
  //Getters
UserProvider(this.firstName, this.lastName, this.email, this.password, this.age,);

/*
saveUser() {
  var newUser = AppUser(firstName: firstName, lastName: lastName, age: age, email: email, password: password, userId: uid, bio: bio);
  firestoreService.saveUsers(newUser);
  print("$firstName, $lastName, $age, $email, $password");
}

 */
  Map<String,dynamic> toMap() {
    return {
      'userId' : FirebaseAuth.instance.currentUser.uid,
      'full_name': firstName + " "+ lastName,
      'first_name': firstName,
      'last_name': lastName,
      'emailid': email,
      'password': password,
      'age': age,
      'bio': "",
      'followers': 0,
      'following': 0,
      'profilePicture': (FirebaseAuth.instance.currentUser.photoURL != null)? FirebaseAuth.instance.currentUser.photoURL: 'https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg'
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