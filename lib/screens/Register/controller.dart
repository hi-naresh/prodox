// import 'dart:async';
// import '../../services/auth/auth_service.dart';
// import '../../utils/helpers/helper.dart';
// import '../../utils/p_routes.dart';
// import 'package:get/get.dart';
//
// final AuthService _authService = AuthService();
//
// Future<void> login(username, password) async {
//
//
//   String domain = "@gmail.com";
//   String email = "$username$domain";
//
//   try {
//     UserCredential userCredential = await _authService.signIn(email, password);
//
//     Timer(const Duration(seconds: 0), () {
//       Helper.showSnackBar("Logged in successfully", "Welcome back, $username");
//       Get.offAllNamed(PRoutes.getMainRoute());
//     });
//   } catch (e) {
//     if (e is FirebaseAuthException) {
//       if (e.code == 'user-not-found') {
//         // User with the specified email doesn't exist
//         Helper.showSnackBar("User not found", "Please sign up first");
//       } else if (e.code == 'wrong-password') {
//         // User with the specified email exists but entered the wrong password
//         Helper.showSnackBar("Incorrect password", "Please try again");
//       } else {
//         // Other login errors
//         Helper.showSnackBar("Login failed", "Error: ${e.message}");
//       }
//     } else {
//       // Other errors
//       Helper.showSnackBar("Login failed", "Error: $e");
//     }
//   }
// }
