import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:provider/provider.dart';
import 'package:vibing_app/edit_user_profile.dart';
import 'package:vibing_app/model/database.dart';
import 'package:vibing_app/model/provider.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'main.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:vibing_app/model/user.dart';
class UserProfile extends StatefulWidget {
  //final UserProvider userProvider;
  final String userProfileId;
  UserProfile({Key key, this.userProfileId}): super(key:key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String currentUserId = FirebaseAuth.instance.currentUser.uid.toString();
  String get getCurrentId => widget.userProfileId;



  static final _profilePic = CircleAvatar(
    backgroundColor: Colors.yellow,
    child: Text("Rohit"),
    radius: 60
  );


  static final _userName = Text("Rohit");
  static dynamic names = DataBaseService().getCurrentUserData();
  String firstName = names[0];
  String lastName = names[1];
  final uid = Auth().getCurrentUserUID().toString();
  Stream<QueryDocumentSnapshot> displayUserInfo(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUserUID();
    yield* FirebaseFirestore.instance.collection('user').doc(uid).collection('user info').doc().snapshots();
  }
  //FirebaseFirestore.instance.collection('user').doc(currentUserId).collection('user info').doc().get();

  createProfileTopView() {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('user').doc(uid).collection('user info').doc().get(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        AppUser user = AppUser.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            socialNumbers('followers',0),
                            socialNumbers('following', 0),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 8),
                          child: Text(user.firstName+ " "+ user.lastName),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 8),
                          child: Text('${FirebaseAuth.instance.currentUser.email}'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  socialNumbers(String title, int count)
  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

     final _editUserProfileButton = RaisedButton(
      onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile(currentUserId: currentUserId))),
      color: Colors.yellow,
      child: Text("Edit Profile"),
    );

     createButton(){
       bool ownProfile = currentUserId == widget.userProfileId;
       if(ownProfile){
         return _editUserProfileButton;
       }
     }

      final _followersButton = FlatButton(
       onPressed: null,
       child: Text("Followers",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
     );

      final _followingButton = FlatButton(
       onPressed: null,
       child: Text("Following", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
     );



     final _viewRecordingButton = Container(
       margin: EdgeInsets.all(5),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         RaisedButton.icon(onPressed: ()=> Navigator.pushNamed(context, '/your_sound_recording'),
             icon: Icon(Icons.music_note),
             label: Text("View your Recordings")
         ),
       ],
       ),
     );

     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Profile", style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createProfileTopView(),
            createButton(),
           SizedBox(height: MediaQuery.of(context).size.height *0.001,),
           _viewRecordingButton,
            SizedBox(height: MediaQuery.of(context).size.height *0.001,),
            Text(widget.userProfileId),
          ],
        ),
      ),
    );
  }
}
