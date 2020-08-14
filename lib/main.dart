import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibing_app/User_Login.dart';
import 'package:vibing_app/User_Profile.dart';
import 'package:vibing_app/collaboration.dart';
import 'package:vibing_app/feed.dart';
import 'package:vibing_app/forgot_password.dart';
import 'package:vibing_app/post_collaborations.dart';
import 'package:vibing_app/register_user.dart';
import 'package:vibing_app/settings.dart';
import 'package:vibing_app/side_menu.dart';
import 'package:vibing_app/user_details_registeration.dart';
import 'package:vibing_app/view_collaboration_requests.dart';
import 'package:vibing_app/your_sound_recording_list.dart';
import 'root_page.dart';
import 'splash.dart';
import 'model/auth.dart';
import 'package:vibing_app/model/user_provider.dart';
import 'package:provider/provider.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context)=> UserProvider(),
      child: MaterialApp(
        title: 'Vibing',
        routes: {
          '/user_profile': (context)=> new UserProfile(),
          '/settings':(context)=> new Settings(),
          '/your_sound_recording':(context)=> new UserSoundRecordingList(),
          '/user_details':(context) => new UserDetails(),
          '/user_login':(context)=> new UserLogin(),
          '/user_register':(context)=> new UserReg(),
          '/forgot_password':(context)=> new ForgotPass(),
          '/post_collaborations':(context)=> new PostCollaborations(),
          '/collab_requests':(context)=> new CollabReq(),
          '/feed': (context) => new Feed(),
        },
        home: UserLogin(auth: new Auth()),
      ),
    );
  }
}




