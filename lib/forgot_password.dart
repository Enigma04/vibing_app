import 'package:flutter/material.dart';
import'package:vibing_app/User_Login.dart';
import 'auth.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

  static final formkey_forgot = GlobalKey<FormState>();
 static  String _userEmail;

  bool _validateAndSave()
  {
    final form = formkey_forgot.currentState;
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
          await Auth().resetPassword(_userEmail);
         formkey_forgot.currentState.reset();
      }
      catch (e) {
        print('Error: $e');
      }
    }

  }


 static String _emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }
  final _resetEmail = Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: _emailValidator,
      onSaved: (value)=> _userEmail = value,
      decoration: InputDecoration(
        hintText: 'Enter Email Address',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        child:
            Form(
              key: formkey_forgot,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: <Widget>[
                  Text("Forgot Password?",
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 100,),
                  _resetEmail,
                  SizedBox(height: MediaQuery.of(context).size.height *0.05,),
                  FloatingActionButton.extended(
                    heroTag: "pass_reset_mail",
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    onPressed: _validateAndSubmit,
                    label: Text("Send Password Reset Email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  FloatingActionButton.extended(
                    heroTag: "prev_page",
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> UserLogin())),
                    label: Text("Back",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),

      );
  }
}
