import 'package:cloud_firestore/cloud_firestore.dart';
class ReadCounsellorRequestsService {
  static Future<List<Map<String, dynamic>>> fetchRequests() async {
    List<Map<String, dynamic>> counsellorRequests = [];

    try {
      QuerySnapshot snap =
          await FirebaseFirestore.instance.collection("Requests").get();

for (var doc in snap.docs) {
  final data = doc.data() as Map<String, dynamic>;

  final basic =
      Map<String, dynamic>.from(data["basicDetail"] ?? {});
  final qualification =
      Map<String, dynamic>.from(data["qualification"] ?? {});
  final domain =
      Map<String, dynamic>.from(data["counsellingDomain"] ?? {});
  final availability =
      Map<String, dynamic>.from(data["availability"] ?? {});
  final approach =
      Map<String, dynamic>.from(data["approach"] ?? {});

  counsellorRequests.add({
    "uid": data["uid"],

    ...basic,          
    ...qualification,   
    ...domain,       
    ...availability,   
    ...approach,        
  });
}

      return counsellorRequests;
    } catch (e) {
      print("Read Requests Error: $e");
      return [];
    }
  }
}