import 'package:cloud_functions/cloud_functions.dart';

class ApproveCounsellorRequestService {
  static Future<Map<String, dynamic>> approveRequest(String uid) async {
    try {
      final callable = FirebaseFunctions.instance
          .httpsCallable('approveCounsellorRequest');

      final result = await callable.call({"uid": uid});

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}