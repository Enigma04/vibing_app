import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/collaboration.dart';
import 'package:vibing_app/feed.dart';
import 'package:vibing_app/forgot_password.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/settings.dart';
import 'package:vibing_app/side_menu.dart';
import 'package:vibing_app/your_sound_recording_list.dart';
import 'root_page.dart';
import 'splash.dart';
import 'auth.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: UserLogin(auth: new Auth()) ,
  )) ;
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibing',
      routes: <String, WidgetBuilder>{
        '/user_profile': (BuildContext context)=> new UserProfile(),
        '/settings':(BuildContext context)=> new Settings(),
        '/your_sound_recording':(BuildContext context)=> new UserSoundRecordingList(),
        '/home':(BuildContext context)=> new Home(),
        '/user_login':(BuildContext context)=> new UserLogin(),
        '/user_register':(BuildContext context)=> new UserReg(),
        '/forgot_password':(BuildContext context)=> new ForgotPass(),
      },
      home: UserLogin(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(

        appBar: AppBar(
          title: Text('Vibing',style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
          backgroundColor: Colors.yellow,
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.supervised_user_circle),
              onPressed: null,
            ),
          ], 
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text:'Feed',),
              Tab(text:'Collaborations',)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Feed(),
            Collaboration(),
          ],
        ),
      ),

    );
  }
}

