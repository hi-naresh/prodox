import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../common/styles/animation.dart';
import '../../utils/p_routes.dart';

class SplashScreen extends StatefulWidget {
  // final Widget childWidget;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            Get.offAllNamed(PRoutes.getOnBoardingRoute());
          } else {
            Get.offAllNamed(PRoutes.getMainRoute());
          }
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/logo.json',
          width: 200,
          height: 200,
          repeat: false,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
