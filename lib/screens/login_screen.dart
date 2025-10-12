import 'package:flutter/material.dart';
import '../theme/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  print("Login with Google ");
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
                      Image.asset('assets/images/search1.png',
                          height: 24, width: 24),
                      const SizedBox(width: 12),
                      Text("Login with Google",
                          style: Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
