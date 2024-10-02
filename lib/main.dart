import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:secondserving/homepage.dart';
import 'package:secondserving/take_food.dart';
import 'package:secondserving/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
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
        'take_food': (context) => TakeFood(),
        '/': (context) => HomeScreen(),
      }
  ));

}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//         debugShowCheckedModeBanner: false,
//         // initialRoute: '/home',
//         initialRoute: '/',
//         //   initialRoute: '/login',
//         routes: {
//           '/': (context) => homepage(),
//         }
//     );
//   }
// }