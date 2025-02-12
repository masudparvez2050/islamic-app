import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:adhan/adhan.dart';
import 'dart:async';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({Key? key}) : super(key: key);

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  late DateTime _currentTime;
  late Timer _timer;
  PrayerTimes? _prayerTimes;
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

  

  @override
  Widget build(BuildContext context) {
  final now = DateTime.now();
  final banglaDate = _getBanglaDateWithDay(now);
  final hijriDate = _getHijriDate();
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
                DateFormat('EEEE', 'bn').format(_currentTime),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                DateFormat('d MMMM yyyy', 'bn').format(_currentTime),
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
               banglaDate,
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
              ),
              Text(
                hijriDate,
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 10),
              ),
            ],
          ),

          // Middle: Time and Location
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  DateFormat('hh:mm', 'bn').format(_currentTime),
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4), // Add some spacing between time and AM/PM
                  Text(
                  DateFormat('a').format(_currentTime),
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
                ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                
                  
                  FutureBuilder<String>(
                  future: _getCurrentLocation(),
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          snapshot.data ?? 'Loading...',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  },
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
                        DateFormat('hh:mm a', 'bn').format(_sunrise),
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
                        DateFormat('hh:mm a', 'bn').format(_sunset),
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

    String _getBanglaDateWithDay(DateTime date) {
    final banglaDays = [
      'শনিবার',
      'রবিবার',
      'সোমবার',
      'মঙ্গলবার',
      'বুধবার',
      'বৃহস্পতিবার',
      'শুক্রবার'
    ];

    final banglaMonths = [
      'বৈশাখ',
      'জ্যৈষ্ঠ',
      'আষাঢ়',
      'শ্রাবণ',
      'ভাদ্র',
      'আশ্বিন',
      'কার্তিক',
      'অগ্রহায়ণ',
      'পৌষ',
      'মাঘ',
      'ফাল্গুন',
      'চৈত্র'
    ];

    final banglaNumbers = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    final dayName = banglaDays[date.weekday % 7]; // Map to Bangla day name
    int banglaYear = date.year - 593;
    if (date.month < 4 || (date.month == 4 && date.day < 14)) {
      banglaYear -= 1;
    }

    int banglaMonth;
    int banglaDay;

    if (date.month == 4 && date.day >= 14) {
      banglaMonth = 0;
      banglaDay = date.day - 13;
    } else if (date.month == 5 && date.day <= 14) {
      banglaMonth = 0;
      banglaDay = date.day + 17;
    } else if (date.month == 5 && date.day > 14) {
      banglaMonth = 1;
      banglaDay = date.day - 14;
    } else if (date.month == 6 && date.day <= 14) {
      banglaMonth = 1;
      banglaDay = date.day + 17;
    } else if (date.month == 6 && date.day > 14) {
      banglaMonth = 2;
      banglaDay = date.day - 14;
    } else if (date.month == 7 && date.day <= 15) {
      banglaMonth = 2;
      banglaDay = date.day + 16;
    } else if (date.month == 7 && date.day > 15) {
      banglaMonth = 3;
      banglaDay = date.day - 15;
    } else if (date.month == 8 && date.day <= 15) {
      banglaMonth = 3;
      banglaDay = date.day + 16;
    } else if (date.month == 8 && date.day > 15) {
      banglaMonth = 4;
      banglaDay = date.day - 15;
    } else if (date.month == 9 && date.day <= 15) {
      banglaMonth = 4;
      banglaDay = date.day + 16;
    } else if (date.month == 9 && date.day > 15) {
      banglaMonth = 5;
      banglaDay = date.day - 15;
    } else if (date.month == 10 && date.day <= 15) {
      banglaMonth = 5;
      banglaDay = date.day + 15;
    } else if (date.month == 10 && date.day > 15) {
      banglaMonth = 6;
      banglaDay = date.day - 15;
    } else if (date.month == 11 && date.day <= 14) {
      banglaMonth = 6;
      banglaDay = date.day + 16;
    } else if (date.month == 11 && date.day > 14) {
      banglaMonth = 7;
      banglaDay = date.day - 14;
    } else if (date.month == 12 && date.day <= 14) {
      banglaMonth = 7;
      banglaDay = date.day + 16;
    } else if (date.month == 12 && date.day > 14) {
      banglaMonth = 8;
      banglaDay = date.day - 14;
    } else if (date.month == 1 && date.day <= 13) {
      banglaMonth = 8;
      banglaDay = date.day + 17;
    } else if (date.month == 1 && date.day > 13) {
      banglaMonth = 9;
      banglaDay = date.day - 13;
    } else if (date.month == 2 && date.day <= 12) {
      banglaMonth = 9;
      banglaDay = date.day + 18;
    } else if (date.month == 2 && date.day > 12) {
      banglaMonth = 10;
      banglaDay = date.day - 12;
    } else if (date.month == 3 && date.day <= 14) {
      banglaMonth = 10;
      banglaDay = date.day + 16;
    } else {
      banglaMonth = 11;
      banglaDay = date.day - 14;
    }

    String banglaYearString = banglaYear
        .toString()
        .split('')
        .map((digit) => banglaNumbers[int.parse(digit)])
        .join('');
    String banglaDayString = banglaDay
        .toString()
        .split('')
        .map((digit) => banglaNumbers[int.parse(digit)])
        .join('');

    return '$banglaDayString ${banglaMonths[banglaMonth]} $banglaYearString';
  }

  String _getHijriDate() {
    final hijri = HijriCalendar.now();
    final hijriMonths = [
      'মুহাররম',
      'সফর',
      'রবিউল আউয়াল',
      'রবিউস সানি',
      'জমাদিউল আউয়াল',
      'জমাদিউস সানি',
      'রজব',
      'শাবান',
      'রমজান',
      'শাওয়াল',
      'জিলক্বদ',
      'জিলহজ্জ'
    ];
    final banglaNumbers = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    String hijriDayString = hijri.hDay
        .toString()
        .split('')
        .map((digit) => banglaNumbers[int.parse(digit)])
        .join('');
    String hijriYearString = hijri.hYear
        .toString()
        .split('')
        .map((digit) => banglaNumbers[int.parse(digit)])
        .join('');

    return '$hijriDayString ${hijriMonths[hijri.hMonth - 1]} $hijriYearString';
  }

 

  Future<String> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied.';
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}';
      }
    } catch (e) {
      return 'Error getting location';
    }

    return 'Unknown location';
  }
}