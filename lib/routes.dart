import 'package:evole/screens/Giveguidance.dart';
import 'package:evole/screens/request_accept.dart';
import 'package:flutter/material.dart';
import 'package:evole/screens/admin_request.dart';
import 'package:evole/screens/Seekguidance.dart';
import 'package:evole/screens/home_page.dart';
import 'package:evole/screens/Counsellor_list.dart';

final Map<String, WidgetBuilder> routes = {
   HomePage.routeName: (context) => const HomePage(),

  GiveGuidanceScreen.routeName: (context) => const GiveGuidanceScreen(),
   GiveGuidancestoryScreen.routeName: (context) =>
      const GiveGuidancestoryScreen(), 
      RequestsScreen.routeName: (context) => const RequestsScreen(),
      SeekGuidanceScreen.routeName: (context) => const SeekGuidanceScreen(),

  CounselorListScreen.routeName: (context) =>
      const CounselorListScreen(),
};