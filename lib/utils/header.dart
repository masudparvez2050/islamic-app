import 'package:flutter/material.dart';

double responsiveWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * (width / 375.0);
}

double responsiveHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * (height / 812.0);
}

double responsiveFontSize(BuildContext context, double fontSize) {
  double baseWidth = 375.0;
  double baseHeight = 812.0;
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  double scaleWidth = screenWidth / baseWidth;
  double scaleHeight = screenHeight / baseHeight;
  double scale = (scaleWidth + scaleHeight) / 2;
  return fontSize * scale;
}
