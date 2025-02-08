import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:async';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({Key? key}) : super(key: key);

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  late DateTime _currentTime;
  late Timer _timer;
  final String _location = 'Dhaka';
  final DateTime _sunrise = DateTime(2024, 1, 1, 6, 39);
  final DateTime _sunset = DateTime(2024, 1, 1, 17, 46);

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getBengaliDate() {
    // Simplified Bengali date (replace with proper library for accuracy)
    return '২০ মাঘ ১৪২৯';
  }

  String _getArabicDate() {
    // Simplified Arabic date (replace with proper library for accuracy)
    return '৩ শাবান ১৪৪৬';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8), // Reduced padding
      decoration: BoxDecoration(
        color: Color(0xFF00BFA5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Dates
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                DateFormat('EEEE').format(_currentTime),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                DateFormat('d MMMM yyyy').format(_currentTime),
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                _getBengaliDate(),
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
              ),
              Text(
                _getArabicDate(),
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 10),
              ),
            ],
          ),

          // Middle: Time and Location
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('hh:mm a').format(_currentTime),
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 12),
                  SizedBox(width: 2),
                  Text(
                    _location,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          // Right: Sunrise and Sunset
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.wb_sunny_outlined, color: Colors.white, size: 18),
                  SizedBox(width: 2),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'সূর্যোদয়',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(_sunrise),
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.nightlight_round, color: Colors.white, size: 18),
                  SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'সূর্যাস্ত',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(_sunset),
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                  
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}