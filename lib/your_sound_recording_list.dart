import 'package:flutter/material.dart';

class UserSoundRecordingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Your Recordings',
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Recordings will be displayed here!')
          ],
        ),
      ),
    );
  }
}
