import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/model/user.dart';

class EditProfile extends StatefulWidget {
  String currentUserId;
  EditProfile({this.currentUserId});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController bioController = new TextEditingController();
  bool isLoading = false;
  AppUser user;
  bool bioValid = true;
  bool uploadImageBool = false;
  File image;
  String downloadImageURL;
  @override
  void initstate()
  {
    super.initState();
    FirebaseAuth.instance.currentUser.reload();
    getUser();

  }

  getUser() async
  {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('user search').doc(widget.currentUserId).get();
    user = AppUser.fromDocument(doc);
    bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }
  
  Column updateBioField()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10),
          child: Text('Bio',
          style: TextStyle(color: Colors.white54),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: 'Update Bio',
            errorText: bioValid ? null: 'Bio too long',
          ),
        ),
      ],
    );
  }
/*
  Future <String> pickImage() async
  {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    File profile_pic = File(pickedFile.path);
    var storageReference = FirebaseStorage.instance.ref().child(
        "user/profile/${FirebaseAuth.instance.currentUser.uid}");
    var uploadTask = storageReference.putFile(profile_pic);
    await uploadTask.whenComplete(() async{
      var completedTask = await uploadTask.snapshot;
      String downloadURL = await completedTask.ref.getDownloadURL();
      FirebaseAuth.instance.currentUser.updateProfile(photoURL: downloadURL);
      var dr = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('userInfo').doc(FirebaseAuth.instance.currentUser.uid).update({"profilePicture": downloadURL});
      var dr2 = FirebaseFirestore.instance.collection("user search").doc(FirebaseAuth.instance.currentUser.uid).update(
          {"profilePicture": downloadURL});
      print(dr);
      print(dr2);
    });
  }

 */

  uploadImage() async
  {
    if(uploadImageBool == true)
    {
      try
      {
        var storageReference = FirebaseStorage.instance.ref().child(
            "user/${FirebaseAuth.instance.currentUser.uid}/profile pic");
        var uploadTask = storageReference.putFile(image);
        await uploadTask.whenComplete(()async{
          var completedTask = uploadTask.snapshot;
          downloadImageURL =  await completedTask.ref.getDownloadURL();
          FirebaseAuth.instance.currentUser.updateProfile(photoURL: downloadImageURL);
        });
        print(downloadImageURL);
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: 'Profile Picture updated successfully'
        ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PracticeProfile(profileId: FirebaseAuth.instance.currentUser?.uid,))));
      }
      catch(e) {
        Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: '$e'
        );
        print("Error: $e");
      }

    }
  }

  checkUploadImage() async
  {

    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    File profile_pic = File(pickedFile.path);
    if(profile_pic!= null)
    {
      setState(() {
        uploadImageBool = true;
        image = profile_pic;
      });
    }
    else
      print("Failed to upload image");
  }




  FlatButton changePicButton()
  {
    return FlatButton(
        onPressed: uploadImage,
        child: Text("Upload Profile Picture")
    );
  }



  updateProfileData()
  {
    setState(() {
      bioController.text.trim().length > 100 ? bioValid = false: bioValid = true;
    });
    if(bioValid)
      {
        FirebaseFirestore.instance.collection('user search').doc(widget.currentUserId).update({
          "bio": bioController.text
        });
        FirebaseFirestore.instance.collection('user').doc(widget.currentUserId).collection('user info').doc().update({
          "bio": bioController.text
        });
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
            msg: 'Bio updated!'
        ).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PracticeProfile())));
      }
    else
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
          msg: 'Something went wrong, try again');
  }
  Widget build(BuildContext context) {

    GestureDetector profilePicture = GestureDetector(
      onTap: ()=> checkUploadImage(),
      child: CircleAvatar(
        radius: 90,
        child: image != null?
        CircleAvatar(
          radius: 85,
          backgroundImage: Image.file(image).image,
        ): CircleAvatar(
          radius: 85,
          backgroundImage: Image.network(FirebaseAuth.instance.currentUser.photoURL).image,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Colors.yellow,
      ),
      body: RefreshIndicator(
        onRefresh: (){
          Navigator.push(context, PageRouteBuilder(pageBuilder: (a,b,c)=> EditProfile(), transitionDuration: Duration(seconds: 0)));
          return Future.value(false);
        },
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            profilePicture,
            SizedBox(height: 6,),
            changePicButton(),
            SizedBox(height: 6,),
            updateBioField(),
            SizedBox(height: 6,),
            FlatButton(onPressed: updateProfileData, child: Text('Update Bio'))
          ],
        ),
      )

    );
  }
}
