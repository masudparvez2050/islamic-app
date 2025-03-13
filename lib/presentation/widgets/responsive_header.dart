import 'package:flutter/material.dart';

class ResponsiveHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final Size preferredSize;

  ResponsiveHeader({
    Key? key,
    required this.title,
    this.backgroundColor = const Color(0xFF00BFA5),
    this.textColor = Colors.white,
    this.centerTitle = true,
    this.actions,
  }) : 
    preferredSize = const Size.fromHeight(kToolbarHeight),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsive calculations
    final Size screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.05; // 5% of screen width
    
    return AppBar(
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: textColor, 
        fontSize: fontSize > 24 ? 24 : fontSize < 18 ? 18 : fontSize,
        fontWeight: FontWeight.w500,
      ),
      title: Text(title),
      centerTitle: centerTitle,
      elevation: 0,
      actions: actions,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
    );
  }
}
