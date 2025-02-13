import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/settings_screen.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.002),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth * 0.05),
          bottomRight: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: screenWidth * 0.075),
            onPressed: () {
              // Navigate to the SettingsScreen with a right-to-left slide animation
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SettingsScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenHeight * 0.005),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(screenWidth * 0.15),
              ),
              child: Text(
                'ধর্ম-Religion',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Spacer(),
          CircleAvatar(
            radius: screenWidth * 0.05,
            backgroundColor: Colors.white24,
            backgroundImage: _getUserAvatar(),
            child: _getUserAvatar() == null
                ? Icon(Icons.person, color: Colors.white, size: screenWidth * 0.07)
                : null,
          ),
        ],
      ),
    );
  }

  ImageProvider? _getUserAvatar() {
    // TODO: Implement logic to get user's avatar
    // For now, we'll return null to show the placeholder
    return null;
  }
}