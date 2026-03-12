import 'package:flutter/material.dart';
import 'package:evole/services/read_counsellor_requests.dart';
import 'package:evole/services/approve_counsellor_request.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<Map<String, dynamic>> requests = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadRequests();
  }

  Future<void> loadRequests() async {
    try {
     
      final data = await ReadCounsellorRequestsService.fetchRequests();
      print("Fetched Requests: $data");
      if (!mounted) return;

      setState(() {
        requests = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load requests")),
      );
    }
  }

  Future<void> approveRequest(int index) async {
    String uid = requests[index]["uid"];

    final result = await ApproveCounsellorRequestService.approveRequest(uid);

    if (result["success"] == true) {
      if (!mounted) return;

      setState(() {
        requests.removeAt(index); 
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request Approved")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Approval failed")),
      );
    }
  }

  void rejectRequest(int index) {
    setState(() {
      requests[index]["status"] = "Rejected";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      var data = requests[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  data["name"] != null &&
                                          data["name"].isNotEmpty
                                      ? data["name"][0]
                                      : "?",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data["name"] ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${data["college"] ?? ""} | ${data["qualification"] ?? ""}",
                                    style: const TextStyle(
                                        color: Colors.orange, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            (data["status"] ?? "Pending") == "Pending"
                                ? Row(
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          minimumSize: const Size(65, 30),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {
                                          approveRequest(index);
                                        },
                                        child: const Text(
                                          "Approve",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          minimumSize: const Size(65, 30),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {
                                          rejectRequest(index);
                                        },
                                        child: const Text(
                                          "Reject",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: data["status"] == "Approved"
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      data["status"],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
