import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'theme/theme.dart'; 

void main() {
  runApp(const EvoleApp());
}

class EvoleApp extends StatelessWidget {
  const EvoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVOLE',
      theme: appTheme, 
      home: const LoginScreen(),
    );
  }
}
