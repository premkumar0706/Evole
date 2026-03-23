import 'package:cloud_functions/cloud_functions.dart';
import 'package:evole/main.dart';

class RejectCounsellorRequestService {
  static Future<Map<String, dynamic>> rejectRequest(String uid) async {
    print("currentuser: ${firebaseAuth.currentUser?.uid}");

    try {
      final callable = FirebaseFunctions.instance
          .httpsCallable('rejectCounsellorRequest');

      final result = await callable.call({
        "uid": uid,
      });

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      print("Error rejecting counsellor request: $e");

      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}  