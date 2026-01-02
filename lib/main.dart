import 'package:evole/controller/userController.dart';
// import 'package:evole/screens/homepage.dart';
import 'package:evole/screens/home_page.dart';
import 'package:evole/screens/basic.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'screens/login_screen.dart';
// import 'screens/basic_info.dart';
import 'theme.dart';
import 'firebase_options.dart';



final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(Usercontroller()); // register controller

  runApp(const EvoleApp());
}

class EvoleApp extends StatelessWidget {
  const EvoleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVOLE',
      theme: appTheme,

      home: StreamBuilder<User?>(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (!snapshot.hasData) {
            return const LoginScreen();
          }

          return GetX<Usercontroller>(
            builder: (controller) {

              if (controller.isProfileCompleted.value == null) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.isProfileCompleted.value == true) {
                return const HomePage();
              }

              return const BasicForm();
            },
          );
        },
      ),
    );
  }
}
