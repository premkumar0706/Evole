import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evole/screens/Giveguidance.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onClose;

  const CustomDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      elevation: 20,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          // Header with close button
          Container(
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 28),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 48), // For balance
                  ],
                ),
                const SizedBox(height: 20),
                // User avatar and info
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Prem kumar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Prem@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: [
                _drawerItem(
                  icon: 'assets/icons/settings.svg',
                  title: 'Settings',
                  onTap: () {
                    onClose();
                    // Navigate to settings
                  },
                ),
                _drawerItem(
                  icon: 'assets/icons/moon.svg', // You need to add this SVG
                  title: 'Deep Mode',
                  onTap: () {
                    onClose();
                    // Navigate to deep mode
                  },
                ),
                _drawerItem(
                  icon: 'assets/icons/bolt.svg', // You need to add this SVG
                  title: 'Quick Mode',
                  onTap: () {
                    onClose();
                    // Navigate to quick mode
                  },
                ),
                _drawerItem(
                  icon: 'assets/icons/moon.svg', // You need to add this SVG
                  title: 'Give guidance',
                  onTap: () {
                    Navigator.pushNamed(
                        context, GiveGuidanceScreen.routeName);
                  },
                ),
                _drawerItem(
                  icon: 'assets/icons/chat.svg', // You need to add this SVG
                  title: 'Counseling Sessions',
                  onTap: () {
                    onClose();
                    // Navigate to counseling
                  },
                ),
                _drawerItem(
                  icon: 'assets/icons/quiz.svg', // You need to add this SVG
                  title: 'Basic Quiz',
                  onTap: () {
                    onClose();
                    // Navigate to quiz
                  },
                ),
                _drawerItem(
                  icon: '', // You need to add this SVG
                  title: 'Councellor request',
                  onTap: () {
                    onClose();
                    // Navigate to request
                  },
                ),
                const Divider(thickness: 1, height: 40),
                _drawerItem(
                  icon: 'assets/icons/logout.svg', // You need to add this SVG
                  title: 'Logout',
                  titleColor: const Color.fromARGB(255, 54, 155, 244),
                  iconColor: const Color.fromARGB(255, 54, 174, 244),
                  onTap: () {
                    onClose();
                    // Show logout confirmation
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color titleColor = Colors.black,
    Color iconColor = Colors.black,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
            color: iconColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: titleColor,
          fontFamily: 'Inter',
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
        size: 24,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement logout logic
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
