
import'package:flutter/widgets.dart';
import'package:flutter/foundation.dart';
import'package:flutter/material.dart';
import 'package:vibing_app/auth.dart';
import 'package:vibing_app/feed.dart';
import'package:vibing_app/register_user.dart';
import 'package:vibing_app/forgot_password.dart';
import 'package:vibing_app/main.dart';
import 'package:vibing_app/user_details_registeration.dart';
import 'auth.dart';
import 'root_page.dart';


class UserLogin extends StatefulWidget {

  UserLogin({this.auth,this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState()=> _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  final formkey_forgot_pass = GlobalKey<FormState>();

  bool _validateAndSave()
  {
    final form = formkey_forgot_pass.currentState;
    if(form.validate())
      {
        form.save();
        return true;
      }
    else
      return false;
  }

   static final incorrect_icon = Icon(
     Icons.error,
     color: Colors.pink,
   );

   void _validateAndSubmit() async
   {

     if(_validateAndSave()) {
       try {
         String userId = await Auth().signIn(emailid, password);
         print('Signed in! $userId');
         formkey_forgot_pass.currentState.reset();
         //widget.onSignedIn();
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Feed()));
       }
       catch (e) {
         print('Error: $e');
       }
     }

   }



   static final TextEditingController emailContr = new TextEditingController();
   static final TextEditingController passwordContr = new TextEditingController();

   static String get emailid => emailContr.text;
   static String get password => passwordContr.text;

   final _email = Container(
     padding: EdgeInsets.only(left: 10, right: 10),
     child: TextFormField(
       keyboardType: TextInputType.emailAddress,
       controller: emailContr,
       autofocus: false,
       validator: (input) {
         if(input.isEmpty)
           {
             return 'Email cannot be empty';
           }
          return null;
       },
       //onSaved: (input)=> emailid = input,
       decoration: InputDecoration(
         hintText: 'Enter Email Address',
         suffixIcon: Icon(Icons.email),
         border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10)
         ),
       ),
     ),
   );

   final _pass = Container(
     padding: EdgeInsets.only(left: 10, right: 10),
     child: TextFormField(
       controller: passwordContr,
       obscureText: true,
       autofocus: false,
       validator: (input) {
         if(input.length <= 6)
         {
           return 'Password should be at least 6 characters';
         }
         return null;
       },
       decoration: InputDecoration(
         hintText: 'Enter password',
         suffixIcon: Icon(Icons.lock),
         border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10)
         ),
       ),
     ),
   );

  /*final login_button =

    },
  );
   */

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        child: Form(
          key: formkey_forgot_pass,
          child: Column(
            children: <Widget>[
              SizedBox(height: 200,),
              Text('Vibing',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                ),
              ),
              SizedBox(height: 100,),
              _email,
              SizedBox(height: 20,),
              _pass,
              SizedBox(height:30),
              RaisedButton(

                  color: Colors.yellow,
                  elevation: 5,
                  child: Text('Login'),
                  onPressed: (){
                    _validateAndSubmit();
                  }
              ),
              SizedBox(height:10),
              FlatButton(
                  child: Text('Forgot password'),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ForgotPass()),);
                  }
              ),
              SizedBox(height:10),
              FlatButton(
                  child: Text('New? Register here!'),
                  onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>UserDetails()),)
              ),
            ],
          ),
        ),
        ) ,
      );
  }

}
