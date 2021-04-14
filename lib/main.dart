import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibing_app/Collaborate.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Vibe.dart';
import 'package:vibing_app/edit_user_profile.dart';
import 'package:vibing_app/feed.dart';
import 'package:vibing_app/forgot_password.dart';
import 'package:vibing_app/post_collaborations.dart';
import 'package:vibing_app/your_sound_recording_list.dart';

import 'model/auth.dart';

var email;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  email = preferences.getString('email');
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vibing',
      routes: {
        '/your_sound_recording': (context) => new UserSoundRecordingList(),
        '/user_login': (context) => new UserLogin(),
        '/forgot_password': (context) => new ForgotPass(),
        '/post_collaborations': (context) => new PostCollaborations(),
        '/collab': (context) => new Collaborate(),
        '/feed': (context) => new Feed(),
        '/edit_user_profile': (context) => new EditProfile(),
        '/vibe': (context) => new UserVibe(),
      },
      home: email != null
          ? Feed(
              auth: Auth(),
            )
          : UserLogin(
              auth: Auth(),
            ),
    );
  }
}

