import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselorListScreen extends StatefulWidget {
  const CounselorListScreen({super.key});

  static const String routeName = "/counselor-list";

  @override
  State<CounselorListScreen> createState() => _CounselorListScreenState();
}

class _CounselorListScreenState extends State<CounselorListScreen> {
  String selectedFilter = "All";
  String searchText = "";

  final List<String> filters = [
    "All",
    "Counseling",
    "Mental health",
    "Guide",
  ];

  Stream<QuerySnapshot> getCounselors() {
    Query query =
        FirebaseFirestore.instance.collection('Counsellors');

    if (selectedFilter != "All") {
      query = query.where(
        'qualification.category',
        isEqualTo: selectedFilter,
      );
    }

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: const Text(
          "Counselor List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.black,
                    ),
                    onSelected: (_) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getCounselors(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          "Error: ${snapshot.error}"));
                }

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text("No counselors found"));
                }

                final counselors =
                    snapshot.data!.docs.where((doc) {
                  final data =
                      doc.data() as Map<String, dynamic>;

                  final name = (data['basicDetail']
                                  ?['name'] ??
                              "")
                          .toString()
                          .toLowerCase();

                  return name.contains(searchText);
                }).toList();

                return ListView.builder(
                  itemCount: counselors.length,
                  itemBuilder: (context, index) {
                    return counselorTile(
                        counselors[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget counselorTile(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final basic =
        Map<String, dynamic>.from(data['basicDetail'] ?? {});

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                (data['profileUrl'] ?? "")
                        .toString()
                        .isNotEmpty
                    ? NetworkImage(data['profileUrl'])
                    : null,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  basic['name'] ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  basic['institute'] ?? "",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
                Text(
                  basic['experience'] ?? "",
                  style:
                      const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}