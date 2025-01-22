import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final englishDate = DateFormat('d MMMM yyyy').format(now);
    final banglaDate = _getBanglaDate(now);
    final hijriDate = _getHijriDate();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16)
          .copyWith(top: 16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    englishDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        banglaDate,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        ' | ',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        hijriDate,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder<String>(
                    future: _getCurrentLocation(),
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            snapshot.data ?? 'Loading...',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'BN',
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 18,
                      ),
                      dropdownColor: const Color(0xFF00BFA5),
                      items: const [
                        DropdownMenuItem(
                          value: 'BN',
                          child: Text(
                            'BN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'EN',
                          child: Text(
                            'EN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (String? value) {
                        // Handle language change
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getBanglaDate(DateTime date) {
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

    return '$banglaDayString ${banglaMonths[banglaMonth]} $banglaYearString বঙ্গাব্দ';
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

    return '$hijriDayString ${hijriMonths[hijri.hMonth - 1]} $hijriYearString হিজরি';
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
        return '${place.locality}, ${place.subAdministrativeArea}';
      }
    } catch (e) {
      return 'Error getting location';
    }

    return 'Unknown location';
  }
}
