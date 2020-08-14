
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/model/firestore_service.dart';
import 'package:vibing_app/user_details_registeration.dart';
import 'package:vibing_app/model/database.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'model/auth.dart';
import 'package:vibing_app/feed.dart';

class UserReg extends StatefulWidget {
  UserReg({this.auth, this.rEmail,this.rPass});
  final BaseAuth auth;
  String rEmail;
  String rPass;
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
          //FirestoreService().saveUsers(userId);
          await Auth().sendEmailVerification();
          print('Registered! $userId, sent email verification');
          formkey.currentState.reset();
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
    final userProvider = Provider.of<UserProvider>(context);

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
          userProvider.changeEmail(value);
        },

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
        onChanged: (value){
          userProvider.changePassword(value);
          rPass = value;
        },

        onSaved: (value)=> rPass = value,
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
          userProvider.changePassword(value);
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
          key: formkey,
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
                    _validateAndSubmit();
                    userProvider.saveUser();
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
                      onPressed:  ()=>  Navigator.pop(context),  //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails())),
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
