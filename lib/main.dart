import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secondserving/homepage.dart';
// import 'package:secondserving/take_food.dart';
// import 'package:secondserving/wrapper.dart';
import 'package:secondserving/login.dart';
import 'package:secondserving/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
//
// import 'login.dart';
//
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Firebase.initializeApp();
  SharedPreferences sf = await SharedPreferences.getInstance();
  var email = sf.getString('email');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/home',
      initialRoute: email != null ? '/' : 'login',
        // initialRoute: 'login',
      routes: {

        'login': (context) => Login(),
        // 'take_food': (context) => TakeFood(),
        '/': (context) => HomeScreen(),
        'signup': (context) => Signup(),
      }
  ));

}

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:secondserving/signup.dart';
// import 'login_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Second Serving',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: Signup(),
//     );
//   }
// }

