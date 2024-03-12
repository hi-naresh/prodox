import 'package:flutter/material.dart';

class PAnimation {
  PAnimation._();

  // static final PAnimation to = PAnimation._();

  static Route<dynamic> pageAnimation(Widget childWidget, Curve animationCurve) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => childWidget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        double begin = 0.0;
        double end = 1.0;
        Curve curve = animationCurve;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }
}
//
// PageRouteBuilder<dynamic> pageAnimation2(Widget childWidget, Curve animationCurve) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => childWidget,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(1.0, 0.0); // Start from the right
//       var end = Offset.zero; // End at this widget's final position
//       var curve = animationCurve;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       var slideAnimation = animation.drive(tween);
//
//       // Combine the slide animation with a fade animation
//       double fadeBegin = 0.0;
//       double fadeEnd = 1.0;
//       var fadeTween = Tween(begin: fadeBegin, end: fadeEnd).chain(CurveTween(curve: curve));
//       var fadeAnimation = animation.drive(fadeTween);
//
//       return FadeTransition(
//         opacity: fadeAnimation,
//         child: SlideTransition(
//           position: slideAnimation,
//           child: child,
//         ),
//       );
//     },
//   );
// }
//
