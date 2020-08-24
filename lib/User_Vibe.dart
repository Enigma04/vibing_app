import 'package:flutter/material.dart';

class UserVibe extends StatefulWidget {
  @override
  _UserVibeState createState() => _UserVibeState();
}

class _UserVibeState extends State<UserVibe> {
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
              maxLength: 70,

            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            RaisedButton(
              onPressed: null,
              child: Text("Vibe"),
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
