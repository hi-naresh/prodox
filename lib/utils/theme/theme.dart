import 'package:flutter/material.dart';
import 'package:prodox/utils/theme/widget_themes/appbar_theme.dart';
import 'package:prodox/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:prodox/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:prodox/utils/theme/widget_themes/chip_theme.dart';
import 'package:prodox/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:prodox/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:prodox/utils/theme/widget_themes/text_field_theme.dart';
import 'package:prodox/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: PColors.grey,
    brightness: Brightness.light,
    primaryColor: PColors.primary,
    textTheme: PTextTheme.lightTextTheme,
    chipTheme: PChipTheme.lightChipTheme,
    scaffoldBackgroundColor: PColors.scaffoldLight,
    appBarTheme: PAppBarTheme.lightAppBarTheme,
    checkboxTheme: PCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: PBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: PElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: POutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: PTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: PColors.grey,
    brightness: Brightness.dark,
    primaryColor: PColors.primary,
    textTheme: PTextTheme.darkTextTheme,
    chipTheme: PChipTheme.darkChipTheme,
    scaffoldBackgroundColor: PColors.scaffoldDark,
    appBarTheme: PAppBarTheme.darkAppBarTheme,
    checkboxTheme: PCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: PBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: PElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: POutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: PTextFormFieldTheme.darkInputDecorationTheme,
  );
}
