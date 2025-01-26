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
          Column(
            children: [
              _buildDropdownCalendar(),
              if (_isCalendarVisible) _buildCalendar(),
              Expanded(
                child: _buildPrayerTimesList(),
              ),
            ],
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
            icon: Icon(_isCalendarVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down),
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
        'name': 'Tahajjud',
        'time': _getTahajjudTime(),
        'icon': Icons.nightlight_round
      },
      {'name': 'Fajr', 'time': _prayerTimes.fajr, 'icon': Icons.wb_twilight},
      {'name': 'Sunrise', 'time': _prayerTimes.sunrise, 'icon': Icons.wb_sunny},
      {
        'name': 'Ishraq',
        'time': _getIshraqTime(),
        'icon': Icons.wb_sunny_outlined
      },
      {'name': 'Dhuhr', 'time': _prayerTimes.dhuhr, 'icon': Icons.wb_sunny},
      {'name': 'Asr', 'time': _prayerTimes.asr, 'icon': Icons.wb_cloudy},
      {
        'name': 'Maghrib',
        'time': _prayerTimes.maghrib,
        'icon': Icons.nights_stay
      },
      {'name': 'Isha', 'time': _prayerTimes.isha, 'icon': Icons.star},
    ];

    return ListView.builder(
      itemCount: prayerTimes.length,
      itemBuilder: (context, index) {
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
            prayerTimes[index]['name'] as String,
            prayerTimes[index]['time'] as DateTime,
            prayerTimes[index]['icon'] as IconData,
          ),
        );
      },
    );
  }

  Widget _buildPrayerTimeItem(String prayerName, DateTime time, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00BFA5)),
        title: Text(prayerName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          DateFormat.jm().format(time),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  DateTime _getTahajjudTime() {
    final oneThirdOfNight = _prayerTimes.maghrib.add(Duration(
      seconds:
          (_prayerTimes.fajr.difference(_prayerTimes.maghrib).inSeconds ~/ 3) *
              2,
    ));
    return oneThirdOfNight;
  }

  DateTime _getIshraqTime() {
    return _prayerTimes.sunrise.add(const Duration(minutes: 20));
  }
}