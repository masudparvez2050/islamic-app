import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class RamadanInfo extends StatefulWidget {
  const RamadanInfo({Key? key}) : super(key: key);

  @override
  _RamadanInfoState createState() => _RamadanInfoState();
}

class _RamadanInfoState extends State<RamadanInfo> {
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  String sheriTime = '--:--';
  String iftarTime = '--:--';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
      final coordinates = Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      final now = DateTime.now();
      _prayerTimes = PrayerTimes.today(coordinates, params);
      setState(() {
        sheriTime = _formatTime(_prayerTimes!.fajr);
        iftarTime = _formatTime(_prayerTimes!.maghrib);
      });
    }
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 117, 121).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'পরবর্তী সময়সূচী সেহরি ও ইফতার ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeInfo('সেহরি', sheriTime, 'শেষ'),
              _buildTimeInfo('ইফতার', iftarTime, 'শুরু'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String title, String time, String label) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
