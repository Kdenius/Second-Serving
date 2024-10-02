// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'homepage.dart';
//
// class Wrapper extends StatefulWidget{
//   const Wrapper({super.key});
//   @override
//   State<Wrapper> createState() => _WrapperState();
// }
//
// class _WrapperState extends State<Wrapper>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChange(),
//           builder: (context, snapshot){
//             if(snapshot.hasData){
//               return Homepage();
//             }else{
//               return Login();
//             }
//           })
//     );
//   }
// }

