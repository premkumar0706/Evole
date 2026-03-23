import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class GiveguidanceService {
  static Future<Map<String, dynamic>> createCounsellorRequest(
      Map<String, String?> formData) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return {
          "success": false,
          "message": "Please login first",
        };
      }

      final callable =
          FirebaseFunctions.instance.httpsCallable('createCounsellorRequest');

      final result = await callable.call({
        "basicDetail": {
          "name": formData["name"],
          "qualification": formData["qualification"],
          "institute": formData["institute"],
          "year": formData["year"],
          "specialization": formData["specialization"],
          "certificate": formData["certificate"],
          "experience": formData["experience"],
        },
        "qualification": {
          "category": formData["category"],
          "mode": formData["mode"],
          "days": formData["days"],
          "timeSlot": formData["timeSlot"],
        },
        "counsellingDomain": {
          "philosophy": formData["philosophy"],
          "values": formData["values"],
        },
        "availability": {
          "state": formData["locality"],
          "address": formData["address"],
          "city": formData["city"],
        },
        "approach": {
          "photo": formData["Photo"],
          "sessionUrl": formData["Url"],
        }
      });

      return result.data;
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}