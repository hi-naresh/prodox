import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';


class Titles{
  static customTitle(Color color, double size) => GoogleFonts.epilogue(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color,
  );
  static customTitleBold(Color? color, double size, FontWeight weight) => GoogleFonts.epilogue(
    fontSize: size,
    fontWeight: weight,
    color: color?? color,
  );
}