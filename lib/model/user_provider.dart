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
   String photoURL;
   UserCredential user;

UserProvider(this.firstName, this.lastName, this.email, this.password,this.photoURL);


  Map<String,dynamic> toMap() {
    return {
      'userId' : FirebaseAuth.instance.currentUser.uid,
      'full_name': firstName + " "+ lastName,
      'first_name': firstName,
      'last_name': lastName,
      'emailid': email,
      'password': password,
      'bio': "",
      'profile_picture': photoURL,
      //'gender' : gender,
    };
  }



}