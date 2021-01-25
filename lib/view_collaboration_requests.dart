import 'package:flutter/material.dart';
class CollabReq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.yellow,
          title: new Text('Collaboration Requests',
          style: new TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Collaboration requests displayed here')
            ],
          ),
        ),
      ),
    );
  }
}
