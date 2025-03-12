import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class RamadanCalendarScreen extends StatefulWidget {
  const RamadanCalendarScreen({Key? key}) : super(key: key);

  @override
  _RamadanCalendarScreenState createState() => _RamadanCalendarScreenState();
}

class _RamadanCalendarScreenState extends State<RamadanCalendarScreen> {
  final List<Map<String, dynamic>> _ramadanTimings = [];
  final Map<String, String> _hijriBanglaMonths = {
    'Muharram': 'মুহাররম',
    'Safar': 'সফর',
    'Rabi\' al-awwal': 'রবিউল আউয়াল',
    'Rabi\' al-thani': 'রবিউস সানি',
    'Jumada al-awwal': 'জুমাদাল উলা',
    'Jumada al-thani': 'জুমাদাল উখরা',
    'Rajab': 'রজব',
    'Sha\'ban': 'শাবান',
    'Ramadan': 'রমজান',
    'Shawwal': 'শাওয়াল',
    'Dhu al-Qi\'dah': 'জিলকদ',
    'Dhu al-Hijjah': 'জিলহজ',
  };
  
  final Map<String, String> _englishToBanglaNumerals = {
    '0': '০', '1': '১', '2': '২', '3': '৩', '4': '৪',
    '5': '৫', '6': '৬', '7': '৭', '8': '৮', '9': '৯'
  };

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('bn_BD');
    _generateRamadanTimings();
  }

  String _convertToBanglaNumber(String number) {
    String result = '';
    for (int i = 0; i < number.length; i++) {
      if (_englishToBanglaNumerals.containsKey(number[i])) {
        result += _englishToBanglaNumerals[number[i]]!;
      } else {
        result += number[i];
      }
    }
    return result;
  }

  String _formatHijriDateInBangla(HijriCalendar hijriDate) {
    String dayString = _convertToBanglaNumber(hijriDate.hDay.toString());
    // Use the correct method to get month name based on hMonth
    String monthName = _hijriBanglaMonths[hijriDate.longMonthName] ?? 
                        hijriDate.longMonthName;
    String yearString = _convertToBanglaNumber(hijriDate.hYear.toString());
    
    return '$dayString $monthName $yearString হিজরি';
  }

  void _generateRamadanTimings() {
    // Assuming Ramadan starts around March 1, 2025 (adjust as needed)
    HijriCalendar ramadanStart = HijriCalendar.fromDate(DateTime(2025, 3, 2));

    // Generate timings for 30 days
    for (int i = 0; i < 30; i++) {
      DateTime gregorianDate = ramadanStart.hijriToGregorian(ramadanStart.hYear, ramadanStart.hMonth, ramadanStart.hDay);
      _ramadanTimings.add({
        'date': gregorianDate,
        'hijriDate': ramadanStart, // Store actual HijriCalendar object
        'sehri': _calculateSehriTime(gregorianDate),
        'iftar': _calculateIftarTime(gregorianDate),
      });

      // Convert HijriCalendar to DateTime, add one day, and convert back to HijriCalendar
    gregorianDate = gregorianDate.add(const Duration(days: 1)); // Subtract one day
    ramadanStart = HijriCalendar.fromDate(gregorianDate);
    }
  }

  String _calculateSehriTime(DateTime date) {
    // This is just a placeholder
    DateTime time = date.add(const Duration(hours: 5, minutes: 30));
    String formattedTime = DateFormat('hh:mm a').format(time);
    return _convertToBanglaNumber(formattedTime);
  }

  String _calculateIftarTime(DateTime date) {
    // This is just a placeholder
    DateTime time = date.add(const Duration(hours: 18, minutes: 15));
    String formattedTime = DateFormat('hh:mm a').format(time);
    return _convertToBanglaNumber(formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F5),
      appBar: AppBar(
        title: const Text(
          'রমজান ক্যালেন্ডার ২০২৫',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _ramadanTimings.isEmpty
          ? const Center(
              child: Text(
                'রমজান ক্যালেন্ডার শীঘ্রই আসছে!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _ramadanTimings.length,
              itemBuilder: (context, index) {
                final timing = _ramadanTimings[index];
                return _buildCompactCalendarCard(timing);
              },
            ),
    );
  }

  Widget _buildCompactCalendarCard(Map<String, dynamic> timing) {
    final date = timing['date'] as DateTime;
    final hijriDate = timing['hijriDate'] as HijriCalendar;
    final sehri = timing['sehri'] as String;
    final iftar = timing['iftar'] as String;

    final isToday = DateTime.now().day == date.day &&
                    DateTime.now().month == date.month &&
                    DateTime.now().year == date.year;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isToday ? const Color(0xFF00BFA5).withOpacity(0.2) : null,
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Add this line
        children: [
        Row(
          children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
            color: isToday ? const Color(0xFF00BFA5) : Colors.grey[300],
            borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
            _convertToBanglaNumber(date.day.toString()),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isToday ? Colors.white : Colors.black,
            ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              DateFormat('EEEE', 'bn_BD').format(date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
              ),
              Text(
              _formatHijriDateInBangla(hijriDate),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 10,
              ),
              overflow: TextOverflow.ellipsis,
              ),
            ],
            ),
          ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              'সেহরি',
              style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              ),
            ),
            Text(
              sehri,
              style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              ),
            ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              'ইফতার',
              style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              ),
            ),
            Text(
              iftar,
              style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              ),
            ),
            ],
          ),
          ],
        ),
        ],
      ),
      ),
    );
  }
}