
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/model/firestore_service.dart';
import 'package:vibing_app/user_details_registeration.dart';
import 'package:vibing_app/model/database.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'model/auth.dart';
import 'package:vibing_app/feed.dart';
import 'model/user.dart';

class UserReg extends StatelessWidget {
  final UserProvider newUser;
  final BaseAuth auth;
  UserReg({Key key, @required this.newUser, this.auth}): super(key: key);
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    TextEditingController _rEmailController = new TextEditingController();
    TextEditingController _rPasswordController = new TextEditingController();
    _rEmailController.text = newUser.email;
    _rPasswordController.text = newUser.password;

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
          newUser.email = _rEmailController.text;
          newUser.password = _rPasswordController.text;
          UserCredential user  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: newUser.email , password: newUser.password);
          String userId = user.toString();
          user.user.updateProfile(displayName: newUser.firstName+ " " +newUser.lastName);
          final String userUID = FirebaseAuth.instance.currentUser.uid;
          //final uid = users.uid;
          FirebaseFirestore.instance.collection('user').doc(userUID).collection('user Info').add(newUser.toMap());
          FirebaseFirestore.instance.collection('user search').doc(userUID).set(newUser.toMap());
          //FirebaseFirestore.instance.collection('user').doc(newUser.firstName + " " +newUser.lastName).collection('user Info').add(newUser.toMap());
          await Auth().sendEmailVerification();
          print('Registered! $userId, sent email verification');
        }
        catch (e) {
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
          else if(!value.contains('@'))
            return 'Enter valid email id';
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

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow,
      body: Container(
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
              _regEmail,
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              _regpass,
              SizedBox(height:MediaQuery.of(context).size.height * 0.03),
              //_confPass,
              //SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              FloatingActionButton.extended(
                  heroTag: "Register_Button",
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  onPressed:  (){
                    //userProvider.saveUser();
                    _validateAndSubmit();
                    _formkey.currentState.reset();
                    Navigator.popUntil(context, (route) => route.isFirst);
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
    );
  }
}

/*
class UserReg extends StatefulWidget {
  final AppUser user;
  UserReg({Key key, @required this.user, this.auth}): super(key: key);
  //UserReg({this.auth, this.rEmail,this.rPass});
  final BaseAuth auth;
  //String rEmail;
  //String rPass;
  @override
  State<StatefulWidget> createState() => _UserRegState();
}

  class _UserRegState extends State<UserReg> {


    final _formkey = GlobalKey<FormState>();

  static String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  static String pwdValidator(String value) {
    if (value.length <= 6) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

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
          UserCredential user  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: rEmail, password: rPass);
          String userId = user.toString();
          //FirestoreService().saveUsers(userId);
          //await Auth().sendEmailVerification();
          print('Registered! $userId, sent email verification');
          _formkey.currentState.reset();

        }
        catch (e) {
          print('Error: $e');
        }
      }

  }

  final notValidIcon = Icon(
    Icons.error,
    color: Colors.pink,
  );

  static String rEmail;
  static String rPass;





  @override
  Widget build(BuildContext context) {
    final _regEmail = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (value) {
          if(value.isEmpty)
          {
            return 'Email cannot be empty';
          }
          else
            emailValidator(value);
          return null;
        },
        onChanged: (value){
         //userProvider.changeEmail(value);
        },

        onSaved: (value)=> user.email = value,
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
        obscureText: true,
        autofocus: false,
        validator: pwdValidator,
        onChanged: (value){
          //userProvider.changePassword(value);
          //rPass = value;
        },

        onSaved: (value)=> user.password = value,
        decoration: InputDecoration(
          hintText: 'Enter password',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );

    final _confPass = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        obscureText: true,
        autofocus: false,
        validator: (value){
          if(value != rPass)
            {
              return("Password does not match");
            }
          return pwdValidator(value);
        },

        onChanged: (value){
          //userProvider.changePassword(value);
        },

        onSaved: (value)=> rPass = value,
        decoration: InputDecoration(
          hintText: 'Confirm password',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.yellow,
      body: Container(
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
              _regEmail,
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              _regpass,
              SizedBox(height:MediaQuery.of(context).size.height * 0.03),
              //_confPass,
              //SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              FloatingActionButton.extended(
                  heroTag: "Register_Button",
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  onPressed:  (){
                    //userProvider.saveUser();
                    _validateAndSubmit();
                    Navigator.pushReplacementNamed(context, '/user_login');
                  },
                  label: Text("Register", style: TextStyle(fontWeight: FontWeight.bold),)
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              FlatButton(
                child: Text('Already Registered? Sign in!'),
                onPressed: ()=> Navigator.pushNamed(context, '/user_login'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: "prev_button1",
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      onPressed:  ()=>  Navigator.popUntil(context, (route) => route.isFirst),
                      label: Text("Prev", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 */
