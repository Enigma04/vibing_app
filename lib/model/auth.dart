import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  //Future<String> signUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
 // Future<bool> isEmailVerified();
  Future<void> resetPassword(String email);
}

class Auth extends BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user.uid;
  }

  /*
  Future<String> signUp(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

   */

  Future<String> getCurrentUser() {
    User user = _firebaseAuth.currentUser;
    String uid = user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
  Future<void> sendEmailVerification(){
    User user = _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }
  /*Future<bool> isEmailVerified() {
    User user = _firebaseAuth.currentUser;
    return user.isEmailVerified();
  }

   */
  Future<void> resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}