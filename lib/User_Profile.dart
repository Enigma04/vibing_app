import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


  static final _profilePic = CircleAvatar(
    backgroundColor: Colors.yellow,
    child: Text("Rohit"),
    radius: 60
  );

  static final _userName = Text("Rohit Thukral");


  @override
  Widget build(BuildContext context) {

     final _editUserProfileButton = RaisedButton(
      onPressed: ()=> Navigator.pushNamed(context, '/edit_user_profile'),
      color: Colors.yellow,
      child: Text("Edit Profile"),
    );

      final _followersButton = FlatButton(
       onPressed: null,
       child: Text("Followers",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
     );

      final _followingButton = FlatButton(
       onPressed: null,
       child: Text("Following", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
     );

     final _profileCard = Container(
       height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 5 ,
      child: Card(
        margin: EdgeInsets.all(8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: MediaQuery.of(context).size.height *0.01,),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child:_profilePic,
                ),
                SizedBox(width: MediaQuery.of(context).size.width *0.06,),
                _followersButton,
                SizedBox(width: MediaQuery.of(context).size.width *0.06,),
                _followingButton,
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.01,),
         Container(
           margin: EdgeInsets.all(5),
           child:_userName,
         ),
            SizedBox(height: MediaQuery.of(context).size.height *0.005,),
            Text("Rohit Gurunath Sharma is an Indian international cricketer who plays for Mumbai in domestic cricket and captains Mumbai Indians in the Indian Premier League as a right-handed batsman and an occasional right-arm off break bowler. He is the vice-captain of the Indian national team in limited-overs formats.", style: TextStyle(
                fontSize: 14.0
            ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _editUserProfileButton,
                  ],
                )
            ),
          ],
        ),
      ),
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
            _profileCard,
           SizedBox(height: MediaQuery.of(context).size.height *0.001,),
           _viewRecordingButton,
          ],
        ),
      ),
    );
  }
}
