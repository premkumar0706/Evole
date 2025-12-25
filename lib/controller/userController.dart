import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Usercontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userData = <String, dynamic>{}.obs;
  RxnBool isProfileCompleted = RxnBool(); // null = loading

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  
  loadUserData() async {
    var user = _auth.currentUser;

    if (user == null) return;

    isProfileCompleted.value = null; // loading

    _firestore.collection("Users").doc(user.uid).snapshots().listen((snap) {
      if (snap.exists) {
        userData.value = snap.data()!;
        isProfileCompleted.value = true;     // document hai → profile done
      } else {
        isProfileCompleted.value = false;    // document nahi → basic info dikhana
      }
    });
  }
}
