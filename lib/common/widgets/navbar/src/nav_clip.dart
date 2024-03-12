import 'package:flutter/material.dart';

class ClipPathClass extends CustomClipper<Path> {
  final double loc;
  final double s;
  final TextDirection textDirection;

  ClipPathClass(
      double startingLoc,
      int itemsLength,
      this.textDirection,
      ) : loc = startingLoc + (1.0 / itemsLength - 0.2) / 2,
        s = 0.2 {
    // Adjust loc based on textDirection
    // this.loc = textDirection == TextDirection.rtl ? 0.8 - loc : loc;
  }

  @override
  Path getClip(Size size) {
    final path = Path();
    // Define your path operations
    path.moveTo(0, 0);
    path.lineTo((loc - 0.1) * size.width, 0);
    path.cubicTo(
      (loc + s * 0.20) * size.width,
      size.height * 0.05,
      loc * size.width,
      size.height * 0.60,
      (loc + s * 0.50) * size.width,
      size.height * 0.60,
    );
    path.cubicTo(
      (loc + s) * size.width,
      size.height * 0.60,
      (loc + s - s * 0.20) * size.width,
      size.height * 0.05,
      (loc + s + 0.1) * size.width,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Optimize by comparing necessary properties instead of instance comparison
    if (oldClipper is ClipPathClass) {
      return loc != oldClipper.loc || s != oldClipper.s || textDirection != oldClipper.textDirection;
    }
    return true;
  }
}
