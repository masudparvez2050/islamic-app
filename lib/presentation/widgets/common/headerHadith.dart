import 'package:flutter/material.dart';

class ResponsiveHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ResponsiveHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.05, // 5% of screen width
        ),
      ),
      backgroundColor: const Color(0xFF00BFA5),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      toolbarHeight: screenHeight * 0.08, // 8% of screen height
    );
  }

  @override
  Size get preferredSize {
    final double screenHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    return Size.fromHeight(screenHeight * 0.08); // Same as toolbarHeight
  }
}