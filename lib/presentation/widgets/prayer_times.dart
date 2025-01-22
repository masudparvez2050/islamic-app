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
    if (now.isBefore(_prayerTimes!.dhuhr)) return _prayerTimes!.dhuhr;
    if (now.isBefore(_prayerTimes!.asr)) return _prayerTimes!.asr;
    if (now.isBefore(_prayerTimes!.maghrib)) return _prayerTimes!.maghrib;
    if (now.isBefore(_prayerTimes!.isha)) return _prayerTimes!.isha;

    // If past isha, calculate tomorrow's fajr
    if (_currentPosition != null) {
      final coordinates =
          Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      final params = CalculationMethod.karachi.getParameters();
      final date =
          DateComponents.from(DateTime.now().add(const Duration(days: 1)));
      final tomorrowPrayers = PrayerTimes(coordinates, date, params);
      return tomorrowPrayers.fajr;
    }
    return null;
  }

  String _getCurrentPrayer() {
    if (_prayerTimes == null) return '';
    final now = DateTime.now();

    if (now.isBefore(_prayerTimes!.sunrise)) return 'Fajr';
    if (now.isBefore(_prayerTimes!.dhuhr)) return 'Sunrise';
    if (now.isBefore(_prayerTimes!.asr)) return 'Dhuhr';
    if (now.isBefore(_prayerTimes!.maghrib)) return 'Asr';
    if (now.isBefore(_prayerTimes!.isha)) return 'Maghrib';
    return 'Isha';
  }

  DateTime _getPrayerEndTime(String prayer) {
    if (_prayerTimes == null) return DateTime.now();

    switch (prayer) {
      case 'Fajr':
        return _prayerTimes!.sunrise;
      case 'Dhuhr':
        return _prayerTimes!.asr;
      case 'Asr':
        return _prayerTimes!.maghrib;
      case 'Maghrib':
        return _prayerTimes!.isha;
      case 'Isha':
        // Next day's fajr
        if (_currentPosition != null) {
          final coordinates = Coordinates(
              _currentPosition!.latitude, _currentPosition!.longitude);
          final params = CalculationMethod.karachi.getParameters();
          final date =
              DateComponents.from(DateTime.now().add(const Duration(days: 1)));
          final tomorrowPrayers = PrayerTimes(coordinates, date, params);
          return tomorrowPrayers.fajr;
        }
        return DateTime.now();
      default:
        return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Existing prayer time cards
        Row(
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
        ),

        // New prayer status section
        const SizedBox(height: 20),
        Text(
          'এখন চলছে',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        // Current prayer time range
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${_getCurrentPrayer()} | ${DateFormat('hh:mm a').format(_prayerTimes!.fajr)} - '
            '${DateFormat('hh:mm a').format(_getPrayerEndTime(_getCurrentPrayer()))}',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),

        // Time remaining
        Text(
          'সময় বাকি: ${_getTimeRemaining()}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),

        // Schedule header
        // const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'স্থায়ী সময়সূচী',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'পরবর্তী ওয়াক্ত',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
}
