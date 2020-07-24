import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=> _SplashState();
}
class _SplashState extends State<Splash>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.yellow ,
      body: Center(
        child: Container(
          child: Text('Loading...'),
        ),
      ),
    );
  }

}