import 'package:flutter/material.dart';

class Collaboration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: new Container(
        alignment: AlignmentDirectional.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=> Navigator.pop(context), iconSize: 30,),
              SizedBox(height: 20,),
              Text("Collaboration",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 60,),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              new FlatButton(
                minWidth: 400,
                height: 50,
                child: Text('Post a collaboration',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black)
                ),

                onPressed: (){
                  Navigator.pushNamed(context, '/post_collaborations');
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              new FlatButton(
                minWidth: 400,
                height: 50,
                child: Text('View Bulletin Board',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black)
                ),
                onPressed: (){
                  Navigator.pushNamed(context, '/collab');
                },
              ),
            ],
          )
      ),
    );
  }
}
