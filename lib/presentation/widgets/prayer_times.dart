import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class PrayerTimesWidget extends StatefulWidget {
  const PrayerTimesWidget({Key? key}) : super(key: key);

  @override
  _PrayerTimesWidgetState createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget> {
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  Timer? _timer;
  bool _isLoading = true;
 

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
      _updatePrayerTimes(); // Use default location
    }
  }

  void _updatePrayerTimes() {
    final coordinates = Coordinates(
      _currentPosition?.latitude ?? 23.8103,
      _currentPosition?.longitude ?? 90.4125,
    );
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final newPrayerTimes = PrayerTimes.today(coordinates, params);

    setState(() {
      _prayerTimes = newPrayerTimes;
      _isLoading = false;
    });
  }

  String _getTimeRemaining() {
    if (_prayerTimes == null) return '--:--';

    final now = DateTime.now();
    final nextPrayerTime = _getNextPrayerTime();
    if (nextPrayerTime == null) return '--:--';

    final difference = nextPrayerTime.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '$hours ঘণ্টা $minutes মিনিট';
  }

  DateTime? _getNextPrayerTime() {
    if (_prayerTimes == null) return null;
    final now = DateTime.now();

    if (now.isBefore(_prayerTimes!.fajr)) return _prayerTimes!.fajr;
    if (now.isBefore(_prayerTimes!.sunrise)) return _prayerTimes!.sunrise;
    if (now.isBefore(_getIshraqTime())) return _getIshraqTime();
    if (now.isBefore(_prayerTimes!.dhuhr)) return _prayerTimes!.dhuhr;
    if (now.isBefore(_prayerTimes!.asr)) return _prayerTimes!.asr;
    if (now.isBefore(_prayerTimes!.maghrib)) return _prayerTimes!.maghrib;
    if (now.isBefore(_prayerTimes!.isha)) return _prayerTimes!.isha;
    if (now.isBefore(_getTahajjudTime())) return _getTahajjudTime();

    // If past tahajjud, calculate tomorrow's fajr
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowPrayers = PrayerTimes.today(
      Coordinates(_currentPosition?.latitude ?? 23.8103,
          _currentPosition?.longitude ?? 90.4125),
      CalculationMethod.karachi.getParameters(),
    );
    return tomorrowPrayers.fajr;
  }

  String _getCurrentPrayer() {
    if (_prayerTimes == null) return '';
    final now = DateTime.now();

    if (now.isBefore(_prayerTimes!.fajr)) return 'তাহাজ্জুদ';
    if (now.isBefore(_prayerTimes!.sunrise)) return 'ফজর';
    if (now.isBefore(_getIshraqTime())) return 'সূর্যোদয়';
    if (now.isBefore(_prayerTimes!.dhuhr)) return 'ইশরাক';
    if (now.isBefore(_prayerTimes!.asr)) {
      return DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর';
    }
    if (now.isBefore(_prayerTimes!.maghrib)) return 'আসর';
    if (now.isBefore(_prayerTimes!.isha)) return 'মাগরিব';
    if (now.isBefore(_getTahajjudTime())) return 'ইশা';
    return 'তাহাজ্জুদ';
  }

  IconData _getPrayerIcon(String prayerName) {
    final prayerTimes = [
      {
        'name': 'ফজর',
        'startTime': _prayerTimes?.fajr,
        'endTime': _prayerTimes?.sunrise,
        'icon': Icons.wb_twilight
      },
      {
        'name': 'সূর্যোদয়',
        'startTime': _prayerTimes?.sunrise,
        'endTime': _getIshraqTime(),
        'icon': Icons.wb_sunny
      },
      {
        'name': 'ইশরাক',
        'startTime': _getIshraqTime(),
        'endTime': _prayerTimes?.dhuhr,
        'icon': Icons.wb_sunny_outlined
      },
      {
        'name': DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর',
        'startTime': _prayerTimes?.dhuhr,
        'endTime': _prayerTimes?.asr,
        'icon': Icons.wb_sunny
      },
      {
        'name': 'আসর',
        'startTime': _prayerTimes?.asr,
        'endTime': _prayerTimes?.maghrib,
        'icon': Icons.wb_cloudy
      },
      {
        'name': 'মাগরিব',
        'startTime': _prayerTimes?.maghrib,
        'endTime': _prayerTimes?.isha,
        'icon': Icons.nights_stay
      },
      {
        'name': 'ইশা',
        'startTime': _prayerTimes?.isha,
        'endTime': _getNextDayFajr(),
        'icon': Icons.star
      },
      {
        'name': 'তাহাজ্জুদ',
        'startTime': _getTahajjudTime(),
        'endTime': _prayerTimes?.fajr,
        'icon': Icons.nightlight_round
      },
    ];

    final prayer = prayerTimes.firstWhere(
      (p) => p['name'] == prayerName,
      orElse: () => {'icon': Icons.error}, // Default icon if not found
    );
    return prayer['icon'] as IconData;
  }

  DateTime _getPrayerStartTime(String prayer) {
    if (_prayerTimes == null) return DateTime.now();
    final jumma = DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর';

    switch (prayer) {
      case 'তাহাজ্জুদ':
        return _getTahajjudTime();
      case 'ফজর':
        return _prayerTimes!.fajr;
      case 'সূর্যোদয়':
        return _prayerTimes!.sunrise;
      case 'ইশরাক':
        return _getIshraqTime();
      case "জুম'আ" || 'জোহর':
        return _prayerTimes!.dhuhr;
      case 'আসর':
        return _prayerTimes!.asr;
      case 'মাগরিব':
        return _prayerTimes!.maghrib;
      case 'ইশা':
        return _prayerTimes!.isha;
      default:
        return DateTime.now();
    }
  }

  DateTime _getPrayerEndTime(String prayer) {
    if (_prayerTimes == null) return DateTime.now();

    switch (prayer) {
      case 'তাহাজ্জুদ':
        return _prayerTimes!.fajr;
      case 'ফজর':
        return _prayerTimes!.sunrise;
      case 'সূর্যোদয়':
        return _getIshraqTime();
      case 'ইশরাক':
        return _prayerTimes!.dhuhr;
      case "জুম'আ" || 'জোহর':
        return _prayerTimes!.asr;
      case 'আসর':
        return _prayerTimes!.maghrib;
      case 'মাগরিব':
        return _prayerTimes!.isha;
      case 'ইশা':
        return _getTahajjudTime();
      default:
        return DateTime.now();
    }
  }

  DateTime _getTahajjudTime() {
    if (_prayerTimes == null) return DateTime.now();

    final isha = _prayerTimes!.isha;
    final fajr = _prayerTimes!.fajr.add(const Duration(days: 1));
    final midpoint = isha.add(fajr.difference(isha) ~/ 2);
    return midpoint;
  }

  DateTime _getIshraqTime() {
    if (_prayerTimes == null) return DateTime.now();
    return _prayerTimes!.sunrise.add(const Duration(minutes: 20));
  }

  DateTime _getNextDayFajr() {
    if (_prayerTimes == null) return DateTime.now();

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowPrayers = PrayerTimes.today(
      Coordinates(_currentPosition?.latitude ?? 23.8103,
          _currentPosition?.longitude ?? 90.4125),
      CalculationMethod.karachi.getParameters(),
    );
    return tomorrowPrayers.fajr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPrayerTimeCard(_prayerTimes?.fajr, 'ফজর', Icons.wb_twilight),
            _buildPrayerTimeCard(
                _prayerTimes?.dhuhr,
                DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর',
                Icons.wb_sunny),
            _buildPrayerTimeCard(_prayerTimes?.asr, 'আসর', Icons.wb_cloudy),
            _buildPrayerTimeCard(
                _prayerTimes?.maghrib, 'মাগরিব', Icons.nights_stay),
            _buildPrayerTimeCard(_prayerTimes?.isha, 'ইশা', Icons.star),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Keeps both sections evenly spaced
            children: [
              // Left Section - Current Prayer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Center the column contents
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center all items inside the Row
                      children: [
                        
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to start
                          children: [
                            Text(
                              'এখন চলছে',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start, // Keep text aligned to start
                            ),
                            Row(
  mainAxisAlignment: MainAxisAlignment.start, // Align to the start
  children: [
    Icon(
      _getPrayerIcon(_getCurrentPrayer()),
      color: Colors.white,
      size: 24,
    ),
    
    Text(
      '${_getCurrentPrayer()}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    ),
  ],
),
                            Text(
                              '${_formatTime(_getPrayerStartTime(_getCurrentPrayer()))} - '
                              '${_formatTime(_getPrayerEndTime(_getCurrentPrayer()))}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'সময় বাকি: ${_getTimeRemaining()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Vertical Divider
              Container(
                height: 80,
                width: 1,
                color: Colors.white.withOpacity(0.3),
                margin: EdgeInsets.symmetric(horizontal: 20),
              ),
              // Right Section - Next Schedule
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'পরবর্তী সময়সূচী',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'সেহরি ও ইফতার',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'সেহরি শেষ : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${_formatTime(_prayerTimes?.fajr)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'ইফতার শুরু :  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${_formatTime(_prayerTimes?.maghrib)}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerTimeCard(DateTime? time, String name, IconData icon) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final cardWidth =
        screenWidth / 5 - 8; // 1/5th of the width with padding adjustment

    // Determine if this card represents the active prayer
    final isActivePrayer = name == _getCurrentPrayer();

    return Container(
      width: cardWidth,
      margin:
          const EdgeInsets.symmetric(horizontal: 1), // Adjust horizontal margin
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isActivePrayer
            ? const Color.fromARGB(255, 255, 255, 255)
                .withOpacity(0.8) // Active card color
            : Colors.white.withOpacity(0.2), // Default card color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActivePrayer
                ? Color.fromARGB(255, 0, 190, 165)
                : Colors.white,
            size: 24,
          ),
          const SizedBox(height: 1),
          Text(
            name,
            style: TextStyle(
              color: isActivePrayer
                  ? Color.fromARGB(255, 0, 190, 165)
                  : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 1),
          Text(
            _formatTime(time),
            style: TextStyle(
              color: isActivePrayer
                  ? Color.fromARGB(255, 0, 190, 165)
                  : Colors.white,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '--:--';
    return DateFormat('hh:mm a').format(time);
  }
}