import 'package:flutter/material.dart';
import 'constants.dart';

final ThemeData appTheme = ThemeData(
  
  primaryColor: primaryColor,
  scaffoldBackgroundColor: primaryColor,

  
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: whiteColor,
      fontSize: headingFontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
    titleMedium: TextStyle(
      color: lightWhite,
      fontSize: subtitleFontSize,
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
    ),
    labelLarge: TextStyle(
      color: whiteColor,
      fontSize: buttonFontSize,
      fontWeight: FontWeight.w500,
    ),
  ),


  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: buttonFontSize,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
