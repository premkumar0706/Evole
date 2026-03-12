import 'package:cloud_firestore/cloud_firestore.dart';

class ReadCounsellorRequestsService {
  static Future<List<Map<String, dynamic>>> fetchRequests() async {
    List<Map<String, dynamic>> counsellorRequests = [];

    try {
      // Get all documents from Requests collection
      QuerySnapshot snap =
          await FirebaseFirestore.instance.collection("Requests").get();

      for (var doc in snap.docs) {
        final data = doc.data() as Map<String, dynamic>;
        

        counsellorRequests.add({
          "uid": data["uid"] ?? doc.id,  
          "name": data["basicDetail"]?["name"] ?? "", 
          "college": data["basicDetail"]?["institute"] ?? "",
          "qualification": data["basicDetail"]?["qualification"] ?? "",
          "status": "Pending",
        });
      }

      print("Total Requests: ${counsellorRequests.length}");
      return counsellorRequests;
    } catch (e) {
      print("Read Requests Error: $e");
      return [];
    }
  }
}