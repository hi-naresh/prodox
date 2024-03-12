import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  // static final head = TextStyle(
  //   color: const Color(0xFF191D21),
  //   fontSize: 32,
  //   fontWeight: FontWeight.bold,
  //   fontFamily: 'Poppins',
  // );
  static BoxDecoration containerDecoration(Color color) => BoxDecoration(
    gradient: LinearGradient(
      colors: [color, color.withOpacity(0.5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ),
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: color.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration gradient(
      BuildContext context, {
        Color borderColor = Colors.transparent,
      }) =>
      BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(-5, 5),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      );

  static BoxDecoration border(
      BuildContext context, {
        double borderRadius = 20,
        Color borderColor = Colors.white70,
        Color colorbg = Colors.black12,
      }) =>
      BoxDecoration(
        color: colorbg,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      );
}