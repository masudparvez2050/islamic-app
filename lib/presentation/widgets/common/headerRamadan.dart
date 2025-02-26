import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResponsiveHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed; // Optional back button callback

  const ResponsiveHeader({
    required this.title,
    this.onBackPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02, // 2% of screen height
        horizontal: screenWidth * 0.04, // 4% of screen width
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (onBackPressed != null)
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: screenWidth * 0.06),
              onPressed: onBackPressed,
            ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.07, // 5% of screen width
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              
              textAlign: TextAlign.start,
            ),
            
          ),
        ],
      ),
    );
  }
}