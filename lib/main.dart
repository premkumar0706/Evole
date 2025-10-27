import 'package:flutter/material.dart';
import 'package:evole/screens/Login_screen.dart'; 
import 'package:evole/theme/theme.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVOLE App', 
      debugShowCheckedModeBanner: false,
      theme: appTheme, 
      home: const LoginScreen(),
    );
  }
}