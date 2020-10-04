import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/model/firestore_service.dart';
import 'user.dart';
import 'auth.dart';

class UserProvider with ChangeNotifier{
  final firestoreService = new FirestoreService();
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _bio;
  int _age;
 // int _gender;
  var Uuid = FirebaseAuth.instance.currentUser.uid.toString();
  //Getters
String get firstName => _firstName;
String get lastName => _lastName;
String get email => _email;
String get password => _password;
int get age  => _age;
String get bio => _bio;
//int get gender => _gender;
  //Setters
changeFirstName(String value){
  _firstName = value;
  notifyListeners();
}
changeLastName(String value){
  _lastName = value;
  notifyListeners();
}
changeAge(String value){
  _age = int.parse(value);
  notifyListeners();
}
changeEmail(String value){
  _email = value;
  notifyListeners();
}
changePassword(String value){
  _password = value;
  notifyListeners();
}

saveUser() {
  var newUser = AppUser(firstName: firstName, lastName: lastName, age: age, email: email, password: password, userId: Uuid, bio: bio);
  firestoreService.saveUsers(newUser);
  print("$firstName, $lastName, $age, $email, $password");
}

}