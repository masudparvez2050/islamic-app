import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/bottom_nav_bar.dart';
import 'package:adhan/adhan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class NamazScheduleScreen extends StatefulWidget {
  const NamazScheduleScreen({Key? key}) : super(key: key);

  @override
  _NamazScheduleScreenState createState() => _NamazScheduleScreenState();
}

class _NamazScheduleScreenState extends State<NamazScheduleScreen> {
  late DateTime _selectedDate;
  late PrayerTimes _prayerTimes;
  bool _isCalendarVisible = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _updatePrayerTimes();
  }

  void _updatePrayerTimes() {
    final coordinates = Coordinates(23.8103, 90.4125); // Dhaka, Bangladesh
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final dateComponents = DateComponents.from(_selectedDate);
    _prayerTimes = PrayerTimes(coordinates, dateComponents, params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Namaz Schedule'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 80.0), // Add margin at the bottom
            child: Column(
              children: [
                _buildDropdownCalendar(),
                if (_isCalendarVisible) _buildCalendar(),
                Expanded(
                  child: _buildPrayerTimesList(),
                ),
              ],
            ),
          ),
          const BottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildDropdownCalendar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE, d MMMM yyyy').format(_selectedDate),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(_isCalendarVisible
                ? Icons.arrow_drop_up
                : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _isCalendarVisible = !_isCalendarVisible;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDate,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _updatePrayerTimes();
          _isCalendarVisible = false; // Hide calendar after selecting a date
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
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }

  Widget _buildPrayerTimesList() {
    final prayerTimes = [
      {
        'name': 'ফজর',
        'startTime': _prayerTimes.fajr,
        'endTime': _prayerTimes.sunrise,
        'icon': Icons.wb_twilight
      },
      {
        'name': 'সূর্যোদয়',
        'startTime': _prayerTimes.sunrise,
        'endTime': _getIshraqTime(),
        'icon': Icons.wb_sunny
      },
      {
        'name': 'ইশরাক',
        'startTime': _getIshraqTime(),
        'endTime': _prayerTimes.dhuhr,
        'icon': Icons.wb_sunny_outlined
      },
      {
        'name': 'জোহর',
        'startTime': _prayerTimes.dhuhr,
        'endTime': _prayerTimes.asr,
        'icon': Icons.wb_sunny
      },
      {
        'name': 'আসর',
        'startTime': _prayerTimes.asr,
        'endTime': _prayerTimes.maghrib,
        'icon': Icons.wb_cloudy
      },
      {
        'name': 'মাগরিব',
        'startTime': _prayerTimes.maghrib,
        'endTime': _prayerTimes.isha,
        'icon': Icons.nights_stay
      },
      {
        'name': 'ইশা',
        'startTime': _prayerTimes.isha,
        'endTime': _getNextDayFajr(),
        'icon': Icons.star
      },
      {
        'name': 'তাহাজ্জুদ',
        'startTime': _getTahajjudTime(),
        'endTime': _prayerTimes.fajr,
        'icon': Icons.nightlight_round
      },
    ];

    return ListView.builder(
      itemCount: prayerTimes.length,
      itemBuilder: (context, index) {
        final prayer = prayerTimes[index];
        final isActivePrayer = _isActivePrayer(
            prayer['startTime'] as DateTime, prayer['endTime'] as DateTime);

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500 + (index * 100)),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - value)),
                child: child,
              ),
            );
          },
          child: _buildPrayerTimeItem(
            prayer['name'] as String,
            prayer['startTime'] as DateTime,
            prayer['endTime'] as DateTime,
            prayer['icon'] as IconData,
            isActivePrayer,
          ),
        );
      },
    );
  }

  Widget _buildPrayerTimeItem(String prayerName, DateTime startTime,
      DateTime endTime, IconData icon, bool isActivePrayer) {
    final timeLeft = _getTimeLeft(endTime);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: isActivePrayer
          ? const Color.fromARGB(255, 52, 151, 141)
          : const Color.fromARGB(255, 7, 107, 165).withOpacity(0.2),
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
        title: Text(prayerName,
            style: const TextStyle(
                // fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 18)),
               
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'শুরু: ${DateFormat.jm().format(startTime)}',
              style: TextStyle(
                fontSize: 14,
                color: isActivePrayer
                    ? Colors.white
                    : const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              'শেষ: ${DateFormat.jm().format(endTime)}',
              style: TextStyle(
                fontSize: 14,
                color: isActivePrayer
                    ? Colors.white
                    : const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            if (isActivePrayer)
              Text(
                'সময় বাকি: $timeLeft',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  DateTime _getTahajjudTime() {
    final isha = _prayerTimes.isha;
    final fajr = _prayerTimes.fajr.add(const Duration(days: 1));
    final midpoint = isha.add(fajr.difference(isha) ~/ 2);
    return midpoint;
  }

  DateTime _getIshraqTime() {
    return _prayerTimes.sunrise.add(const Duration(minutes: 20));
  }

  DateTime _getNextDayFajr() {
    final tomorrow = _selectedDate.add(const Duration(days: 1));
    final dateComponents = DateComponents.from(tomorrow);
    final tomorrowPrayerTimes = PrayerTimes(_prayerTimes.coordinates,
        dateComponents, _prayerTimes.calculationParameters);
    return tomorrowPrayerTimes.fajr;
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
