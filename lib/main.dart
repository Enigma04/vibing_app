import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/User_Vibe.dart';
import 'package:vibing_app/collaboration.dart';
import 'package:vibing_app/feed.dart';
import 'package:vibing_app/forgot_password.dart';
import 'package:vibing_app/post_collaborations.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/edit_user_profile.dart';
import 'package:vibing_app/settings.dart';
import 'package:vibing_app/user_details_registeration.dart';
import 'package:vibing_app/Collaborate.dart';
import 'package:vibing_app/your_sound_recording_list.dart';
import 'root_page.dart';
import 'splash.dart';
import 'model/auth.dart';
import 'package:vibing_app/model/user_provider.dart';
//import 'package:provider/provider.dart';
void main() async
{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((value) => runApp(MyApp()));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Vibing',
        routes: {
          //'/user_profile': (context)=> new UserProfile(),
          '/settings':(context)=> new UserSettings(),
          '/your_sound_recording':(context)=> new UserSoundRecordingList(),
          //'/user_details':(context) => new UserDetails(),
          '/user_login':(context)=> new UserLogin(),
          //'/user_register':(context)=> new UserReg(),
          '/forgot_password':(context)=> new ForgotPass(),
          '/post_collaborations':(context)=> new PostCollaborations(),
          '/collab':(context)=> new Collaborate(),
          '/feed': (context) => new Feed(),
          '/edit_user_profile': (context) => new EditProfile(),
          '/vibe': (context)=> new UserVibe(),
        },
        home: UserLogin(auth: Auth(),),
    );
  }
}




