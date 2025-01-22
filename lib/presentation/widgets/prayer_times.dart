import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimesWidget extends StatefulWidget {
  const PrayerTimesWidget({Key? key}) : super(key: key);

  @override
  _PrayerTimesWidgetState createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget> {
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;

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
      final coordinates =
          Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      _prayerTimes = PrayerTimes.today(coordinates, params);
      setState(() {});
    }
  }

  Widget _buildPrayerTimeCard(String time, String name, IconData icon) {
    // Builds a prayer time card
    return Container(
      width: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Display loading indicators or prayer times
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPrayerTimeCard(
            _prayerTimes?.fajr != null
                ? DateFormat('hh:mm a').format(_prayerTimes!.fajr)
                : '--:--',
            'Fajr',
            Icons.wb_twilight),
        _buildPrayerTimeCard(
            _prayerTimes?.dhuhr != null
                ? DateFormat('hh:mm a').format(_prayerTimes!.dhuhr)
                : '--:--',
            'Dhuhr',
            Icons.wb_sunny),
        _buildPrayerTimeCard(
            _prayerTimes?.asr != null
                ? DateFormat('hh:mm a').format(_prayerTimes!.asr)
                : '--:--',
            'Asr',
            Icons.wb_cloudy),
        _buildPrayerTimeCard(
            _prayerTimes?.maghrib != null
                ? DateFormat('hh:mm a').format(_prayerTimes!.maghrib)
                : '--:--',
            'Maghrib',
            Icons.nights_stay),
        _buildPrayerTimeCard(
            _prayerTimes?.isha != null
                ? DateFormat('hh:mm a').format(_prayerTimes!.isha)
                : '--:--',
            'Isha',
            Icons.star),
      ],
    );
  }
}
