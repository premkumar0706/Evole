import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
        ),
        title: const Text(
          'Hello Shambhavi!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,  // Will use Inter-Bold.ttf
            color: Colors.black,
            fontFamily: 'Inter',  // Added this line
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgPicture.asset(
              'assets/icons/bookmark.svg', // Bookmark icon on right
              width: 26,
              height: 26,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              'assets/icons/bell.svg', // Bell icon on right
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),

      drawer: CustomDrawer(
        onClose: () {
          _scaffoldKey.currentState?.closeDrawer();
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Card - Updated to match design
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFEFCE3), // Light grey background
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFEFCE3), width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/bell(1).svg',
                        width: 24,
                        height: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Notification',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,  // Will use Inter-SemiBold.ttf
                                color: Colors.black,
                                fontFamily: 'Inter',  // Added this line
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '*New*',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',  // Added this line
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '3rd semester start date - 08/12/25 (DIGITAL)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,  // Will use Inter-Regular.ttf
                            color: Colors.black54,
                            fontFamily: 'Inter',  // Added this line
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 4 Small Rounded Boxes - EMPTY boxes as requested
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _emptyBox(),
                _emptyBox(),
                _emptyBox(),
                _emptyBox(),
              ],
            ),
            const SizedBox(height: 40),

            // Seek Guidance Card - Updated to match design
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: const Color(0x5EB5ECFC),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF068BB0), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seek Guidance',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Inter',  // Added this line
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Placeholder lines (simpler design)
                  _guidancePlaceholderLine(width: 0.9),
                  const SizedBox(height: 12),
                  _guidancePlaceholderLine(width: 0.8),
                  const SizedBox(height: 12),
                  _guidancePlaceholderLine(width: 0.7),

                  const SizedBox(height: 40),

                  // Get Started Button - Updated style
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigation soon!
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Inter',  // Added this line
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Navigation Bar - Updated to match design
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
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade400,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 24,
                    height: 24,
                    color: _currentIndex == 0 ? Colors.black : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 1
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/folder.svg',
                    width: 24,
                    height: 24,
                    color: _currentIndex == 1 ? Colors.black : Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _currentIndex == 2
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/settings.svg',
                    width: 24,
                    height: 24,
                    color: _currentIndex == 2 ? Colors.black : Colors.grey,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Empty box - Just border and shadow, no icon
  Widget _emptyBox() {
    return Container(
      width: 82,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

  // Updated placeholder line for Seek Guidance section
  Widget _guidancePlaceholderLine({double width = 1.0}) {
    return Container(
      height: 12,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}