<<<<<<< HEAD
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
        // User canceled sign-in
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

=======
import 'package:evole/screens/Basic_info.dart';
import 'package:flutter/material.dart';
import '../theme/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
>>>>>>> 73e6db7 (Added login screen, updated theme, fixed basic info form layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, midColor, accentColor],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
<<<<<<< HEAD
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("EVOLE",
                        style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 8),
                    Text(
                      "Explore Learn & Innovate",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 200),
                    GestureDetector(
                      onTap: () async {
                        final user = await signInWithGoogle();
                        if (user != null) {
                          print("✅ Login successful: ${user.user?.displayName}");
                          // You can navigate to home screen here
                          // Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(buttonBorderRadius),
                          border: Border.all(color: whiteColor, width: 1.5),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/search1.png',
                                height: 24, width: 24),
                            const SizedBox(width: 12),
                            Text("Login with Google",
                                style:
                                    Theme.of(context).textTheme.labelLarge),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
=======
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("EVOLE", style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                "Explore Learn & Innovate",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 200),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BasicInfoScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                    border: Border.all(color: whiteColor, width: 1.5),
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/search1.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Login with Google",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
>>>>>>> 73e6db7 (Added login screen, updated theme, fixed basic info form layout)
        ),
      ),
    );
  }
}
