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
    String formattedTime = DateFormat('hh:mm a').format(_currentTime);
    List<String> timeParts = formattedTime.split(' ');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16)
          .copyWith(bottom: 10),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
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
                if (_prayerTimes != null) ...[
                  Text(
                    '$_nextPrayer Time | ${_formatTime(_prayerTimes!.timeForPrayer(Prayer.values.firstWhere((p) => p.name.toLowerCase() == _nextPrayer.toLowerCase()))!)}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  // Text(
                  //   'Time Left: ${_timeLeft.inHours}h ${_timeLeft.inMinutes % 60}m',
                  //   style: const TextStyle(color: Colors.white70),
                  // ),
                ] else
                  const Text(
                    'Loading prayer times...',
                    style: TextStyle(color: Colors.white70),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_prayerTimes != null) ...[
                    _buildSunTimeInfo(Icons.wb_sunny_outlined, 'সূর্যোদয়',
                        _formatTime(_prayerTimes!.sunrise)),
                    const SizedBox(height: 3),
                    _buildSunTimeInfo(Icons.nightlight_round, 'সূর্যাস্ত',
                        _formatTime(_prayerTimes!.maghrib)),
                  ],
                ],
              ),
            ),
          ),
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
