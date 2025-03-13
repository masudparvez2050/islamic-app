import 'package:flutter/material.dart';

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double responsiveWidth(BuildContext context, double width) => screenWidth(context) * width;
double responsiveHeight(BuildContext context, double height) => screenHeight(context) * height;
double responsiveFontSize(BuildContext context, double fontSize) => screenWidth(context) * fontSize;
