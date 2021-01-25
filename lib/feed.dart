
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vibing_app/Profile_practice.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/collaboration.dart';
import 'package:vibing_app/your_sound_recording_list.dart';
import 'package:vibing_app/settings.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'User_Vibe.dart';

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
int count = 0;

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
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder:(context)=>UserProfile(userProfileId: FirebaseAuth.instance.currentUser.uid)),);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PracticeProfile()));
                }
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
              onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>UserSettings()),);},
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
                     String user =  await Auth().getCurrentUser();
                     await Auth().signOut().then((value){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin()));
                       print("Signed $user out successfully!");
                     });

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user_posts').orderBy("time",descending: true).snapshots() ,
        builder:(context, snapshot){
          if(!snapshot.hasData)
            {
              Center(
                child: CircularProgressIndicator() ,
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length ,
                itemBuilder: (context,index){
                DocumentSnapshot myPost = snapshot.data.docs[index];
                return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child:  Card(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.supervised_user_circle),
                                  title: Text('${myPost.data()['user_name']}'),
                                  subtitle: Text("${myPost.data()['post']}"),

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
                      ),
                    ],
                  ),
                ],
                );
                },
            );

        },
      ),
      bottomNavigationBar: Container(
                color: Colors.yellow,
                height: 60,
                child: InkWell(
                  onTap: ()=> Navigator.pushNamed(context, '/vibe'),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text("Vibe")
                      ],
                    ),
                  )
                ),
              ),
            );
  }
}

