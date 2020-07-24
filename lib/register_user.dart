
import 'package:flutter/material.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/user_details_registeration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:vibing_app/feed.dart';

class UserReg extends StatefulWidget {
  UserReg({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => _UserRegState();
}

  class _UserRegState extends State<UserReg> {


    final formkey = GlobalKey<FormState>();

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
    final form = formkey.currentState;
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
          String userId = await Auth().signUp(rEmail, rPass);
          await Auth().sendEmailVerification();
          formkey.currentState.reset();
          print('Registered! $userId, sent email verification');
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




  final _regEmail = Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: emailValidator,
      onSaved: (value)=> rEmail = value,
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
      onSaved: (value)=> rPass = value,
      decoration: InputDecoration(
        hintText: 'Enter password',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    ),
  );


  /*final _confRegPass = Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
    obscureText: true,
    autofocus: false,
      validator: (value)=> value.isEmpty? 'Confirm Password cannot be empty':null,
      onSaved,
    decoration: InputDecoration(
      hintText: 'Confirm Password',
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
      ),
    ),
  ),
  );*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 200,),
              Text('Register',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                ),
              ),
              SizedBox(height: 100,),
              _regEmail,
              SizedBox(height: 20,),
              _regpass,
              SizedBox(height:30),
              //_confRegPass,
              SizedBox(height: 30,),
              FloatingActionButton.extended(
                  heroTag: "Register_Button",
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  onPressed:  (){
                    _validateAndSubmit();
                   // var auth = Auth();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserLogin()));
                  },
                  label: Text("Register", style: TextStyle(fontWeight: FontWeight.bold),)
              ),

              SizedBox(height: 20,),
              FlatButton(
                child: Text('Already Registered? Sign in!'),
                onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin())) ,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: "prev_button",
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      onPressed:  ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails())),
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
