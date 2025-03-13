import 'package:flutter/material.dart';

class ResponsiveUtils {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double textScaleFactor;
  static late double devicePixelRatio;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    textScaleFactor = _mediaQueryData.textScaleFactor;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
  }

  // Helper methods for responsive sizing
  static double hp(double percentage) {
    return blockSizeVertical * percentage;
  }

  static double wp(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  static double safehp(double percentage) {
    return safeBlockVertical * percentage;
  }

  static double safewp(double percentage) {
    return safeBlockHorizontal * percentage;
  }

  // Responsive font size
  static double fontSize(double size) {
    // Base design size (for example, based on iPhone 11)
    const double baseWidth = 375.0;
    // Calculate the ratio and apply it to the font size
    return size * (screenWidth / baseWidth);
  }

  // Responsive padding, margin, etc.
  static EdgeInsets padding({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    return EdgeInsets.only(
      left: wp(left ?? horizontal ?? all ?? 0),
      top: hp(top ?? vertical ?? all ?? 0),
      right: wp(right ?? horizontal ?? all ?? 0),
      bottom: hp(bottom ?? vertical ?? all ?? 0),
    );
  }

  static EdgeInsets safePadding({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? horizontal,
    double? vertical,
    double? all,
  }) {
    return EdgeInsets.only(
      left: safewp(left ?? horizontal ?? all ?? 0),
      top: safehp(top ?? vertical ?? all ?? 0),
      right: safewp(right ?? horizontal ?? all ?? 0),
      bottom: safehp(bottom ?? vertical ?? all ?? 0),
    );
  }

  // Responsive border radius
  static BorderRadius borderRadius(double radius) {
    return BorderRadius.circular(wp(radius));
  }

  static BorderRadiusGeometry customBorderRadius({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    double? all,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(wp(topLeft ?? all ?? 0)),
      topRight: Radius.circular(wp(topRight ?? all ?? 0)),
      bottomLeft: Radius.circular(wp(bottomLeft ?? all ?? 0)),
      bottomRight: Radius.circular(wp(bottomRight ?? all ?? 0)),
    );
  }
}
