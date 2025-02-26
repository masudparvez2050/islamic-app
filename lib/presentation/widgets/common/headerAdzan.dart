import 'package:flutter/material.dart';

class ResponsiveHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const ResponsiveHeader({
    Key? key,
    required this.title,
    this.backgroundColor = const Color(0xFF00BFA5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.07,
        ),
      ),
      iconTheme: IconThemeData(
          color: Colors.white,
        ),
      backgroundColor: backgroundColor,
      elevation: 0,
      toolbarHeight: screenWidth * 0.15,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 1.2);
}