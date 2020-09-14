import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibing_app/edit_user_profile.dart';
import 'main.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:vibing_app/model/user.dart';
class UserProfile extends StatefulWidget {
  final String userProfileId;
  UserProfile({this.userProfileId});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String currentUserId = Auth().getCurrentUser().toString();


  static final _profilePic = CircleAvatar(
    backgroundColor: Colors.yellow,
    child: Text("Rohit"),
    radius: 60
  );

  static final _userName = Text("Rohit");

  createProfileTopView() {
    return FutureBuilder(
      future: Firestore.instance.collection('user').document(widget.userProfileId).get(),
      builder: (context,dataSnapshot){
        if(!dataSnapshot.hasData){
          return CircularProgressIndicator();
        }
        User user = User.fromDocument(dataSnapshot.data);
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
                          child: Text(user.userId),
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
          ],
        ),
      ),
    );
  }
}
