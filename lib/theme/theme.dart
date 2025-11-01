import 'package:flutter/material.dart';
import 'constants.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFFFFFFF),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: headingFontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: subHeadingFontSize,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF034741),
      fontSize: subtitleFontSize,
    ),
    labelLarge: TextStyle(
      color: Color(0xFF034741),
      fontSize: buttonFontSize,
      fontWeight: FontWeight.w600,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: buttonFontSize,
        fontWeight: FontWeight.w600,
      ),
      elevation: 4,
      shadowColor: Colors.black26,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
    ),
  ),
);
