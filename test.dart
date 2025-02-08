// import 'package:flutter/material.dart';
// import 'package:religion/presentation/screens/home_screen.dart';
// import 'package:religion/presentation/screens/namaz_schedule_screen.dart';
// import 'package:religion/presentation/screens/quran_screen.dart';
// import 'package:religion/presentation/screens/ramadan_screen.dart';
// import 'package:religion/presentation/screens/settings_screen.dart';
// import 'package:religion/presentation/widgets/features.dart';

// class BottomNavBar extends StatelessWidget {
//   const BottomNavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 0,
//       right: 0,
//       bottom: 0,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
             
//               blurRadius: 10, color: Colors.black.withOpacity(0.1),
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildNavItem(context, Icons.home, 'Home', const HomeScreen()),
//             _buildNavItem(context, Icons.calendar_today, 'Namaz',
//                 const NamazScheduleScreen()),
//             _buildAllFeaturesButton(context),
//             _buildNavItem(
//                 context, Icons.menu_book, 'Quran', const QuranScreen()),
//             _buildNavItem(
//                 context, Icons.star, 'Ramadan', const RamadanScreen()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(
//       BuildContext context, IconData icon, String label, Widget screen) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => screen),
//         );
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: const Color(0xFF00BFA5)),
//           Text(
//             label,
//             style: const TextStyle(color: Color(0xFF00BFA5), fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAllFeaturesButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showAllFeaturesModal(context),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: const Color(0xFF00BFA5),
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF00BFA5).withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: const Icon(
//           Icons.grid_view,
//           color: Colors.white,
//           size: 28,
//         ),
//       ),
//     );
//   }

//   void _showAllFeaturesModal(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       pageBuilder: (BuildContext buildContext, Animation<double> animation,
//           Animation<double> secondaryAnimation) {
//         return const AllFeaturesModal();
//       },
//       barrierDismissible: true,
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: const Duration(milliseconds: 200),
//       transitionBuilder: (context, animation, secondaryAnimation, child) {
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0, 1),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final englishDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    final banglaDate = _getBanglaDateWithDay(now);
    final hijriDate = _getHijriDate();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16)
          .copyWith(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 14,
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
                const SizedBox(height: 16),
              ],
            ),
          ),
          const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 24,
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
        return '${place.locality}, ${place.subAdministrativeArea}';
      }
    } catch (e) {
      return 'Error getting location';
    }

    return 'Unknown location';
  }
}




 
    // Text(
    //   'এখন চলছে',
    //   style: TextStyle(
    //     color: Colors.white,
    //     fontSize: 14,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   textAlign: TextAlign.center,
    // ),
    // Container(
    //   margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
    //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Colors.white.withOpacity(0.3)),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: Text(
    //     '${_getCurrentPrayer()} | ${_formatTime(_getPrayerStartTime(_getCurrentPrayer()))} - '
    //     '${_formatTime(_getPrayerEndTime(_getCurrentPrayer()))}',
    //     style: TextStyle(color: Colors.white, fontSize: 16),
    //     textAlign: TextAlign.center,
    //   ),
    // ),
    // Text(
    //   'সময় বাকি: ${_getTimeRemaining()}',
    //   style: TextStyle(
    //     color: Colors.white,
    //     fontSize: 14,
    //   ),
    //   textAlign: TextAlign.center,
    // ),



    import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key});

  @override
  _TimeDisplayState createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  late Timer _timer;
  late DateTime _currentTime;
  PrayerTimes? _prayerTimes;
  String _nextPrayer = '';
  Duration _timeLeft = Duration.zero;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _getCurrentLocation();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        _updateNextPrayer();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _updatePrayerTimes();
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _updatePrayerTimes() {
    if (_currentPosition != null) {
      final coordinates =
          Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      _prayerTimes = PrayerTimes.today(coordinates, params);
      _updateNextPrayer();
    }
  }

  void _updateNextPrayer() {
    if (_prayerTimes == null) return;

    final now = DateTime.now();
    final prayers = [
      {'name': 'Fajr', 'time': _prayerTimes!.fajr},
      {'name': 'Sunrise', 'time': _prayerTimes!.sunrise},
      {'name': 'Dhuhr', 'time': _prayerTimes!.dhuhr},
      {'name': 'Asr', 'time': _prayerTimes!.asr},
      {'name': 'Maghrib', 'time': _prayerTimes!.maghrib},
      {'name': 'Isha', 'time': _prayerTimes!.isha},
    ];

    for (var prayer in prayers) {
      if ((prayer['time'] as DateTime).isAfter(now)) {
        _nextPrayer = prayer['name'] as String;
        _timeLeft = (prayer['time'] as DateTime).difference(now);
        return;
      }
    }

    // If all prayers have passed, set next prayer to tomorrow's Fajr
    _nextPrayer = 'Fajr';

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowPrayers = PrayerTimes.today(
      Coordinates(_currentPosition!.latitude, _currentPosition!.longitude),
      CalculationMethod.karachi.getParameters(),
    );
    _timeLeft = tomorrowPrayers.fajr.difference(now);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateFormat('EEEE').format(now);
    String formattedTime = DateFormat('hh:mm a').format(_currentTime);
    List<String> timeParts = formattedTime.split(' ');
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4)
          .copyWith(bottom: 5),
      height: 100, // Explicit height for container
      child: Row(
        children: [
          // Time display in center
          Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: timeParts[0], // Time part (e.g., 06:52)
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' ${timeParts[1]}', // AM/PM part
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Sun time info on right
          if (_prayerTimes != null) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildSunTimeInfo(Icons.wb_sunny_outlined, 'সূর্যোদয়',
                    _formatTime(_prayerTimes!.sunrise)),
                const SizedBox(height: 3),
                _buildSunTimeInfo(Icons.nightlight_round, 'সূর্যাস্ত',
                    _formatTime(_prayerTimes!.maghrib)),
              ],
            ),
            const SizedBox(width: 16),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  Widget _buildSunTimeInfo(IconData icon, String label, String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 16,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
