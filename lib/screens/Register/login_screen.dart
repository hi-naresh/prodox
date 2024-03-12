import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodox/screens/Main/main_screen.dart';

import '../../common/styles/styles.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/constants/colors.dart';
import '../../common/widgets/global_widgets.dart';
import 'package:get/get.dart';

import '../../utils/helpers/helper.dart';
import '../../utils/p_routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> login() async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();

    String domain = "@gmail.com";
    String email = "$username$domain";

    try {
      UserCredential userCredential = await _authService.signIn(email, password);

      Timer(const Duration(seconds: 0), () {
        Helper.showSnackBar("Logged in successfully", "Welcome back, $username");
        Get.offAllNamed(PRoutes.getMainRoute());
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // User with the specified email doesn't exist
          Helper.showSnackBar("User not found", "Please sign up first");
        } else if (e.code == 'wrong-password') {
          // User with the specified email exists but entered the wrong password
          Helper.showSnackBar("Incorrect password", "Please try again");
        } else {
          // Other login errors
          Helper.showSnackBar("Login failed", "Error: ${e.message}");
        }
      } else {
        // Other errors
        Helper.showSnackBar("Login failed", "Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      key: _scaffoldKey,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            myField(context, 'Username', emailController, false),
            myField(context, 'Password', passwordController, true),
            const Spacer(),
            appButtonFunc(
                context,
                PStyles.lightToDark(PColors.accent3),
                'Sign In',
              login,
              isEnabled: true,
            )
          ],
        ),
      ),
    );
  }
}
