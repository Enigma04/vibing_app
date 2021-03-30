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
      profile_picture: doc['photourl'],
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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
