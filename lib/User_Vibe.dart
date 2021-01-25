import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'package:vibing_app/model/user.dart';


class UserVibe extends StatefulWidget {
  @override
  _UserVibeState createState() => _UserVibeState();
}

class _UserVibeState extends State<UserVibe> {
  String post;
    User user = FirebaseAuth.instance.currentUser;
  //Future<QuerySnapshot> userName =
  //var userName = User.;
  getPost(post){
    this.post = post;
  }
  final _formkey = GlobalKey<FormState>();

  vibe(){
    DocumentReference ds = FirebaseFirestore.instance.collection('user_posts').doc(Timestamp.now().toDate().toString());
    Map <String, dynamic> userPost={
      'post': post,
      'time': Timestamp.now().toDate(),
      'user_name': user.displayName,
    };
    ds.set(userPost).whenComplete(() => print("Posted!"));
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Vibe", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: _formkey,
              maxLength: 70,
              onChanged: (String post){
                getPost(post);
              },
              decoration: InputDecoration(
                hintText: 'Enter Post',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            RaisedButton(
              onPressed: (){
                vibe();
                Navigator.pop(context);
              },
                child: Text("Vibe"),
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
