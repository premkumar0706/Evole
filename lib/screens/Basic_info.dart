import 'package:flutter/material.dart';
import '../constants.dart';

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
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent.shade100,
      ),
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
            
            if (_currentPage == 0)
              _buildPage1Background(w, h)
            else
              _buildPage2Background(w, h),
            Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  _buildFirstForm(context),
                  _buildSecondForm(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1Background(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        
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
              decoration: const BoxDecoration(color: Color(0xFF160B6E)),
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
    );
  }

  Widget _buildPage2Background(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        
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
              decoration: const BoxDecoration(color: Color(0xFFA0EAFF )),
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
    );
  }


  Widget _buildFirstForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCenteredHeading("Basic Information"),
          
          const SizedBox(height: 40),
          _buildLabel("Name"),
          _buildTextField("Your name", nameController,
              validator: (v) => v!.isEmpty ? "Enter your name" : null),
          const SizedBox(height: 25),
          _buildLabel("DOB"),
          _buildTextField("Your DOB (DD/MM/YYYY)", dobController,
              validator: (v) => v!.isEmpty ? "Enter your DOB" : null),
          const SizedBox(height: 25),
          _buildLabel("Gender"),
          _buildTextField("Your Gender", genderController,
              validator: (v) => v!.isEmpty ? "Enter your gender" : null),
          const SizedBox(height: 25),
          _buildLabel("Phone No."),
          _buildTextField("Your Number", phoneController,
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? "Enter phone number" : null),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                activeColor: const Color(0xFF160B6E),
                value: agreePage1,
                onChanged: (val) {
                  setState(() => agreePage1 = val ?? false);
                },
              ),
              const Expanded(
                child: Text(
                  "I confirm that all the above details are correct.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(child: SizedBox(
              width: 200, // <-- increase/decrease this value for button width
              height: 50, 
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  _showError("Please fill all details!");
                } else if (!agreePage1) {
                  _showError("Please agree before continuing!");
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
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


  Widget _buildSecondForm(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCenteredHeading("Basic Information"),
          const SizedBox(height: 40),
          _buildLabel("Current Status"),
          _buildDropdown("Current Status", ["Student", "Working", "Other"],
              (val) => setState(() => currentStatus = val)),
          const SizedBox(height: 25),
          _buildLabel("Select Highest Qualification"),
          _buildDropdown("Select Highest Qualification",
              ["10th", "12th", "B.Tech", "M.Tech", "Other"],
              (val) => setState(() => highestQualification = val)),
          const SizedBox(height: 25),
          _buildLabel("Field/Stream"),
          _buildDropdown("Field/Stream",
              ["CSE", "ECE", "EEE", "ME", "CE", "Other"],
              (val) => setState(() => fieldStream = val)),
          const SizedBox(height: 25),
          _buildLabel("Year Of Completion"),
          _buildDropdown("Year Of Completion",
              ["2023", "2024", "2025", "2026"],
              (val) => setState(() => yearOfCompletion = val)),
          const SizedBox(height: 30),
          Row(
            children: [
              Checkbox(
                activeColor: const Color(0xFF160B6E),
                value: agreePage2,
                onChanged: (val) {
                  setState(() => agreePage2 = val ?? false);
                },
              ),
              const Expanded(
                child: Text(
                  "I confirm all  above information is true.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center( child: SizedBox(
              width: 220, // change for button length
              height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (currentStatus == null ||
                    highestQualification == null ||
                    fieldStream == null ||
                    yearOfCompletion == null) {
                  _showError("Please fill all details!");
                } else if (!agreePage2) {
                  _showError("Please agree before continuing!");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Registration Completed Successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
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

 
  Widget _buildCenteredHeading(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
       cursorColor: Colors.black, 
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF160B6E), width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String hint, List<String> items, Function(String?) onChanged) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: DropdownButtonFormField<String>(
        value: null,
        hint: Text(hint, style: const TextStyle(color: Colors.grey)),
        isExpanded: true,
        decoration: const InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF160B6E), width: 2),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.black)),
                ))
            .toList(),
        onChanged: onChanged,
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
        color: isActive ? const Color(0xFF160B6E) : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}
