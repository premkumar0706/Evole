import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:evole/services/read_counsellor_requests.dart';
import 'package:evole/screens/Requestdetail.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});
  static const String routeName = '/adminRequests';

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
    print("Approving request for UID: $uid");

    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('approveCounsellorRequest');

      final result = await callable.call({"uid": uid});

      print("Success: ${result.data}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request Approved ✅")),
      );
    } catch (e) {
      print("Error approving counsellor request: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to approve request ❌")),
      );
    }
  }

  Future<void> rejectRequest(int index) async {
    String uid = requests[index]["uid"];
    print("Rejecting request for UID: $uid");

    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('rejectCounsellorRequest');

      final result = await callable.call({"uid": uid});

      print("Success: ${result.data}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request Rejected ❌")),
      );

      setState(() {
        requests.removeAt(index);
      });
    } catch (e) {
      print("Error rejecting counsellor request: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to reject request ❌")),
      );
    }
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
                        margin:
                            const EdgeInsets.symmetric(vertical: 10), 
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: const BoxDecoration(
                          border: Border(
                            top:
                                BorderSide(color: Colors.black12), 
                            bottom: BorderSide(
                                color: Colors.black12), 
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RequestDetailsScreen(
                                        data: data,
                                        onApprove: () => approveRequest(index),
                                        onReject: () => rejectRequest(index),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
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
                                                  data["name"]
                                                      .toString()
                                                      .isNotEmpty
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data["name"] ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "${data["institute"] ?? ""} • ${data["qualification"] ?? ""}",
                                            style: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize: const Size(65, 30),
                                  ),
                                  onPressed: () {
                                    approveRequest(index);
                                  },
                                  child: const Text(
                                    "Approve",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    minimumSize: const Size(65, 30),
                                  ),
                                  onPressed: () {
                                    rejectRequest(index);
                                  },
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            )
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
