import 'package:flutter/material.dart';
import 'constants.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: primaryColor,
  brightness: Brightness.dark,

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: whiteColor,
      fontSize: headingFontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleLarge: TextStyle(
      color: whiteColor,
      fontSize: subHeadingFontSize,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: lightWhite,
      fontSize: subtitleFontSize,
    ),
    labelLarge: TextStyle(
      color: whiteColor,
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
      elevation: 6,
      shadowColor: Colors.black45,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
    ),
  ),
);