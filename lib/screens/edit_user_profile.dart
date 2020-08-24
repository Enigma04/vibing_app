import 'package:flutter/material.dart';
import 'package:vibing_app/User_Profile.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        child: Text("Edit profile changes here"),
      ),
    );
  }
}
