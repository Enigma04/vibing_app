
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibing_app/model/user_provider.dart';

import 'model/auth.dart';

class UserReg extends StatefulWidget {
  final UserProvider newUser;
  final BaseAuth auth;
  UserReg({Key key, @required this.newUser, this.auth}): super(key: key);

  @override
  _UserRegState createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _rEmailController = new TextEditingController();

  TextEditingController _rPasswordController = new TextEditingController();

  FilePickerResult getVideoFile;

  bool uploadVideoBool = false;

  bool uploadImageBool = false;

  String downloadVideoURL;

  String downloadImageURL;

  File image;

  checkUploadVideo() async
  {
    getVideoFile = await FilePicker.platform.pickFiles(type: FileType.video);
    if(getVideoFile != null)
    {
      setState(() {
        uploadVideoBool = true;
      });
      print(getVideoFile.files.single.path);
    }
    else
      print("User failed to upload video");
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
                widget.newUser.photoURL = downloadImageURL;
              });
               print(widget.newUser.photoURL);
            }
            catch(e) {
              print("Error: $e");
            }

      }
  }

  uploadVideo() async
  {
    if(uploadVideoBool == true)
    {
      try
      {
        File videoFile = File(getVideoFile.files.single.path);
        var storageReference = FirebaseStorage.instance.ref().child(
            "user/${FirebaseAuth.instance.currentUser.uid}/${getVideoFile.files.single.name}");
        var uploadTask = storageReference.putFile(videoFile);
        await uploadTask.whenComplete(() async{
          var completedTask =  uploadTask.snapshot;
          downloadVideoURL =  await completedTask.ref.getDownloadURL();
        });
        print(downloadVideoURL);
      }
      catch(e){
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _rEmailController.text = widget.newUser.email;
    _rPasswordController.text = widget.newUser.password;
    downloadImageURL = widget.newUser.photoURL;


    bool _validateAndSave()
    {
      final form = _formkey.currentState;
      if(form.validate())
      {
        form.save();
        return true;
      }
      return false;
    }

    void _validateAndSubmit() async
    {

      if(_validateAndSave()) {
        try {
          widget.newUser.email = _rEmailController.text;
          widget.newUser.password = _rPasswordController.text;
          UserCredential user  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget.newUser.email , password: widget.newUser.password);
          //String userId = user.toString();
          await uploadImage();
          user.user.updateProfile(displayName: widget.newUser.firstName+ " " +widget.newUser.lastName, photoURL: widget.newUser.photoURL);
          await checkUploadVideo();
          await uploadVideo();
          final String userUID = FirebaseAuth.instance.currentUser.uid;
          await FirebaseFirestore.instance.collection('user').doc(userUID).collection('user Info').doc(userUID).set(widget.newUser.toMap());
          await FirebaseFirestore.instance.collection('user search').doc(userUID).set(
              widget.newUser.toMap(),
          ).then((value){
            Fluttertoast.showToast(
              backgroundColor: Colors.green,
                msg: 'User ${FirebaseAuth.instance.currentUser.displayName} successfully registered!'
            );
            print('Registered! $userUID');
            _formkey.currentState.reset();
            Navigator.popUntil(context, (route) => route.isFirst);
          });

          //await Auth().sendEmailVerification();
        }
        catch (e) {
          Fluttertoast.showToast(
              backgroundColor: Colors.red,
              msg: e.toString().substring(36)
          );
          print('Error: $e');
        }
      }

    }

    final _regEmail = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _rEmailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (value){
          if(value.isEmpty)
            return 'Field cannot be empty';
          else if(value.isNotEmpty)
            {
              bool isValid = EmailValidator.validate(value);
              if(isValid == false)
                return 'Email is not valid';
              else
                return null;
            }
          else
            return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter Email Address',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );


    final _regpass = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller:  _rPasswordController,
        obscureText: true,
        autofocus: false,
        validator: (value){
          if(value.length <= 6)
            return "Character should be greater than 5";
          else if(value.isEmpty)
            return "Field cannot be empty";
          else
            return null;
        },
        decoration: InputDecoration(
          hintText: 'Enter password',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );

    GestureDetector profilePicture = GestureDetector(
      onTap: ()=> checkUploadImage(),
      child: CircleAvatar(
        radius: 60,
        child: image != null?
        CircleAvatar(
          radius: 55,
          backgroundImage: Image.file(image).image,
        ): CircleAvatar(
          radius: 55,
          backgroundColor: Colors.grey,
          child: Icon(Icons.camera_alt_rounded),
        ),
      ),
    );

    RaisedButton uploadVideoButton = RaisedButton(
      onPressed: (){
        checkUploadVideo();
      },
      child:  Text('Upload Video'),
      color: Colors.yellow,
    );
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height *0.2,),
                    Text('Register',
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 64,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                    profilePicture,
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    _regEmail,
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    _regpass,
                    SizedBox(height:MediaQuery.of(context).size.height * 0.03),
                    uploadVideoButton,
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    FloatingActionButton.extended(
                        heroTag: "Register_Button",
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        onPressed:  (){
                          _validateAndSubmit();
                        },
                        label: Text("Register", style: TextStyle(fontWeight: FontWeight.bold),)
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    FlatButton(
                      child: Text('Already Registered? Sign in!'),
                      onPressed: ()=> Navigator.popUntil(context, (route) => route.isFirst),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton.extended(
                            heroTag: "prev_button1",
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            onPressed:  ()=>  Navigator.pop(context),
                            label: Text("Prev", style: TextStyle(fontWeight: FontWeight.bold),)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

