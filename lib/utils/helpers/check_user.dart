// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// import '../p_routes.dart';
// class onLoggedin extends StatelessWidget {
//   const onLoggedin({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//              return Get.to(PRoutes.getMainRoute());
//
//           } else {
//              return Get.toNamed(PRoutes.getOnBoardingRoute());
//           }
//         }
//     );
//   }
// }
