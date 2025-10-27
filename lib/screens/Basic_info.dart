import 'package:flutter/material.dart';
import '../theme/constants.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? currentStatus;
  String? highestQualification;
  String? fieldStream;
  String? yearOfCompletion;

  bool firstFormChecked = false;
  bool secondFormChecked = false;

  late final List<Map<String, dynamic>> textFeilds = [
    {
      "label": "Name",
      "controller": nameController,
      "cursorColor": Colors.black,
      "validator": (value) =>
          value!.trim().isEmpty ? 'Please enter your name' : null,
    },
    {
      "label": "DOB",
      "controller": dobController,
      "cursorColor": Colors.black,
      "validator": (value) => value!.trim().isEmpty ? 'Please enter DOB' : null,
    },
    {
      "label": "Gender",
      "controller": genderController,
      "cursorColor": Colors.black,
      "validator": (value) =>
          value!.trim().isEmpty ? 'Please enter Gender' : null,
    },
    {
      "label": "Phone No",
      "controller": phoneController,
      "cursorColor": Colors.black,
      "validator": (value) =>
          value!.trim().isEmpty ? 'Please enter Phone No' : null,
    },
  ];

  bool isFirstFormValid() {
    return _formKey.currentState!.validate() && firstFormChecked;
  }

  bool isSecondFormValid() {
    return currentStatus != null &&
        highestQualification != null &&
        fieldStream != null &&
        yearOfCompletion != null &&
        secondFormChecked;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 147, 164, 209),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildEvoleHeader(),
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: _currentPage == 0
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    _buildFirstForm(context),
                    _buildSecondForm(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvoleHeader() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: 120,
        height: 120,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, highlightColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(120)),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 15, left: 15),
          child: Text(
            "Evole",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading(),
            const SizedBox(height: 40),
            Column(
              children: textFeilds.map((field) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: field['controller'],
                    cursorColor: field['cursorColor'],
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: field['label'],
                      hintStyle: const TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: textFieldFillColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          textFieldBorderRadius,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: field['validator'],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: firstFormChecked,
                  onChanged: (val) {
                    setState(() => firstFormChecked = val!);
                  },
                ),
                const Expanded(
                  child: Text(
                    "I Agree With Terms & Conditions",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isFirstFormValid()) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _showError(
                      "Fill all fields and check the box to continue!",
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 14,
                  ),
                  elevation: 6,
                ),
                child: const Text("Next", style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            _buildDots(),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading(),
            const SizedBox(height: 40),
            _buildDropdown("Current Status", [
              "Student",
              "Working",
              "Other",
            ], (val) => setState(() => currentStatus = val)),
            const SizedBox(height: 16),
            _buildDropdown(
              "Highest Qualification",
              ["10th", "12th", "B.Tech", "M.Tech", "Other"],
              (val) => setState(() => highestQualification = val),
            ),
            const SizedBox(height: 16),
            _buildDropdown("Field/Stream", [
              "CSE",
              "ECE",
              "EEE",
              "ME",
              "CE",
              "Other",
            ], (val) => setState(() => fieldStream = val)),
            const SizedBox(height: 16),
            _buildDropdown("Year of Completion", [
              "2023",
              "2024",
              "2025",
              "2026",
            ], (val) => setState(() => yearOfCompletion = val)),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: secondFormChecked,
                  onChanged: (val) {
                    setState(() => secondFormChecked = val!);
                  },
                ),
                const Expanded(
                  child: Text(
                    "I Agree With Terms & Conditions",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isSecondFormValid()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registration Completed Successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    _showError(
                      "Fill all fields and check the box to register!",
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 14,
                  ),
                  elevation: 6,
                ),
                child: const Text("Register", style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            _buildDots(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Basic\n",
            style: TextStyle(
              color: highlightColor,
              fontSize: headingFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "Information",
            style: TextStyle(
              color: whiteColor,
              fontSize: headingFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: textFieldFillColor,
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint, style: const TextStyle(color: Colors.black54)),
          isExpanded: true,
          value: hint == "Current Status"
              ? currentStatus
              : hint == "Highest Qualification"
              ? highestQualification
              : hint == "Field/Stream"
              ? fieldStream
              : hint == "Year of Completion"
              ? yearOfCompletion
              : null,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.black),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(isActive: _currentPage == 0),
        const SizedBox(width: 8),
        _dot(isActive: _currentPage == 1),
      ],
    );
  }

  Widget _dot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? highlightColor : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}