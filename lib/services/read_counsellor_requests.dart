import 'package:cloud_firestore/cloud_firestore.dart';
class ReadCounsellorRequestsService {
  static Future<List<Map<String, dynamic>>> fetchRequests() async {
    List<Map<String, dynamic>> counsellorRequests = [];

    try {
      QuerySnapshot snap =
          await FirebaseFirestore.instance.collection("Requests").get();

      for (var doc in snap.docs) {
        final data = doc.data() as Map<String, dynamic>;

        Map<String, dynamic>? basic;

        if (data["basicDetail"] is Map) {
          basic = Map<String, dynamic>.from(data["basicDetail"]);
        }

        counsellorRequests.add({
          "uid": data["uid"],
          "name": basic?["name"] ?? "",
          "college": basic?["institute"] ?? "",
          "qualification": basic?["qualification"] ?? "",
          "experience": basic?["experience"] ?? "",
          "status": data["status"] ?? "Pending",
        });
      }

      return counsellorRequests;
    } catch (e) {
      print("Read Requests Error: $e");
      return [];
    }
  }
}