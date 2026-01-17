import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GiveGuidanceForm extends StatefulWidget {
  const GiveGuidanceForm({super.key});

  @override
  State<GiveGuidanceForm> createState() => _GiveGuidanceFormState();
}

class _GiveGuidanceFormState extends State<GiveGuidanceForm> {
  final PageController _pageController = PageController();
  int currentStep = 0;

  final Map<String, String?> formData = {};
  final Map<String, String?> errorData = {};

  bool qOpen = false,
      yOpen = false,
      sOpen = false,
      eOpen = false,
      cOpen = false,
      mOpen = false,
      dOpen = false,
      tOpen = false, 
      vOpen = false,
      cityOpen = false;

  final qualificationList = ["10th", "12th", "Graduation", "Post Graduation"];
  final yearList = List.generate(25, (i) => (2000 + i).toString());
  final specializationList = ["Science", "Commerce", "Arts", "Other"];
  final experienceList = ["0-1", "1-3", "3-5", "5+"];

  final categoryList = ["Career", "Education", "Mental Health"];
  final modeList = ["Chat", "Call", "Video"];
  final daysList = ["Weekdays", "Weekend", "Any Day"];
  final timeSlotList = [
    "Morning (6–10 AM)",
    "Afternoon (12–4 PM)",
    "Evening (5–9 PM)"
  ];
  final valuesList = ["Trust", "Empathy", "Growth"];
  final cityList = ["Delhi", "Mumbai", "Bangalore"];

  Widget stepTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Center(
    
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF160B6E),
          ),
        ),
      ),
    );
  }

  Widget floatingField({
    required String label,
    required String fieldKey,
    bool readOnly = false,
    Widget? suffix,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: readOnly ? "Select" : "Type here",
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(color: Colors.black, width: 1.3),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: const BorderSide(color: Colors.red, width: 1.3),
              ),
              errorText: errorData[fieldKey],
              suffixIcon: suffix,
            ),
            onChanged: (v) {
              formData[fieldKey] = v;
              errorData[fieldKey] = null;
              setState(() {});
            },
          ),
          Positioned(
            left: 18,
            top: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: Colors.white,
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget floatingDropdown(
    String label,
    String key,
    List<String> options,
    bool isOpen,
    VoidCallback toggle,
  ) {
    return Column(
      children: [
        floatingField(
          label: label,
          fieldKey: key,
          readOnly: true,
          suffix: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey.shade400,
          ),
          onTap: toggle,
        ),
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.white,
            ),
            child: Column(
              children: options.map((e) {
                return RadioListTile<String>(
                  value: e,
                  groupValue: formData[key],
                  activeColor: Colors.black,
                  title: Text(e),
                  onChanged: (v) {
                    formData[key] = v;
                    errorData[key] = null;
                    toggle();
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget pageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentStep == i ? 10 : 8,
          height: currentStep == i ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentStep == i
                ? const Color(0xFF2F2AA0)
                : Colors.grey.shade400,
          ),
        );
      }),
    );
  }

  bool validateStep() {
    List<String> required = [];

    if (currentStep == 0) {
      required = [
        "qualification",
        "institute",
        "year",
        "specialization",
        "certificate",
        "experience"
      ];
    } else if (currentStep == 1) {
      required = ["category", "mode", "days", "philosophy", "values"];
    } else {
      required = ["address", "city", "session"];
    }

    bool valid = true;
    for (var k in required) {
      if (formData[k] == null || formData[k]!.isEmpty) {
        errorData[k] = "Required";
        valid = false;
      }
    }
    setState(() {});
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Give Guidance",
          style: TextStyle(
            fontSize: 36, 
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: currentStep == 0
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  currentStep--;
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  setState(() {});
                },
              ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  stepOne(),
                  stepTwo(),
                  stepThree(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (!validateStep()) return;

                      if (currentStep < 2) {
                        currentStep++;
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                      setState(() {});
                    },
                    child: Text(
                      currentStep == 2 ? "Submit" : "Next",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),

          
            pageDots(),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: (index) {
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/folder.svg',
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                width: 24,
                height: 24,
                color: Colors.grey, 
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget stepOne() => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepTitle("Qualifications"),
            floatingDropdown("Highest Qualification", "qualification",
                qualificationList, qOpen, () {
              qOpen = !qOpen;
              setState(() {});
            }),
            floatingField(label: "Institute", fieldKey: "institute"),
            floatingDropdown("Year Of Passing", "year", yearList, yOpen, () {
              yOpen = !yOpen;
              setState(() {});
            }),
            floatingDropdown(
                "Specialization", "specialization", specializationList, sOpen,
                () {
              sOpen = !sOpen;
              setState(() {});
            }),
            floatingField(label: "Certificate URL", fieldKey: "certificate"),
            floatingDropdown(
                "Total Year OfExperience", "experience", experienceList, eOpen,
                () {
              eOpen = !eOpen;
              setState(() {});
            }),
          ],
        ),
      );

  Widget stepTwo() => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepTitle("Counselling Domain"),
            floatingDropdown("Category", "category", categoryList, cOpen, () {
              cOpen = !cOpen;
              setState(() {});
            }),
            floatingDropdown("Preferred Mode", "mode", modeList, mOpen, () {
              mOpen = !mOpen;
              setState(() {});
            }),
            floatingDropdown("Available Days", "days", daysList, dOpen, () {
              dOpen = !dOpen;
              setState(() {});
            }),
          
            floatingDropdown("Time Slots", "timeSlot", timeSlotList, tOpen, () {
              tOpen = !tOpen;
              setState(() {});
            }),
            floatingField(
                label: "Counselling Philosophy", fieldKey: "philosophy"),
            floatingDropdown("Values", "values", valuesList, vOpen, () {
              vOpen = !vOpen;
              setState(() {});
            }),
          ],
        ),
      );

  Widget stepThree() => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepTitle("Almost Done!"),
            floatingField(label: "State", fieldKey: "locality"),
            floatingField(label: "Address", fieldKey: "address"),
            floatingDropdown("City", "city", cityList, cityOpen, () {
              cityOpen = !cityOpen;
              setState(() {});
            }),
            floatingField(label: "Your Photo", fieldKey: "Photo"),
            floatingField(label: "Sample Session Url", fieldKey: "Url"),
          ],
        ),
      ); 
}
