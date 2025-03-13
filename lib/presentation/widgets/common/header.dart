import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Utility class for responsive sizing
class ResponsiveSize {
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
  }
}

// Extension methods for responsive sizing
extension SizeExtension on num {
  double get h => this * ResponsiveSize.blockSizeVertical;
  double get w => this * ResponsiveSize.blockSizeHorizontal;
  double get sp => this * ResponsiveSize.blockSizeHorizontal * (ResponsiveSize.textScaleFactor >= 1.0 ? 1.0 : ResponsiveSize.textScaleFactor);
  double get r => this * (ResponsiveSize.blockSizeHorizontal + ResponsiveSize.blockSizeVertical) / 2;
}

class ResponsiveHeader extends StatelessWidget {
  final DateTime selectedDate;
  final bool isCalendarVisible;
  final VoidCallback onToggleCalendar;

  const ResponsiveHeader({
    required this.selectedDate,
    required this.isCalendarVisible,
    required this.onToggleCalendar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context);

    return Padding(
      padding: EdgeInsets.all(4.w), // 4% of screen width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE, d MMMM yyyy', 'bn').format(selectedDate),
            style: TextStyle(
              fontSize: 4.w, // 4% of screen width
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              isCalendarVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: 7.w, // 7% of screen width
            ),
            onPressed: onToggleCalendar,
          ),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color textColor;
  final EdgeInsets? padding;
  final bool isAnimated;
  final Animation<double>? animation;

  const AppHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.textColor = Colors.black87,
    this.padding,
    this.isAnimated = false,
    this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize responsive sizing
    ResponsiveSize().init(context);
    
    final headerWidget = Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
              height: 1.2,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 0.5.h),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12.sp,
                color: textColor.withOpacity(0.7),
                height: 1.2,
              ),
            ),
          ],
        ],
      ),
    );

    if (isAnimated && animation != null) {
      return FadeTransition(
        opacity: animation!,
        child: headerWidget,
      );
    }

    return headerWidget;
  }
}

// A section header for content sections
class SectionHeader extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final EdgeInsets? padding;

  const SectionHeader({
    Key? key,
    required this.title,
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.textColor = Colors.black87,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context);
    
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize ?? 14.sp,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    );
  }
}

// A responsive spacer that adapts to screen size
class ResponsiveSpacer extends StatelessWidget {
  final double height;
  final double width;

  const ResponsiveSpacer({
    Key? key,
    this.height = 0,
    this.width = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context);
    return SizedBox(
      height: height.h,
      width: width.w,
    );
  }
}