import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

class UploadResourcesScreen extends StatefulWidget {
  const UploadResourcesScreen({super.key});

  @override
  State<UploadResourcesScreen> createState() => _UploadResourcesScreenState();
}

class _UploadResourcesScreenState extends State<UploadResourcesScreen> {
  List<File> files = [];
  double progress = 0;
  bool uploading = false;
  String filter = "all";

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg', 'pdf'],
    );

    if (result == null) return;

    List<File> selectedFiles = result.files
        .where((f) => f.path != null)
        .map((f) => File(f.path!))
        .toList();

    setState(() {
      uploading = true;
      progress = 0;
    });

    int totalSteps = selectedFiles.length * 10;
    int currentStep = 0;

    for (var file in selectedFiles) {
      for (int i = 0; i < 10; i++) {
        await Future.delayed(const Duration(milliseconds: 200));

        currentStep++;

        setState(() {
          progress = currentStep / totalSteps;
        });
      }

      files.add(file);
    }

    setState(() {
      uploading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Successfully Uploaded")));
  }

  bool isImage(File file) {
    String name = file.path.toLowerCase();

    return name.endsWith("png") ||
        name.endsWith("jpg") ||
        name.endsWith("jpeg") ||
        name.endsWith("svg");
  }

  List<File> get filteredFiles {
    if (filter == "images") {
      return files.where((f) => isImage(f)).toList();
    }

    if (filter == "docs") {
      return files.where((f) => !isImage(f)).toList();
    }

    return files;
  }

  Widget segmentButton(String text, String value) {
    bool selected = filter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          filter = value;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget uploadBox() {
    return GestureDetector(
      onTap: pickFile,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
            color: const Color(0xffc7d1d8),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 12),
            Text(
              "Click to upload or drag and drop\nSVG, PNG, JPG or Pdf",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }

  Widget progressCard() {
    if (!uploading) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white24)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(6)),
            child: const Text("Pdfs", style: TextStyle(fontSize: 10)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Uploading...",
                    style: TextStyle(fontSize: 13, color: Colors.white)),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text("${(progress * 100).toInt()}%",
              style: const TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  Widget fileItem(File file) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              file.path.split('/').last,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(4)),
            child: GestureDetector(
              onTap: () {
                OpenFilex.open(file.path);
              },
              child: const Text("View",
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(4)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  files.remove(file);
                });
              },
              child: const Text("Delete",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Give Guidance",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Upload Resources",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            uploadBox(),
            progressCard(),
            const SizedBox(height: 28),
            const Text(
              "Attached Files",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(child: segmentButton("View All", "all")),
                  Expanded(child: segmentButton("Images", "images")),
                  Expanded(child: segmentButton("Documents", "docs")),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...filteredFiles.map((f) => fileItem(f)).toList()
          ],
        ),
      ),
    );
  }
}
