import 'package:flutter/material.dart';
import '../constants.dart';
import 'home_page.dart'; 

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

  bool agreePage1 = false;
  bool agreePage2 = false;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent.shade100),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            _currentPage == 0 ? _buildPage1Background(w, h) : _buildPage2Background(w, h),

            Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _buildFirstForm(),
                  _buildSecondForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Backgrounds (unchanged)
  Widget _buildPage1Background(double w, double h) {
    return Stack(
      children: [
        Positioned(
          top: -h * 0.35,
          left: -w * 0.70,
          child: Transform.rotate(
            angle: -31.7 * 3.1416 / 180,
            child: Container(
              width: w * 0.7,
              height: w * 1.15,
              decoration: const BoxDecoration(
                color: Color(0xFF160B6E),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -h * 0.27,
          right: -w * 0.85,
          child: Transform.rotate(
            angle: 45 * 3.1416 / 180,
            child: Container(width: w * 1.2, height: w * 0.8, color: const Color(0xFF160B6E)),
          ),
        ),
        Positioned(
          bottom: -h * 0.1,
          right: -w * 0.28,
          child: Transform.rotate(
            angle: 11 * 3.1416 / 180,
            child: Container(
              width: w * 0.75,
              height: w * 0.45,
              decoration: const BoxDecoration(
                color: Color(0xFFA0EAFF),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage2Background(double w, double h) {
    return Stack(
      children: [
        Positioned(
          top: -h * 0.40,
          right: -w * 0.64,
          child: Transform.rotate(
            angle: 68.7 * 3.1416 / 180,
            child: Container(
              width: w * 0.7,
              height: w * 1.15,
              decoration: const BoxDecoration(
                color: Color(0xFF160B6E),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -h * 0.30,
          left: -w * 0.80,
          child: Transform.rotate(
            angle: -45 * 3.1416 / 180,
            child: Container(width: w * 1.2, height: w * 0.8, color: const Color(0xFFA0EAFF)),
          ),
        ),
        Positioned(
          bottom: -h * 0.13,
          left: -w * 0.26,
          child: Transform.rotate(
            angle: -18 * 3.1416 / 180,
            child: Container(
              width: w * 0.75,
              height: w * 0.45,
              decoration: const BoxDecoration(
                color: Color(0xFF160B6E),
                borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Page 1
  Widget _buildFirstForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCenteredHeading("Basic Information"),
          const SizedBox(height: 40),
          _buildLabel("Name"),
          _buildTextField("Your name", nameController, validator: (v) => v!.isEmpty ? "Enter your name" : null),
          const SizedBox(height: 25),
          _buildLabel("DOB"),
          _buildTextField("Your DOB (DD/MM/YYYY)", dobController, validator: (v) => v!.isEmpty ? "Enter your DOB" : null),
          const SizedBox(height: 25),
          _buildLabel("Gender"),
          _buildTextField("Your Gender", genderController, validator: (v) => v!.isEmpty ? "Enter your gender" : null),
          const SizedBox(height: 25),
          _buildLabel("Phone No."),
          // FIXED: keyboardType comes BEFORE validator
          _buildTextField(
            "Your Number",
            phoneController,
            keyboardType: TextInputType.phone,
            validator: (v) => v!.isEmpty ? "Enter phone number" : null,
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                activeColor: const Color(0xFF160B6E),
                value: agreePage1,
                onChanged: (v) => setState(() => agreePage1 = v ?? false),
              ),
              const Expanded(child: Text("I confirm that all the above details are correct.", style: TextStyle(fontSize: 14))),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    _showError("Please fill all details!");
                  } else if (!agreePage1) {
                    _showError("Please agree before continuing!");
                  } else {
                    _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("Next", style: buttonTextStyle),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildDots(),
        ],
      ),
    );
  }

  // Page 2 - Register button fixed
  Widget _buildSecondForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCenteredHeading("Basic Information"),
          const SizedBox(height: 40),
          _buildLabel("Current Status"),
          _buildDropdown("Current Status", ["Student", "Working", "Other"], (v) => setState(() => currentStatus = v)),
          const SizedBox(height: 25),
          _buildLabel("Select Highest Qualification"),
          _buildDropdown("Select Highest Qualification", ["10th", "12th", "B.Tech", "M.Tech", "Other"], (v) => setState(() => highestQualification = v)),
          const SizedBox(height: 25),
          _buildLabel("Field/Stream"),
          _buildDropdown("Field/Stream", ["CSE", "ECE", "EEE", "ME", "CE", "Other"], (v) => setState(() => fieldStream = v)),
          const SizedBox(height: 25),
          _buildLabel("Year Of Completion"),
          _buildDropdown("Year Of Completion", ["2023", "2024", "2025", "2026"], (v) => setState(() => yearOfCompletion = v)),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                activeColor: const Color(0xFF160B6E),
                value: agreePage2,
                onChanged: (v) => setState(() => agreePage2 = v ?? false),
              ),
              const Expanded(child: Text("I confirm all above information is true.", style: TextStyle(fontSize: 14))),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (currentStatus == null || highestQualification == null || fieldStream == null || yearOfCompletion == null) {
                    _showError("Please fill all details!");
                  } else if (!agreePage2) {
                    _showError("Please agree before continuing!");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration Completed Successfully!"), backgroundColor: Colors.green),
                    );

                    nameController.clear();
                    dobController.clear();
                    genderController.clear();
                    phoneController.clear();
                    setState(() {
                      currentStatus = highestQualification = fieldStream = yearOfCompletion = null;
                      agreePage1 = agreePage2 = false;
                    });
                    _formKey.currentState?.reset();

                    // FIXED: removed 'const' before HomePage()
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("Register", style: buttonTextStyle),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildDots(),
        ],
      ),
    );
  }

  // Helper widgets (unchanged)
  Widget _buildCenteredHeading(String t) => Center(child: Text(t, style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)));
  Widget _buildLabel(String t) => Text(t, style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500));

  Widget _buildTextField(String hint, TextEditingController c,
      {TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: c,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF160B6E), width: 2)),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      hint: Text(hint, style: const TextStyle(color: Colors.grey)),
      isExpanded: true,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF160B6E), width: 2)),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDots() => Row(mainAxisAlignment: MainAxisAlignment.center, children: [_dot(isActive: _currentPage == 0), const SizedBox(width: 8), _dot(isActive: _currentPage == 1)]);

  Widget _dot({required bool isActive}) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: isActive ? const Color(0xFF160B6E) : Colors.grey.shade400, shape: BoxShape.circle),
      );
}