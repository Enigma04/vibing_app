import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PostCollaborations extends StatelessWidget {
  TextEditingController _lookingForController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  String get _lookingForText => _lookingForController.text;
  String get _locationText => _locationController.text;
  String get _descriptionText => _descriptionController.text;

  String currentUser = FirebaseAuth.instance.currentUser.uid;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    postCollaboration()
    {
      final form = _formkey.currentState;
      if(form.validate())
      {
        FirebaseFirestore.instance.collection('collaborationPosts').doc(Timestamp.now().toString()).set(
            {
              "posted_by": FirebaseAuth.instance.currentUser.displayName,
              "time": Timestamp.now().toString(),
              "looking_for": _lookingForText,
              "location": _locationText,
              "description": _descriptionText,
              "photoURL": FirebaseAuth.instance.currentUser.photoURL != null?  FirebaseAuth.instance.currentUser.photoURL : "https://t4.ftcdn.net/jpg/03/32/59/65/360_F_332596535_lAdLhf6KzbW6PWXBWeIFTovTii1drkbT.jpg",
            }
        ).then((value) {
          print("Collaboration posted!!");
          Navigator.pop(context);
        });
        form.reset();
      }
      else
        print("An error occured");
    }

    Container lookingFor = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _lookingForController,
        keyboardType:  TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Looking for: ',
          hintText: 'Eg. Guitarist, Singer, Pianist',
          suffixIcon: Icon(Icons.music_note_outlined),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        validator:(value)=> value.isEmpty ? "Field cannot be empty":  null ,
      ),
    );

    Container location = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _locationController,
        keyboardType:  TextInputType.streetAddress,
        decoration: InputDecoration(
          labelText: 'Where are you located? : ',
          hintText: 'Eg. Mumbai, India .',
          suffixIcon: Icon(Icons.location_city),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        validator:(value)=> value.isEmpty ? "Field cannot be empty":   null,
      ),
    );

    Container description = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: _descriptionController,
        keyboardType:  TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Description (Optional): ',
          hintText: 'A proper description for better understanding of your requirement',
          suffixIcon: Icon(Icons.description),
          contentPadding: EdgeInsets.symmetric(vertical: 50),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );

    Column _column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
        Text("Post your Collaboration Request. ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
        lookingFor,
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        location,
        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
        description,
        SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
        RaisedButton(
          onPressed: () {
            postCollaboration();
          },
          color: Colors.yellow,
          child: Text("Post!"),
        ),
      ],
    );

    return new Container(
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.yellow,
        body: SingleChildScrollView(
          reverse: true,
          child:  Container(
        child: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width *0.8, top: MediaQuery.of(context).size.height *0.1),
              child:  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=> Navigator.pop(context), iconSize: 30,),
            ),
            _column,
          ],
        ),
          ),
        ),
    ),
      ),
      );

  }
}
