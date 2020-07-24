import 'package:flutter/material.dart';
import 'package:vibing_app/post_collaborations.dart';
import 'package:vibing_app/view_collaboration_requests.dart';
class Collaboration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: AlignmentDirectional.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              
              child: Text('Post a collaboration'),
              color: Colors.yellow,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>PostCollaborations()),);
              },
              elevation: 5 ,
            ),
            new RaisedButton(
              child: Text('Your Collaborations'),
              color: Colors.yellow,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>CollabReq()),);
              },
              elevation: 5 ,
            )
          ],
        )
    );
  }
}
