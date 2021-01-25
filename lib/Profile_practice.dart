import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/model/auth.dart';

class PracticeProfile extends StatefulWidget {
  @override
  _PracticeProfileState createState() => _PracticeProfileState();
}

class _PracticeProfileState extends State<PracticeProfile> {
 final User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice profile test"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${user.displayName}'),
            SizedBox(height: 20,),
            Text('${user.email}'),
            SizedBox(height: 20,),
            Text('${user.uid}'),
          ],
        ),
      ),
    );
  }
}
