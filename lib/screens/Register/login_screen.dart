import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodox/screens/Main/main_screen.dart';

import '../../services/auth/auth_service.dart';
import '../../utils/global_styles.dart';
import '../../utils/global_widgets.dart';


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
        showGlobalSnackBar(context, 'Logged in successfully');
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // User with the specified email doesn't exist
          showGlobalSnackBar(context,'Please sign up first.');
        } else if (e.code == 'wrong-password') {
          // User with the specified email exists but entered the wrong password
          showGlobalSnackBar(context,'Incorrect password.');
        } else {
          // Other login errors
          showGlobalSnackBar(context,'Login failed. Error: ${e.message}');
        }
      } else {
        // Other errors
        showGlobalSnackBar(context,'Login failed. Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      key: _scaffoldKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            myField(context, 'Email', emailController, false),
            myField(context, 'Password', passwordController, true),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appButtonFunc(
                      context,
                    margin: const EdgeInsets.only(bottom: 10.0),
                      Styles.gradient(context),
                      'Sign In',
                    login,
                    isEnabled: true,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
