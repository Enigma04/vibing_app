import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> getCurrentUserUID();
  Future getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<void> resetPassword(String email);
}

class Auth extends BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }


  Future<String> getCurrentUserUID() async {
    return _firebaseAuth.currentUser.uid;
  }

  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
  Future<void> sendEmailVerification(){
    User user = _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  Future<void> resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}