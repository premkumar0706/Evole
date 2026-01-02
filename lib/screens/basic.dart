import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BasicForm extends StatefulWidget {
  const BasicForm({super.key});

  @override
  State<BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  final PageController _controller = PageController();
  int currentStep = 0;

  bool showGenderOptions = false;
  bool showStatusOptions = false;
  bool showQualificationOptions = false;
  bool showStreamOptions = false;
  bool showYearOptions = false;
  bool isTermsAccepted = false;

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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
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
        if (formData["dob"] == null ||
            formData["age"] == null ||
            formData["age"] <= 0) {
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
          "label": "Your Name",
          "key": "name",
          "type": "text",
          "validator": (value) {
            if (value == null || value.isEmpty) return "Name is required";
            return null;
          },
        },
        {
          "label": "Phone no.",
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
        {
          "label": "Year of Completion",
          "key": "yearOfCompletion",
          "type": "dropdown"
        },
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              return Stack(
                children: [
                  if (currentStep == 0) ...[
                    Positioned(
                      top: -screenHeight * 0.35,
                      left: -screenWidth * 0.70,
                      child: Transform.rotate(
                        angle: -31.7 * 3.1416 / 180,
                        child: Container(
                          width: screenWidth * 0.7,
                          height: screenWidth * 1.15,
                          decoration: const BoxDecoration(
                            color: Color(0xFF160B6E),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -screenHeight * 0.27,
                      right: -screenWidth * 0.85,
                      child: Transform.rotate(
                        angle: 45 * 3.1416 / 180,
                        child: Container(
                          width: screenWidth * 1.2,
                          height: screenWidth * 0.8,
                          decoration:
                              const BoxDecoration(color: Color(0xFF160B6E)),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -screenHeight * 0.1,
                      right: -screenWidth * 0.28,
                      child: Transform.rotate(
                        angle: 11 * 3.1416 / 180,
                        child: Container(
                          width: screenWidth * 0.75,
                          height: screenWidth * 0.45,
                          decoration: const BoxDecoration(
                            color: Color(0xFFA0EAFF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (currentStep == 1) ...[
                    Positioned(
                      top: -screenHeight * 0.40,
                      right: -screenWidth * 0.64,
                      child: Transform.rotate(
                        angle: 68.7 * 3.1416 / 180,
                        child: Container(
                          width: screenWidth * 0.7,
                          height: screenWidth * 1.15,
                          decoration: const BoxDecoration(
                            color: Color(0xFF160B6E),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -screenHeight * 0.30,
                      left: -screenWidth * 0.80,
                      child: Transform.rotate(
                        angle: -45 * 3.1416 / 180,
                        child: Container(
                          width: screenWidth * 1.2,
                          height: screenWidth * 0.8,
                          decoration:
                              const BoxDecoration(color: Color(0xFFA0EAFF)),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -screenHeight * 0.13,
                      left: -screenWidth * 0.26,
                      child: Transform.rotate(
                        angle: -18 * 3.1416 / 180,
                        child: Container(
                          width: screenWidth * 0.75,
                          height: screenWidth * 0.45,
                          decoration: const BoxDecoration(
                            color: Color(0xFF160B6E),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          SafeArea(
            child: Column(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                        ),
                        onPressed: () async {
                          if (!validateStep(currentStep)) return;

                          if (currentStep == formSteps.length - 1 &&
                              !isTermsAccepted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please accept terms & conditions"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (currentStep < formSteps.length - 1) {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            setState(() => currentStep++);
                          } else {
                            await saveBasicdetail();
                          }
                        },
                        child: Text(
                          currentStep == formSteps.length - 1
                              ? "Register"
                              : "Next",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),

                      // 🔥 DOTS — BUTTON KE BILKUL NEECH
                      const SizedBox(height: 6),
                      buildPageIndicator(),
                    ],
                  ),
                ),
              ],
            ),
          )
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
          if (index == 0) const SizedBox(height: 40),
          Center(
            child: Text(
              index == 0 ? "Basic Details" : "Address Information",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: index == 0 ? 28 : 24,
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.w600,
                color: index == 0 ? Colors.black : Colors.black,
              ),
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
          ] else if (index == 1) ...[
            ...fields.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: buildField(f),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  child: Checkbox(
                    value: isTermsAccepted,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "I accept the terms and condition",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
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

    if (key == "gender") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              setState(() {
                showGenderOptions = !showGenderOptions;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: error != null ? Colors.red : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formData["gender"] ?? "Select",
                    style: TextStyle(
                      color: formData["gender"] == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          if (showGenderOptions)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: genderList.map((gender) {
                  return RadioListTile<String>(
                    value: gender,
                    groupValue: formData["gender"],
                    title: Text(gender),
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        formData["gender"] = value;
                        errorData["gender"] = null;
                        showGenderOptions = false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      );
    }
    if (type == "date") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => pickDate(key),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: BoxDecoration(
                border:
                    Border.all(color: error != null ? Colors.red : Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formData[key] ?? label,
                    style: TextStyle(
                      color: formData[key] == null ? Colors.grey : Colors.black,
                      fontSize: 14,
                    ),
                  ),
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

    Widget customRadioDropdown({
      required String fieldKey,
      required String label,
      required List<String> options,
      required bool isOpen,
      required VoidCallback onTap,
    }) {
      String? error = errorData[fieldKey];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: error != null ? Colors.red : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formData[fieldKey] ?? "Select",
                    style: TextStyle(
                      color: formData[fieldKey] == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          if (isOpen)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: options.map((item) {
                  return RadioListTile<String>(
                    value: item,
                    groupValue: formData[fieldKey],
                    title: Text(item),
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        formData[fieldKey] = value;
                        errorData[fieldKey] = null;
                        if (fieldKey == "currentStatus")
                          showStatusOptions = false;
                        if (fieldKey == "qualification")
                          showQualificationOptions = false;
                        if (fieldKey == "stream") showStreamOptions = false;
                        if (fieldKey == "yearOfCompletion")
                          showYearOptions = false;
                      });
                    },
                  );
                }).toList(),
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

    if (key == "currentStatus") {
      return customRadioDropdown(
        fieldKey: "currentStatus",
        label: "Current Status",
        options: statusList,
        isOpen: showStatusOptions,
        onTap: () {
          setState(() {
            showStatusOptions = !showStatusOptions;
          });
        },
      );
    }

    if (key == "qualification") {
      return customRadioDropdown(
        fieldKey: "qualification",
        label: "Qualification",
        options: qualificationList,
        isOpen: showQualificationOptions,
        onTap: () {
          setState(() {
            showQualificationOptions = !showQualificationOptions;
          });
        },
      );
    }

    if (key == "stream") {
      return customRadioDropdown(
        fieldKey: "stream",
        label: "Stream",
        options: streamList,
        isOpen: showStreamOptions,
        onTap: () {
          setState(() {
            showStreamOptions = !showStreamOptions;
          });
        },
      );
    }

    if (key == "yearOfCompletion") {
      return customRadioDropdown(
        fieldKey: "yearOfCompletion",
        label: "Year of Completion",
        options: yearList,
        isOpen: showYearOptions,
        onTap: () {
          setState(() {
            showYearOptions = !showYearOptions;
          });
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: BoxDecoration(
            border: Border.all(
              color: error != null ? Colors.red : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            keyboardType:
                type == "number" ? TextInputType.number : TextInputType.text,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              isDense: true,
              hintText: label,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              formData[key] = value;
              errorData[key] = null;
            },
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(formSteps.length, (index) {
        bool isActive = index == currentStep;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? const Color(0xFF2F2AA0) : Colors.transparent,
            border: Border.all(
              color: isActive ? const Color(0xFF2F2AA0) : Colors.grey,
              width: 1.5,
            ),
          ),
        );
      }),
    );
  }
}
