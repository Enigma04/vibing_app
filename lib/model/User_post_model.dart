import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String time;
  final String ownerID;
  final String user_name;
  final String description;
  final String profile_picture;
  final dynamic likes;

  Post({this.time, this.ownerID, this.user_name, this.description, this.likes, this.profile_picture});

  factory Post.fromDocument(DocumentSnapshot doc){
    return Post(
      time: doc['time'],
      ownerID: doc['uid'],
      user_name: doc['user_name'],
      description: doc['post'],
      profile_picture: doc['profile_picture'],
      likes: doc['likes'],

    );
  }

  int getLikes(likes)
  {
    if(likes == 0)
      return 0;
    int count =0;
    likes.values.forEach((val){
      if(val==true){
        count += 1;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(

    time: this.time,
    ownerID: this.ownerID,
    user_name: this.user_name,
    description: this.description,
    profile_picture: this.profile_picture,
    likes: this.likes,
    likeCount: getLikes(this.likes),

  );

}

class _PostState extends State<Post> {
  static User currentUser = FirebaseAuth.instance.currentUser;
  final String currentUserId = currentUser?.uid;
  final String ownerID;
  final String user_name;
  final String time;
  final String description;
  final String profile_picture;
  bool showHeart = false;
  bool isLiked;
  int likeCount;
  Map likes;
  _PostState({
    this.ownerID,
    this.profile_picture,
    this.user_name,
    this.time,
    this.likes,
    this.description,
    this.likeCount
  });


  handleLikes()
  {
    bool _isLiked = likes[currentUserId] = true;
    if(_isLiked)
    {
      FirebaseFirestore.instance.collection('user_posts').doc(time).update({'likes.$currentUserId': false});
      removeLikeFromActivityFeed();
      setState(() {
        likeCount -=1;
        isLiked = false;
        likes[currentUserId] = false;
      });

    }
    else if(!_isLiked)
    {
      FirebaseFirestore.instance.collection('user_posts').doc(time).update({'likes.$currentUserId': true});
      addLikeToActivityFeed();
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  addLikeToActivityFeed() {
    // add a notification to the postOwner's activity feed only if comment made by OTHER user (to avoid getting notification for our own like)
    bool isNotPostOwner = currentUserId != ownerID;
    if (isNotPostOwner) {
      FirebaseFirestore.instance
          .doc(time)
          .set({
        "full_name": currentUser.displayName,
        "userId": currentUser.uid,
        "userProfileImg": currentUser.photoURL,
        "timestamp": time,
      });
    }
  }

  removeLikeFromActivityFeed() {
    bool isNotPostOwner = currentUserId != ownerID;
    if (isNotPostOwner) {
      FirebaseFirestore.instance
          .doc(time)
          .get()
          .then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }
  }

  buildLikes(){
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('user_posts').get(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
            {
               return Column(
                 children: [
                   IconButton(
                       icon: (!isLiked) ? Icon(Icons.favorite_border): Icon(Icons.favorite, color: Colors.pink,),
                       onPressed: handleLikes
                   ),
                   Row(
                     children: <Widget>[
                       Container(
                         //margin: EdgeInsets.only(left: 20.0),
                         child: Text(
                           "$likeCount likes",
                           style: TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
               );
            }
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return buildLikes();
  }
}
