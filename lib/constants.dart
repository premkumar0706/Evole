import 'package:flutter/material.dart';


const Color primaryColor = Color(0xFFFFFFFF); 
const Color secondaryColor = Color(0xFF000000); 
const Color backgroundColor = Colors.white;


const TextStyle headingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const TextStyle labelTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const TextStyle hintTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.grey,
);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);


BoxDecoration topLeftShapeDecoration = const BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(100),
  ),
);

BoxDecoration bottomRightOuterDecoration = const BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(60),
  ),
);

BoxDecoration bottomRightInnerDecoration = const BoxDecoration(
  color: secondaryColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(80),
  ),
);
const double buttonFontSize = 16.0;