import 'package:flutter/material.dart';

class ResponsiveHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;

  const ResponsiveHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.06, // 6% of screen width
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   subtitle,
          //   style: TextStyle(
          //     fontSize: screenWidth * 0.035, // 3.5% of screen width
          //     color: Colors.black54,
          //   ),
          // ),
        ],
      ),
      centerTitle: true,
      actions: actions,
      toolbarHeight: screenHeight * 0.1, // 10% of screen height
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 1.5); // Adjustable
}