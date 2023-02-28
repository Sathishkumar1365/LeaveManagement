import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:leavemanagement/Admin/shared/user_provider.dart';
import 'package:leavemanagement/EndUser/services/PushNotification.dart';
import 'package:leavemanagement/EndUser/ui/userlogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'EndUser/ui/SplashScreen.dart';
import 'EndUser/ui/UserHome.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Admin/shared/emp_info.dart';



Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //This is for initialize notification
  PushNotification.initialiseNotifications();
  //This is for device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  //This is for integration of firebase API
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseleavehandler);
  runApp((LeaveApp()));
}

class LeaveApp extends StatefulWidget {
  const LeaveApp({Key? key}) : super(key: key);

  @override
  State<LeaveApp> createState() => _LeaveAppState();
}

class _LeaveAppState extends State<LeaveApp> {

  @override
  Widget build(BuildContext context) {
    //this is a initial screen of the application
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreen()
      ),
    );
  }
}
//this for notification message configuration
Future<void> _firebaseleavehandler(RemoteMessage message)async {

}


