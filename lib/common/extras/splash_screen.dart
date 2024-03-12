import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
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
