import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final double borderRadius;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation = 1.0,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    
    // Calculate responsive padding based on screen width
    final double defaultPadding = screenSize.width * 0.04; // 4% of screen width
    
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: Material(
        color: Colors.white,
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? EdgeInsets.all(defaultPadding),
          child: child,
        ),
      ),
    );
  }
}
