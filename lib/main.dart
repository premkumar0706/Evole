import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'screens/Basic_info.dart';
import 'theme.dart';
import 'firebase_options.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: StreamBuilder<User?>(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData) {
            return const Home_Page();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}

      title: 'EVOLE App', 
      debugShowCheckedModeBanner: false,
      theme: appTheme, 
      home: const LoginScreen(),
    );
  }
}
 73e6db7 (Added login screen, updated theme, fixed basic info form layout)
