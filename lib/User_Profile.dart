import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Scaffold(
          appBar: new AppBar(
              backgroundColor: Colors.yellow,
              title: Text('Profile',
                style: TextStyle(fontWeight: FontWeight.bold) ,
                textAlign: TextAlign.center,)
          ),
          body: new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Profile details here')
              ],
            ),
          ),
        )
    );
  }
}
