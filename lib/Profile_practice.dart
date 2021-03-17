import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibing_app/edit_user_profile.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:vibing_app/model/user.dart';

class PracticeProfile extends StatefulWidget {
  String profileId;

  PracticeProfile({this.profileId});

  @override
  _PracticeProfileState createState() => _PracticeProfileState();
}

class _PracticeProfileState extends State<PracticeProfile> {
  //User user = FirebaseAuth.instance.currentUser;
  static User currentUser = FirebaseAuth.instance.currentUser;
  final String currentUserId = currentUser?.uid;

  int count = 0;
  File profile_pic;
  bool isLoading = false;
  bool isFollowing = false;
  int followerCount = 0;
  int followingCount = 0;

  @override
  void initState()
  {
    super.initState();
    getFollowers();
    getFollowing();
    checkFollowing();
  }


  checkFollowing() async
  {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('user')
        .doc(widget.profileId).collection('followers').doc(currentUserId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  getFollowers() async
  {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('user')
        .doc(widget.profileId).collection('followers')
        .get();
    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

  getFollowing() async
  {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('user')
        .doc(widget.profileId).collection('following')
        .get();
    setState(() {
      followingCount = snapshot.docs.length;
    });
  }

  Container buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: FlatButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: isFollowing ? Colors.black : Colors.yellow,
          ),
        ),
      ),
      alignment: Alignment.center,
    );
  }

  buildCount({String label, int count})
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count.toString(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
          ),
        ),
      ],
    );
  }


  handleUnfollow()
  {
    setState(() {
      isFollowing = false;
    });
    FirebaseFirestore.instance.collection('user').doc(widget.profileId).collection('followers').doc(currentUserId).get().
    then((doc) {
      if(doc.exists)
        doc.reference.delete();
    });
    FirebaseFirestore.instance.collection('user').doc(currentUserId).collection('following').doc(widget.profileId).get().
    then((doc){
      if(doc.exists)
        doc.reference.delete();
    });
  }

  handleFollow()
  {
    setState(() {
      isFollowing = true;
    });
    FirebaseFirestore.instance.collection('user').doc(widget.profileId).collection('followers').doc(currentUserId).set({});
    FirebaseFirestore.instance.collection('user').doc(currentUserId).collection('following').doc(widget.profileId).set({});
  }

  buildProfileHeader()
  {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('user search').doc(widget.profileId).get(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return CircularProgressIndicator();
          AppUser user = AppUser.fromDocument(snapshot.data);
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: FlatButton(
                        child: null,
                        onPressed: null,
                      ),
                      backgroundImage: (user.photoURL != null) ?
                      Image
                          .network(user.photoURL)
                          .image : Image
                          .network(
                          "https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg")
                          .image,
                    ),
                    Expanded(
                      flex: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildCount(label: "Followers", count: followerCount),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                                buildCount(label: "Following", count: followingCount)
                              ],
                            ),
                          ],
                        ),

                    )

                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 12),
                  child: Text(user.fullName),

                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 5),
                  child: Text(user.bio),
                ),
              ],
            ),
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    editProfileButton()
    {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile(currentUserId: currentUserId,))); }
      );
    }

    buildProfileButton()
    {
      bool isProfileOwner = currentUserId == widget.profileId;
      if(isProfileOwner)
        return buildButton(
          text: "Edit Profile",
          function: editProfileButton,
        );
      if(isFollowing)
      {
        return buildButton(
          text: "Unfollow",
          function: handleUnfollow,
        );
      }
      else if(!isFollowing)
      {
        return buildButton(
          text: "Follow",
          function: handleFollow,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice profile test"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           buildProfileHeader(),
            Divider(),
            buildProfileButton(),
            Divider(),
            Text("Posts"),
            Padding(
              padding:
              EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(widget.profileId)
                      .collection('post')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      //scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot myPost = snapshot.data.docs[index];
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.2,
                              child: Card(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading:
                                        Icon(Icons.supervised_user_circle),
                                        title:
                                        Text('${myPost.data()['user_name']}'),
                                        subtitle:
                                        Text("${myPost.data()['post']}"),
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
                                  )),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );

  }

}