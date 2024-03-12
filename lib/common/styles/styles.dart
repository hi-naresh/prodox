import 'package:flutter/material.dart';
import '../../utils/constants/sizes.dart';

class PStyles {
  PStyles._();

  static BoxDecoration lightToDark(Color c) => BoxDecoration(
    gradient: LinearGradient(
      colors: [ c.withOpacity(0.5), c],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(PSizes.borderRadiusXl),
  );

  static BoxDecoration darkToLight(Color color) => BoxDecoration(
    gradient: LinearGradient(
      colors: [color, color.withOpacity(0.75)],
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
    ),
    borderRadius: BorderRadius.circular(30),
    // boxShadow: [
    //   BoxShadow(
    //     color: color.withOpacity(0.2),
    //     spreadRadius: 1,
    //     blurRadius: 8,
    //     offset: const Offset(0, 4),
    //   ),
    // ],
  );


}
