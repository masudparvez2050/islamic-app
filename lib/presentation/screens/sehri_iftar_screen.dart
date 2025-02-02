import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:religion/presentation/widgets/bottom_nav_bar.dart';

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
      final coordinates = Coordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;

      setState(() {
        _prayerTimesList = List.generate(10, (index) {
          final date = _selectedDate.add(Duration(days: index));
          final dateComponents = DateComponents.from(date);
          return PrayerTimes(coordinates, dateComponents, params);
        });

        // Add items to the AnimatedList
        for (int i = 0; i < _prayerTimesList.length; i++) {
          _listKey.currentState?.insertItem(i);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hijriDate = HijriCalendar.now();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('সেহরি ও ইফতার সময়'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('EEEE, d MMMM yyyy').format(_selectedDate),
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear} AH',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
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
                  child: _buildSehriIftarTimes(),
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

  Widget _buildSehriIftarTimes() {
    if (_prayerTimesList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return AnimatedList(
      key: _listKey,
      initialItemCount: _prayerTimesList.length,
      itemBuilder: (context, index, animation) {
        final prayerTimes = _prayerTimesList[index];
        final sehriTime = prayerTimes.fajr;
        final iftarTime = prayerTimes.maghrib;
        final now = DateTime.now();
        final isSehriActive = now.isBefore(sehriTime);
        final isIftarActive = now.isBefore(iftarTime) && now.isAfter(sehriTime);

        final sehriTimeLeft = _getTimeLeft(sehriTime);
        final iftarTimeLeft = _getTimeLeft(iftarTime);

        final hijriDate =
            HijriCalendar.fromDate(_selectedDate.add(Duration(days: index)));

        return _buildAnimatedTimeCard(
          animation,
          DateFormat('EEEE, d MMMM yyyy')
              .format(_selectedDate.add(Duration(days: index))),
          sehriTime,
          iftarTime,
          isSehriActive,
          isIftarActive,
          sehriTimeLeft,
          iftarTimeLeft,
          '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear} AH',
        );
      },
    );
  }

  Widget _buildAnimatedTimeCard(
    Animation<double> animation,
    String date,
    DateTime sehriTime,
    DateTime iftarTime,
    bool isSehriActive,
    bool isIftarActive,
    String sehriTimeLeft,
    String iftarTimeLeft,
    String hijriDate,
  ) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: const Color(0xFF00BFA5), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA5),
                ),
              ),
              Text(
                hijriDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sehri: ${DateFormat.jm().format(sehriTime)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              if (isSehriActive)
                Text(
                  'Time left: $sehriTimeLeft',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                'Iftar: ${DateFormat.jm().format(iftarTime)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              if (isIftarActive)
                Text(
                  'Time left: $iftarTimeLeft',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeLeft(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '$hours hours $minutes minutes';
  }
}
