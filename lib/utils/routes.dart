import 'package:flutter/material.dart';
import 'package:prodox/screens/Routine/analyze_routine.dart';
import 'package:prodox/screens/Routine/set_routine.dart';
import '../screens/Extras/on_board.dart';

import '../screens/Home/home_screen.dart';
import '../screens/Register/login_screen.dart';
import '../screens/Register/signup_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/onBoarding': (context) => OnBoardingScreen(),
  // '/signedUser': (context) => const HomeScreen(),
  '/home': (context) => HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/setRoutine': (context) => SetRoutineScreen(),
  '/analyzeRoutine': (context) => AnalyzeScreen(),
};
