/*
import 'package:flutter/material.dart';
import 'package:vibing_app/User_Login.dart';
import 'model/auth.dart';
import 'feed.dart';
class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}
enum AuthStatus {
  NOT_LOGGED_IN,
  LOGGED_IN,
}
class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.NOT_LOGGED_IN;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((userId){
      setState(() {
        _authStatus = userId == null ? AuthStatus.NOT_LOGGED_IN:AuthStatus.LOGGED_IN;
      });
    });
  }
  void _signedIn(){
    setState(() {
      _authStatus = AuthStatus.LOGGED_IN;
    });
  }
  void _signedOut(){
    setState(() {
      _authStatus = AuthStatus.NOT_LOGGED_IN;
    });
  }

  @override
  Widget build(BuildContext context) {
   switch(_authStatus){
      case AuthStatus.NOT_LOGGED_IN: return new UserLogin(auth: Auth(), onSignedIn: _signedIn ,);
      case AuthStatus.LOGGED_IN: return new Feed(auth: Auth(), onSignedOut: _signedOut,);
    }


 /* void loginCallback()
    {
      widget.auth.getCurrentUser().then((user){
        setState(() {
         dynamic _userId = user.uid.toString();
        });
      });
      setState(() {
        dynamic authStatus = AuthStatus.NOT_LOGGED_IN;
      });
    }

    void logoutCallback()
    {
      setState(() {
        dynamic authStatus = AuthStatus.NOT_LOGGED_IN;
        String _userId = "";
      });
    }*/
  }
}

 */
