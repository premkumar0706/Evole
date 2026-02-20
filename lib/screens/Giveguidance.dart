import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'giveguidanceform.dart';

class GiveGuidanceScreen extends StatefulWidget {
  const GiveGuidanceScreen({super.key});


  static const String routeName = '/giveGuidance';
  @override
  State<GiveGuidanceScreen> createState() => _GiveGuidanceScreenState();
}

class _GiveGuidanceScreenState extends State<GiveGuidanceScreen> {
  int bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "GIVE\nGUIDANCE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'InriaSerif',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.15,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "“Become a Counsellor on EVOLE”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF0DD60),
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 45),

                  /// Apply button
                  SizedBox(
                    width: 250,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const GiveGuidanceForm(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA0EAFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BulletText(text: "Share your experience"),
                      BulletText(text: "Help students"),
                      BulletText(text: "Build your profile"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /// Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: bottomIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: (index) {
            setState(() {
              bottomIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 24,
                height: 24,
                color: bottomIndex == 0 ? Colors.black : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/folder.svg',
                width: 24,
                height: 24,
                color: bottomIndex == 1 ? Colors.black : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/settings.svg',
                width: 24,
                height: 24,
                color: bottomIndex == 2 ? Colors.black : Colors.grey,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;
  const BulletText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("• ",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
