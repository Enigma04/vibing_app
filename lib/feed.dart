
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vibing_app/auth.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/collaboration.dart';
import 'package:vibing_app/your_sound_recording_list.dart';
import 'package:vibing_app/settings.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Feed extends StatelessWidget {
  Feed({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

/*
  void _signOut() async {
    try{

      await Auth().signOut();
      print('signed out!');
      //onSignedOut();
    }
    catch(e){
      print(e);
    }

  }

 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Profile') ,
              decoration: BoxDecoration(

                color:Colors.yellow,
              ),
            ),
            ListTile(
                title: Text('Profile'),
                trailing: Icon(
                  Icons.supervised_user_circle,
                ),
                onTap: () {Navigator.push(context, MaterialPageRoute(builder:(context)=>UserProfile()),);}
            ),
            ListTile(
              title: Text('Collaborations'),
              trailing: Icon(
                Icons.accessibility_new,
              ),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>Collaboration()),);},
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(
                Icons.settings,
              ),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>Settings()),);},
            ),
            ListTile(
              title: Text('Your Recordings'),
              trailing: Icon(
                Icons.audiotrack,
              ),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>UserSoundRecordingList()),);},
            ),
            ListTile(
                title: Text('Sign out'),
                trailing: Icon(
                    Icons.keyboard_tab,
                ),
                onTap: () async{
                  try{
                    String user = await Auth().getCurrentUser();
                    await Auth().signOut().then((value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin()));
                    });
                    print("Signed user $user out successfully!");
                  }
                  catch(e)
                  {
                    print(e);
                  }
                  },

            ),
            ListTile(
              title: Text('Cancel'),
              trailing: Icon(
                Icons.cancel,
              ),
              onTap: ()=>Navigator.pop(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Feed',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,),
      ),
      body: CustomScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Card(

                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.supervised_user_circle),
                                        title: Text('Profile 1'),
                                        subtitle: Text(
                                            "Want y'all to listen to this amazing song!!!"),

                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_comment),
                                            color: Colors.lightBlue,
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Card(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.supervised_user_circle),
                                        title: Text('Profile 1'),
                                        subtitle: Text(
                                            "Want y'all to listen to this amazing song!!!"),

                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_comment),
                                            color: Colors.lightBlue,
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Card(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.supervised_user_circle),
                                        title: Text('Profile 1'),
                                        subtitle: Text(
                                            "Want y'all to listen to this amazing song!!!"),

                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_comment),
                                            color: Colors.lightBlue,
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Card(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.supervised_user_circle),
                                        title: Text('Profile 1'),
                                        subtitle: Text(
                                            "Want y'all to listen to this amazing song!!!"),

                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_comment),
                                            color: Colors.lightBlue,
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Card(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.supervised_user_circle),
                                        title: Text('Profile 1'),
                                        subtitle: Text(
                                            "Want y'all to listen to this amazing song!!!"),

                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_comment),
                                            color: Colors.lightBlue,
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Card(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.supervised_user_circle),
                                        title: Text('Profile 1'),
                                        subtitle: Text(
                                            "Want y'all to listen to this amazing song!!!"),

                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.favorite_border),
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add_comment),
                                            color: Colors.lightBlue,
                                            alignment: Alignment(-60, 0),
                                            onPressed: null,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                           BottomAppBar(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             FloatingActionButton(
                               child: Text("Vibe"),
                               backgroundColor: Colors.yellow,
                               onPressed: null,
                               autofocus: true,
                               tooltip: 'Vibe'
                             ),
                           ],
                           )
                           ),
                            ],
                          )
                        ]
                      ),
                    ),
                  ],
                ),
            );
  }
}

/*Card(
margin: EdgeInsets.all(5) ,
child: Column(
children: <Widget>[
ListTile(
leading: Icon(Icons.supervised_user_circle),
title: Text('Profile 1'),
subtitle: Text("Want y'all to listen to this amazing song!!"),
),
ButtonBar(
children: <Widget>[
IconButton(
icon: Icon(Icons.favorite,
color: Colors.grey,
),
alignment: Alignment(-60,0) ,
),
IconButton(
icon: Icon(Icons.comment,
color: Colors.lightBlueAccent,),
alignment: Alignment(-58,0),
)
],
),
],
),
),
 */