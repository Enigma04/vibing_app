import 'package:flutter/material.dart';
import 'package:vibing_app/post_collaborations.dart';
import 'package:vibing_app/view_collaboration_requests.dart';
class Collaboration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Collaboration", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: new Container(
        alignment: AlignmentDirectional.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(

                child: Text('Post a collaboration'),
                color: Colors.yellow,
                onPressed: (){
                  Navigator.pushNamed(context, '/post_collaborations');
                },
                elevation: 5 ,
              ),
              new RaisedButton(
                child: Text('Your Collaborations'),
                color: Colors.yellow,
                onPressed: (){
                  Navigator.pushNamed(context, '/collab_requests');
                },
                elevation: 5 ,
              )
            ],
          )
      ),
    );
  }
}
