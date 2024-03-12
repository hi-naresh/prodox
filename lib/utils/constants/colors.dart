import 'package:flutter/material.dart';

import 'enums.dart';

// import '../../services/category_model.dart';

class PColors {
  // App theme colors
  static const Color primary = Color(0xFFB4A6FE);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  static const Color accent1 = Color(0xff9dd7ff);
  static const Color accent1Light = Color(0xffCEEAFF);
  static const Color accent2 = Color(0xFFFFB4E2);
  static const Color accent2Light = Color(0xFFFFD9F0);
  static const Color accent3 = Color(0xFFB4A6FE);
  static const Color accent3Light = Color(0xFFCEC4FF);
  static const Color accent3Dark = Color(0xFF6D6598);

  static const Color accent4 = Color(0xFFFDB9AE);
  static const Color accent4Light = Color(0xFFFFDFD8);

  static const Gradient accent1Gradient = LinearGradient(
    colors: [
      Colors.blue,
      accent1 ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  //
  // static const Gradient accent2Gradient = LinearGradient(
  //   colors: [
  //     accent2Light,
  //     accent2 ],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );
  //
  // static const Gradient accent3Gradient= LinearGradient(
  //   colors: [
  //     accent3Light,
  //     accent3 ],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );
  //
  // static const Gradient accent4Gradient = LinearGradient(
  //   colors: [
  //     accent4Light,
  //     accent4 ],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );



  // static BoxShadow defaultShadow(accentIn) => BoxShadow(
  //   color: accentIn.withOpacity(0.15),
  //   offset: const Offset(-5, 1.5),
  //   spreadRadius: 1,
  //   blurRadius: 10,
  // );

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  //scaffold color
  static const Color scaffoldLight = Color(0xfff4f3ff);

  static const Color scaffoldDark = Color(0xff050811);

  // Background colors
  static const Color light = Color(0xffe5e5ea);
  static const Color navLight = Color(0xffcecee3);
  static const Color dark = Color(0xff3E3861);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  // static const Color lightContainer = Color(0xFFF6F6F6);
  static Color lightContainer = PColors.white.withOpacity(0.5);
  static Color darkContainer = PColors.black.withOpacity(0.05);

  // Button colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Neutral Shades

  static const Color primaryWhite = Color(0xFFEFEEFF);
  static const Color primaryBlack = Color(0xFF362424);
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFE5E5E5);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

}

final categoryColors ={
  TaskCategory.work: Color(0xff9dd7ff),
  TaskCategory.education: Color(0xFFFFB4E2),
  TaskCategory.exercise: Color(0xFFB4A6FE),
  TaskCategory.timePass: Color(0xFFCAE0F5),
  TaskCategory.meditation: Color(0xFFB4A6FE),
  TaskCategory.personalCare: Color(0xFFFFB4E2),
  TaskCategory.leisure: Color(0xFFC4C4FF),
  TaskCategory.social: Color(0xFFFFB4E2),
  TaskCategory.chores: Color(0xFFB4A6FE),
  TaskCategory.family: Color(0xFFFDB9AE),
  TaskCategory.finance: Color(0xFFB4A6FE),
  TaskCategory.volunteer: Color(0xFFFFB4E2),
  TaskCategory.creative: Color(0xFFFDB9AE),
  TaskCategory.spiritual: Color(0xFFB4A6FE),
  TaskCategory.professional: Color(0xFFFFB4E2),
  TaskCategory.fitness: Color(0xFFFDB9AE),
  TaskCategory.mindfulness: Color(0xFFB4A6FE),
  TaskCategory.outdoor: Color(0xFFFDB9AE),
  TaskCategory.planning: Color(0xFFB4A6FE),
  TaskCategory.other: Color(0xFFFFB4E2),
};

const Color kPrimaryColor = Color(0xFFCEC4FF);
const Color kSecondaryColor = Color(0xFFD9E9FF);
