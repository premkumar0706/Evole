import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const RequestDetailsScreen({
    super.key,
    required this.data,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counsellor Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.indigo,
              child: Text(
                data["name"] != null && data["name"].toString().isNotEmpty
                    ? data["name"][0]
                    : "?",
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              data["name"] ?? "",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            buildCard("Basic Details", [
              buildRow("Name", data["name"]),
              buildRow("Qualification", data["qualification"]),
              buildRow("Institute", data["institute"]),
              buildRow("Year", data["year"]),
              buildRow("Specialization", data["specialization"]),
              buildRow("Certificate", data["certificate"]),
              buildRow("Experience", data["experience"]),
            ]),

         
            buildCard("Qualifications", [
              buildRow("Category", data["category"]),
              buildRow("Mode", data["mode"]),
              buildRow("Days", data["days"]),
              buildRow("Timeslot", data["timeSlot"]),
            ]),


            buildCard("Counselling Domain", [
              buildRow("Philosophy", data["philosophy"]),
              buildRow("Values", data["values"]),
            ]),

           
            buildCard("Availability", [
              buildRow("State", data["state"]),
              buildRow("City", data["city"]),
              buildRow("Address", data["address"]),
            ]),


            buildCard("Approach", [
              buildRow("Session URL", data["Url"]),
              buildRow("Photo", data["photo"]),
            ]),

            const SizedBox(height: 20),

           
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      onApprove();
                      Navigator.pop(context);
                    },
                    child: const Text("Accept"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      onReject();
                      Navigator.pop(context);
                    },
                    child: const Text("Reject"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border(
                right: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$title:",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value?.toString() ?? "-",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}