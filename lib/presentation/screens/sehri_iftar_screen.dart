import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:religion/presentation/widgets/add_2.dart';
import 'package:religion/presentation/widgets/common/header.dart';

class SehriIftarScreen extends StatefulWidget {
  const SehriIftarScreen({Key? key}) : super(key: key);

  @override
  _SehriIftarScreenState createState() => _SehriIftarScreenState();
}

class _SehriIftarScreenState extends State<SehriIftarScreen> {
  late DateTime _selectedDate;
  late List<PrayerTimes> _prayerTimesList;
  bool _isCalendarVisible = false;
  Position? _currentPosition;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _prayerTimesList = [];
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
        desiredAccuracy: LocationAccuracy.medium, // Reduced accuracy for optimization
      );
      setState(() {
        _currentPosition = position;
        _updatePrayerTimes();
      });
    } catch (e) {
      print("Error getting location: $e");
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
    if (_currentPosition == null) return; // Prevent null check crash

    final coordinates = Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    setState(() {
      _prayerTimesList = List.generate(7, (index) {
        final date = _selectedDate.add(Duration(days: index));
        final dateComponents = DateComponents.from(date);
        return PrayerTimes(coordinates, dateComponents, params);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final hijriDate = HijriCalendar.now();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'সেহরি ও ইফতার সময়',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.07), // Responsive bottom padding
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
                  child: _buildSehriIftarTimes(),
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
        defaultTextStyle: TextStyle(fontSize: screenWidth * 0.04), // Responsive font size
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.045), // Responsive font size
      ),
    );
  }

  Widget _buildSehriIftarTimes() {
    if (_prayerTimesList.isEmpty || _currentPosition == null) {
      return Center(child: CircularProgressIndicator(color: const Color(0xFF00BFA5)));
    }

    return ListView.builder(
      key: _listKey,
      itemCount: _prayerTimesList.length,
      itemBuilder: (context, index) {
        final prayerTimes = _prayerTimesList[index];
        final sehriTime = prayerTimes.fajr; // Sehri ends just before Fajr (Subhe Sadiq)
        final iftarTime = prayerTimes.maghrib; // Iftar starts at Maghrib (Sunset)
        final now = DateTime.now();
        final isSehriActive = now.isBefore(sehriTime);
        final isIftarActive = now.isAfter(sehriTime) && now.isBefore(iftarTime);

        final sehriTimeLeft = _getTimeLeft(sehriTime);
        final iftarTimeLeft = _getTimeLeft(iftarTime);

        final hijriDate = HijriCalendar.fromDate(_selectedDate.add(Duration(days: index)));

        return _buildTimeCard(
          DateFormat('EEEE, d MMMM yyyy', 'bn').format(_selectedDate.add(Duration(days: index))),
          sehriTime,
          iftarTime,
          isSehriActive,
          isIftarActive,
          sehriTimeLeft,
          iftarTimeLeft,
          _getBanglaHijriDate(hijriDate),
          index == 0, // Check if it's the current day
        );
      },
    );
  }

  Widget _buildTimeCard(
    String date,
    DateTime sehriTime,
    DateTime iftarTime,
    bool isSehriActive,
    bool isIftarActive,
    String sehriTimeLeft,
    String iftarTimeLeft,
    String hijriDate,
    bool isCurrentDay,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.04),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xFF00BFA5), width: 1),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                    color: const Color(0xFF00BFA5),
                  ),
                ),
                Text(
                  hijriDate,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'সেহরি: ${DateFormat.jm('bn').format(sehriTime)}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.black87,
                  ),
                ),
                if (isCurrentDay && isSehriActive)
                  Text(
                    'বাকি: $sehriTimeLeft',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ইফতার: ${DateFormat.jm('bn').format(iftarTime)}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.black87,
                  ),
                ),
                if (isCurrentDay && isIftarActive)
                  Text(
                    'বাকি: $iftarTimeLeft',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeLeft(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);
    if (difference.isNegative) return 'শেষ হয়েছে';
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '$hours ঘণ্টা $minutes মিনিট';
  }

  String _getBanglaHijriDate(HijriCalendar hijriDate) {
    final banglaNumbers = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
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

    String banglaDay = hijriDate.hDay
        .toString()
        .split('')
        .map((digit) => banglaNumbers[int.parse(digit)])
        .join('');
    String banglaYear = hijriDate.hYear
        .toString()
        .split('')
        .map((digit) => banglaNumbers[int.parse(digit)])
        .join('');

    return '$banglaDay ${hijriMonths[hijriDate.hMonth - 1]} $banglaYear';
  }
}