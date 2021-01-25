import 'package:flutter/material.dart';
class PostCollaborations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.yellow,
          title: new Text('Your Collaborations',
          style: TextStyle(fontWeight: FontWeight.bold) ,
            textAlign: TextAlign.center,)
        ),
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Post Collaboration detailss....')
            ],
          ),
        ),
      )
    );
  }
}
