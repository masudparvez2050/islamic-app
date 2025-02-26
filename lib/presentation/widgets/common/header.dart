import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE, d MMMM yyyy', 'bn').format(selectedDate),
            style: TextStyle(
              fontSize: screenWidth * 0.04, // 4% of screen width
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              isCalendarVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: screenWidth * 0.07, // 7% of screen width
            ),
            onPressed: onToggleCalendar,
          ),
        ],
      ),
    );
  }
}