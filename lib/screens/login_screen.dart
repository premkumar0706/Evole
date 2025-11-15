import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  Future<UserCredential?> signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() {
          isLoading = false;
        });
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print("Error during Google sign-in: $e");
      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          
        Positioned(
  top: -screenHeight * 0.29,   
  right: -screenWidth * 0.60,  
  child: Transform.rotate(
    angle: 54.7 * 3.1416 / 180, 
    child: Container(
      width: screenWidth * 1.15, 
      height: screenWidth * 1.15,
      decoration: const BoxDecoration(
        color: Color(0xFF160B6E),
        borderRadius: BorderRadius.only( 
          bottomRight: Radius.circular(25),
        ),
      ),
    ),
  ),
),

Positioned(
  bottom: -screenHeight * 0.22, 
  left: -screenWidth * 0.85,    
  child: Transform.rotate(
    angle: -45 * 3.1416 / 180,  
    child: Container(
      width: screenWidth * 1.2,  
      height: screenWidth * 0.8, 
      decoration: const BoxDecoration(
        color: Color(0xFF160B6E), 
        ),
    ),
  ),
),


Positioned(
  bottom: -screenHeight * 0.34,
  left: -screenWidth * 0.32,    
  child: Transform.rotate(
    angle: -27 * 3.1416 / 180, 
    child: Container(
      width: screenWidth * 1.15,
      height: screenWidth * 0.95,
      decoration: const BoxDecoration(
        color: Color(0xFFA0EAFF), 
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
        ),
      ),
    ),
  ),
),



          Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF034741)),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),

                      
                      const Text(
                        "EVOLE",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 1),

                      
                      const Text(
                        "Explore Learn & Innovate",
                        style: TextStyle(
                          color: Color(0xFF034741),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 120),

                      
                      GestureDetector(
                        onTap: () async {
                          final user = await signInWithGoogle();
                          if (user != null) {
                            print(
                                "✅ Login successful: ${user.user?.displayName}");

                          }
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF8B8787), width: 1.5),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/search1.png',
                                height: 24,
                                width: 28,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Login with Google",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: buttonFontSize,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
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
