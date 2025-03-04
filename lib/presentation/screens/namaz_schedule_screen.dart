import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/add_2.dart';
import 'package:adhan/adhan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:religion/presentation/widgets/common/header.dart';

class NamazScheduleScreen extends StatefulWidget {
  const NamazScheduleScreen({Key? key}) : super(key: key);

  @override
  _NamazScheduleScreenState createState() => _NamazScheduleScreenState();
}

class _NamazScheduleScreenState extends State<NamazScheduleScreen> {
  late DateTime _selectedDate;
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  bool _isCalendarVisible = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _useDefaultLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _useDefaultLocation();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _updatePrayerTimes();
      });
    } catch (e) {
      print('Error getting location: $e');
      _useDefaultLocation();
    }
  }

  void _useDefaultLocation() {
    setState(() {
      _currentPosition = Position(
        latitude: 23.8103,
        longitude: 90.4125,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      _updatePrayerTimes();
    });
  }

  void _updatePrayerTimes() {
    if (_currentPosition != null) {
      final coordinates = Coordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      final dateComponents = DateComponents.from(_selectedDate);
      setState(() {
        _prayerTimes = PrayerTimes(coordinates, dateComponents, params);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'নামাজের সময়সূচী',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.07), // 7% of screen height
            child: Column(
              children: [
                ResponsiveHeader(
                  selectedDate: _selectedDate,
                  isCalendarVisible: _isCalendarVisible,
                  onToggleCalendar: () {
                    setState(() {
                      _isCalendarVisible = !_isCalendarVisible;
                    });
                  },
                ),
                if (_isCalendarVisible) _buildCalendar(),
                Expanded(
                  child: _prayerTimes != null
                      ? _buildPrayerTimesList()
                      : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          const Advertisement2(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final screenWidth = MediaQuery.of(context).size.width;

    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _updatePrayerTimes();
          _isCalendarVisible = false;
        });
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: const Color(0xFF00BFA5),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: const Color(0xFF00BFA5).withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(fontSize: screenWidth * 0.04), // 4% of screen width
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
      ),
    );
  }

  Widget _buildPrayerTimesList() {
    final prayerTimes = [
      {'name': 'ফজর', 'startTime': _prayerTimes!.fajr, 'endTime': _prayerTimes!.sunrise, 'icon': Icons.wb_twilight},
      {
        'name': 'নিষিদ্ধ সময়',
        'startTime': _prayerTimes!.sunrise.add(const Duration(minutes: 1)), // Start 1 minute after sunrise
        'endTime': _getIshraqTime(),
        'icon': Icons.block
      },
      {
        'name': 'ইশরাক',
        'startTime': _getIshraqTime().add(const Duration(minutes: 1)),
        'endTime': _getChashtStartTime(),
        'icon': Icons.wb_sunny_outlined
      },
      {
        'name': 'চাশত',
        'startTime': _getChashtStartTime().add(const Duration(minutes: 1)),
        'endTime': _getZawalStartTime(),
        'icon': Icons.wb_sunny_outlined
      },
      {
        'name': 'নিষিদ্ধ সময়',
        'startTime': _getZawalStartTime().add(const Duration(minutes: 1)),
        'endTime': _prayerTimes!.dhuhr, // Start 1 minute after Dhuhr
        'icon': Icons.block
      },
      {
        'name': DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর',
        'startTime': _prayerTimes!.dhuhr.add(const Duration(minutes: 1)), // Start 1 minute after previous end
        'endTime': _prayerTimes!.asr, // Asr end time minus 10 minutes
        'icon': Icons.wb_sunny
      },
      {
        'name': 'আসর',
        'startTime': _prayerTimes!.asr.add(const Duration(minutes: 1)), // Start 1 minute after previous end
        'endTime': _getSunsetForbiddenStart().subtract(const Duration(minutes: 10)),
        'icon': Icons.wb_cloudy
      },
      {
        'name': 'নিষিদ্ধ সময়',
        'startTime': _getSunsetForbiddenStart().subtract(const Duration(minutes: 10)).add(const Duration(minutes: 1)),
        'endTime': _prayerTimes!.maghrib, // Start 1 minute after Maghrib
        'icon': Icons.block
      },
      {
        'name': 'মাগরিব',
        'startTime': _prayerTimes!.maghrib.add(const Duration(minutes: 1)), // Start 1 minute after previous end
        'endTime': _prayerTimes!.isha,
        'icon': Icons.nights_stay
      },
      {
        'name': 'ইশা',
        'startTime': _prayerTimes!.isha.add(const Duration(minutes: 1)), // Start 1 minute after previous end
        'endTime': _getNextDayFajr(),
        'icon': Icons.star
      },
      {
        'name': 'তাহাজ্জুদ',
        'startTime': _getTahajjudTime(),
        'endTime': _prayerTimes!.fajr.subtract(const Duration(minutes: 1)),
        'icon': Icons.nightlight_round
      },
    ];

    return AnimatedList(
      key: _listKey,
      initialItemCount: prayerTimes.length,
      itemBuilder: (context, index, animation) {
        final prayer = prayerTimes[index];
        final isActivePrayer =
            _isActivePrayer(prayer['startTime'] as DateTime, prayer['endTime'] as DateTime);

        return _buildAnimatedPrayerTimeItem(
          animation,
          prayer['name'] as String,
          prayer['startTime'] as DateTime,
          prayer['endTime'] as DateTime,
          prayer['icon'] as IconData,
          isActivePrayer,
        );
      },
    );
  }

  Widget _buildAnimatedPrayerTimeItem(
    Animation<double> animation,
    String prayerName,
    DateTime startTime,
    DateTime endTime,
    IconData icon,
    bool isActivePrayer,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final timeLeft = _getTimeLeft(endTime);

    return FadeTransition(
      opacity: animation,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: screenWidth * 0.005, horizontal: screenWidth * 0.04), // 0.5% and 4%
        color: isActivePrayer
            ? const Color.fromARGB(255, 52, 151, 141)
            : const Color.fromARGB(255, 7, 107, 165).withOpacity(0.2),
        child: ListTile(
          leading: Icon(icon, color: Colors.white, size: screenWidth * 0.07), // 7% of screen width
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prayerName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.045, // 4.5% of screen width
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'শুরু: ${DateFormat.jm('bn').format(startTime)}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% of screen width
                      color: isActivePrayer ? Colors.white : Colors.white,
                    ),
                  ),
                  Text(
                    'শেষ: ${DateFormat.jm('bn').format(endTime)}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% of screen width
                      color: isActivePrayer ? Colors.white : Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _getTahajjudTime() {
    final isha = _prayerTimes!.isha;
    final fajr = _prayerTimes!.fajr.add(const Duration(days: 1));
    final midpoint = isha.add(fajr.difference(isha) ~/ 2);
    return midpoint;
  }

  DateTime _getIshraqTime() {
    return _prayerTimes!.sunrise.add(const Duration(minutes: 20));
  }

  DateTime _getChashtStartTime() {
    return _prayerTimes!.sunrise.add(const Duration(minutes: 110));
  }

  DateTime _getZawalStartTime() {
    return _prayerTimes!.dhuhr.subtract(const Duration(minutes: 15));
  }

  DateTime _getSunsetForbiddenStart() {
    return _prayerTimes!.maghrib.subtract(const Duration(minutes: 5));
  }

  DateTime _getNextDayFajr() {
    if (_currentPosition != null) {
      final tomorrow = _selectedDate.add(const Duration(days: 1));
      final dateComponents = DateComponents.from(tomorrow);
      final coordinates = Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      final tomorrowPrayerTimes = PrayerTimes(coordinates, dateComponents, _prayerTimes!.calculationParameters);
      return tomorrowPrayerTimes.fajr;
    }
    return DateTime.now();
  }

  bool _isActivePrayer(DateTime startTime, DateTime endTime) {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  String _getTimeLeft(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '$hours hours $minutes minutes';
  }
}