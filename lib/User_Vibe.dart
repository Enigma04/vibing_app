import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vibing_app/model/auth.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'package:vibing_app/model/user.dart';


class UserVibe extends StatefulWidget {
  @override
  _UserVibeState createState() => _UserVibeState();
}

class _UserVibeState extends State<UserVibe> {
  String post;
    User user = FirebaseAuth.instance.currentUser;
    bool uploadedFile = false;
    TextEditingController vibeController = new TextEditingController();
    String downloadURL;
  FilePickerResult getAudioFile;
  //Future<QuerySnapshot> userName =
  //var userName = User.;
  getPost(post){
    this.post = post;
  }
  final _formkey = GlobalKey<FormState>();

  Future vibe() async{
    DocumentReference ds = FirebaseFirestore.instance.collection('user_posts').doc(Timestamp.now().toDate().toString());
    DocumentReference ds1 = FirebaseFirestore.instance.collection('user').doc(user.uid).collection('post').doc(Timestamp.now().toDate().toString());
    if(uploadedFile == false && vibeController.text.isNotEmpty)
      {
        Map <String, dynamic> userPost={
          'post': post,
          'time': Timestamp.now().toDate(),
          'user_name': user.displayName,
          'profile_picture' : user.photoURL,
          'uid': user.uid,
        };
        ds.set(userPost).whenComplete(() => print("Posted!"));
        ds1.set(userPost).whenComplete(() => print("Saved in user's personal file"));
      }
    else if(uploadedFile == true && vibeController.text.isNotEmpty)
      {
        File audioFile = File(getAudioFile.files.single.path);
        var storageReference = FirebaseStorage.instance.ref().child(
            "user/${FirebaseAuth.instance.currentUser.uid}/${getAudioFile.files.single.name}");
        var uploadTask = storageReference.putFile(audioFile);
        var completedTask =  uploadTask.snapshot;
        downloadURL = await completedTask.ref.getDownloadURL();
        print(downloadURL);
        Map <String, dynamic> userPost={
          'post': post,
          'time': Timestamp.now().toDate(),
          'user_name': user.displayName,
          'profile_picture' : user.photoURL,
          'uid': user.uid,
          'audioFile': downloadURL,
        };
        ds.set(userPost).whenComplete(() => print("Posted with file!"));
        ds1.set(userPost).whenComplete(() => print("Saved in user's personal file"));
      }
    else if(vibeController.text.isEmpty)
      {
        print("Text is empty and won't be uploaded");
      }

  }

  checkUploadAudio() async
  {
     getAudioFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['.mp3', '.aac']);
    if(getAudioFile != null)
      {
        uploadedFile = true;
        print(getAudioFile.files.single.path);
      }
    else
      print("User failed to upload audio");
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Vibe", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: vibeController,
              key: _formkey,
              maxLength: 70,
              onChanged: (String post){
                getPost(post);
              } ,
              decoration: InputDecoration(
                hintText: 'Enter Post',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            RaisedButton(
              onPressed: (){
                vibe().then((value) => Navigator.pop(context));
              },
                child: Text("Vibe"),
              color: Colors.yellow,
            ),
            RaisedButton(onPressed: checkUploadAudio, child: Text("Upload Audio"), color: Colors.yellow,)
          ],
        ),
      ),
    );
  }
}
