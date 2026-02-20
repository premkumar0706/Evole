import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeEvoleScreen(),
    );
  }
}

class WelcomeEvoleScreen extends StatelessWidget {
  const WelcomeEvoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
         
          Positioned(
            top: 230,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Your Request is yet\n"
                    "to be approved!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                       fontFamily: 'InriaSerif', 
                      color: Color(0xFFFBFFB0),
                    ),
                  ),
                ),
              ),
            ),
          ),

          
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 12),

                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/user.svg',
                        width: 28,
                        height: 28,
                        color: Colors.black,
                      ),
                      SvgPicture.asset(
                        'assets/icons/bell.svg',
                        width: 28,
                        height: 28,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                const Text(
                  "Welcome to Evole",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
