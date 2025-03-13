import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Color textColor;
  final FontWeight fontWeight;

  const Header({
    Key? key,
    required this.title,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Text(
      title,
      style: TextStyle(
        fontSize: screenWidth * 0.05,
        fontWeight: fontWeight,
        color: textColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}