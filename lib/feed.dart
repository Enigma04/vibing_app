import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/collaboration.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:vibing_app/search.dart';
import 'package:vibing_app/your_sound_recording_list.dart';


class Feed extends StatefulWidget {
  Feed({this.auth,this.otherUsers});
  final BaseAuth auth;
  final User otherUsers;

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  String email = "";
  bool isPlaying;
  bool isLiked;
  int selectedIndex;
  int selectedLike;
  int likeCount;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
  }



  @override
  void initState()
  {
    FirebaseAuth.instance.currentUser.reload();
    selectedIndex = -1;
    selectedLike = -1;
    isPlaying = false;
    isLiked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: (FirebaseAuth.instance.currentUser.photoURL != null)? Image.network(FirebaseAuth.instance.currentUser.photoURL).image : Image.network("https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg").image,
                  ),
                  Text('${FirebaseAuth.instance.currentUser.displayName}'),
                ],
              ) ,
              decoration: BoxDecoration(
                color:Colors.yellow,
              ),
            ),
            ListTile(
                title: Text('Profile'),
                trailing: Icon(
                  Icons.supervised_user_circle,
                ),
                onTap: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>PracticeProfile(profileId: FirebaseAuth.instance.currentUser?.uid,) ));
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
                  User user =  await Auth().getCurrentUser();
                  await Auth().signOut().then((value)async{
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.remove('email');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin(auth: new Auth())));
                    print("Signed ${user.displayName} out successfully!");
                    Fluttertoast.showToast(
                        msg: "Signed ${user.displayName} out successfully!"
                    );
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
        actions: [
          IconButton(icon: Icon(Icons.search,
            color: Colors.white,),
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> UserSearch()))),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=> Feed(), transitionDuration: Duration(seconds: 0)));
          return Future.value(false);
        },
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('user_posts').orderBy("time",descending: true).get(),
          builder:(context, snapshot){
            if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
            {
              return ListView.builder(
                itemCount: snapshot.data.docs.length ,
                itemBuilder: (context,index){
                  DocumentSnapshot myPost = snapshot.data.docs[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: null,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child:  Card(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:(myPost.data()['profile_picture'] != null)? Image.network(myPost.data()['profile_picture']).image: Image.network("https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg").image,
                                    ),
                                    title: Text('${myPost.data()['user_name']}'),
                                    subtitle: Text("${myPost.data()['post']}"),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ButtonBar(
                                        children: <Widget>[
                                          IconButton(
                                            icon: (selectedLike != index ) ? Icon(Icons.favorite_border): Icon(Icons.favorite, color: Colors.pink,),
                                            onPressed: () {
                                              if(!isLiked){
                                                setState(() {
                                                  isLiked = true;
                                                  selectedLike = index;
                                                });
                                              }
                                              else if(isLiked){
                                                setState(() {
                                                  isLiked = false;
                                                  selectedLike = -1;
                                                });
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.comment),
                                            color: Colors.lightBlue,
                                            onPressed: (){

                                            },
                                          ),
                                          myPost.data()['audioFile'] != null? IconButton(
                                            icon: (selectedIndex == index && !isPlaying) ? Icon(Icons.pause): Icon(Icons.music_note_sharp),
                                            onPressed:()async{
                                              if(!isPlaying)
                                              {
                                                isPlaying = true;
                                                setState(() {
                                                  selectedIndex = index;
                                                });
                                                audioPlayer.play(await myPost.data()['audioFile'], isLocal: false);
                                                audioPlayer.onPlayerCompletion.listen((event) {
                                                  setState(() {
                                                    isPlaying = false;
                                                    selectedIndex = -1;
                                                  });
                                                });
                                              }
                                              else
                                              {
                                                await audioPlayer.pause();
                                                isPlaying = false;
                                              }
                                              setState(() {});
                                            },
                                            color: Colors.black,
                                          ): null,

                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
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

showUserProfile(BuildContext context, {String profileID})
{
  Navigator.push(context, MaterialPageRoute(builder: (context)=> PracticeProfile(profileId: profileID,)));
}

