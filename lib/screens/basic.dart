import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BasicForm extends StatefulWidget {
  const BasicForm({super.key});

  @override
  State<BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  final PageController _controller = PageController();
  int currentStep = 0;

  final List<String> genderList = ["Male", "Female", "Other"];
  final List<String> statusList = ["Passout", "Pursuing", "Dropout"];
  final List<String> qualificationList = [
    "10th",
    "12th",
    "Diploma",
    "Graduation",
    "Post Graduation"
  ];
  final List<String> streamList = ["PCM", "PCB", "Commerce", "Arts", "Other"];
  final List<String> yearList = List.generate(26, (i) => (2000 + i).toString());

  Map<String, dynamic> formData = {};
  Map<String, String?> errorData = {};

  int calculateAge(DateTime dob) {
    DateTime today = DateTime.now();

    if (dob.isAfter(today)) return 0; 

    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  Future<void> pickDate(String key) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(), 
      initialDate: DateTime(2000),
    );

    if (date != null) {
      int age = calculateAge(date);
      if (age <= 0) {
        errorData[key] = "Please select a valid DOB";
        setState(() {});
        return;
      }

      setState(() {
        formData[key] = "${date.day}-${date.month}-${date.year}";
        formData["age"] = age;
        errorData[key] = null;
      });
    }
  }

  bool validateStep(int stepIndex) {
    bool isValid = true;

    for (var field in formSteps[stepIndex]["fields"]) {
      String key = field["key"];
      String type = field["type"];

      if (key == "dob") {
        if (formData["dob"] == null || formData["age"] == null || formData["age"] <= 0) {
          errorData["dob"] = "Please select a valid DOB";
          isValid = false;
          continue;
        } else {
          errorData["dob"] = null;
        }
      }

      if (type == "dropdown") {
        if (formData[key] == null) {
          errorData[key] = "${field["label"]} is required";
          isValid = false;
        } else {
          errorData[key] = null;
        }
      } else {
        Function validator = field["validator"];
        String? error = validator(formData[key]);
        errorData[key] = error;
        if (error != null) isValid = false;
      }
    }

    setState(() {});
    return isValid;
  }

 Future<void> saveBasicdetail() async {
  try {
    final callable = FirebaseFunctions.instance.httpsCallable('onboardUser');

    // Age only if valid
    final ageValue = formData["age"] != null && formData["age"]! > 0
        ? formData["age"]
        : null;

    final result = await callable.call({
      "name": formData["name"] ?? "",
      "age": ageValue,
      "gender": formData["gender"] ?? "",
      "phone": formData["phone"] ?? "",
      "currentStatus": formData["currentStatus"] ?? "",
      "qualification": formData["qualification"] ?? "",
      "stream": formData["stream"] ?? "",
      "yearOfCompletion": formData["yearOfCompletion"] ?? "",
    });

    if (result.data['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data saved successfully!"),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to save: ${result.data['message']}"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}


  final List<Map<String, dynamic>> formSteps = [
    {
      "step": 1,
      "fields": [
        {
          "label": "Name",
          "key": "name",
          "type": "text",
          "validator": (value) {
            if (value == null || value.isEmpty) return "Name is required";
            return null;
          },
        },
        {
          "label": "Phone",
          "key": "phone",
          "type": "number",
          "validator": (value) {
            if (value == null || value.isEmpty) return "Phone is required";
            if (value.length != 10) return "Phone must be 10 digits";
            return null;
          },
        },
        {
          "label": "Gender",
          "key": "gender",
          "type": "dropdown",
        },
        {
          "label": "DOB",
          "key": "dob",
          "type": "date",
          "validator": (value) {
            if (value == null) return "DOB required";
            return null;
          }
        },
      ],
    },
    {
      "step": 2,
      "fields": [
        {"label": "Current Status", "key": "currentStatus", "type": "dropdown"},
        {"label": "Qualification", "key": "qualification", "type": "dropdown"},
        {"label": "Stream", "key": "stream", "type": "dropdown"},
        {"label": "Year of Completion", "key": "yearOfCompletion", "type": "dropdown"},
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: currentStep == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  setState(() => currentStep--);
                },
              )
            : null,
        title: const Text("Basic Form"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(      
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildStep(0),
                buildStep(1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              onPressed: () async {
                if (!validateStep(currentStep)) return;

                if (currentStep < formSteps.length - 1) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  setState(() => currentStep++);
                } else {
                  await saveBasicdetail();
                }
              },
              child: Text(
                currentStep == formSteps.length - 1 ? "Submit" : "Next",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStep(int index) {
    var fields = formSteps[index]["fields"];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index == 0 ? "Basic Details" : "Address Information",
            style: TextStyle(
              fontSize: index == 0 ? 28 : 24,
              fontWeight: index == 0 ? FontWeight.bold : FontWeight.w600,
              color: index == 0 ? Colors.black : Colors.blue.shade700,
            ),
          ),

          const SizedBox(height: 20),

          if (index == 0) ...[
            ...fields.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: buildField(f),
              ),
            ),
          ] else ...[
            Padding(padding: EdgeInsets.all(10), child: Text("read")),
            ...fields.map(
              (f) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: buildField(f),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildField(Map<String, dynamic> field) {
    String key = field["key"];
    String label = field["label"];
    String type = field["type"];
    String? error = errorData[key];

    if (type == "date") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => pickDate(key),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: BoxDecoration(
                border: Border.all(color: error != null ? Colors.red : Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formData[key] ?? label),
                  const Icon(Icons.calendar_month),
                ],
              ),
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),
        ],
      );
    }

    if (type == "dropdown") {
      List<String> items = [];
      if (key == "gender") items = genderList;
      if (key == "currentStatus") items = statusList;
      if (key == "qualification") items = qualificationList;
      if (key == "stream") items = streamList;
      if (key == "yearOfCompletion") items = yearList;

      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          errorText: error,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        value: formData[key],
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (value) {
          setState(() {
            formData[key] = value;
            errorData[key] = null;
          });
        },
      );
    }

    return TextField(
      keyboardType: type == "number" ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        errorText: error,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (value) {
        formData[key] = value;
        errorData[key] = null;
      },
    );
  }
}
