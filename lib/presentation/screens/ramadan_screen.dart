import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/add_2.dart';
import 'package:religion/presentation/screens/namaz_schedule_screen.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

class RamadanScreen extends StatelessWidget {
  const RamadanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final HijriCalendar hijriDate = HijriCalendar.fromDate(now);
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy', 'bn_BD');

    // Calculate the first day of Ramadan
    final HijriCalendar firstDayOfRamadan = HijriCalendar()
      ..hYear = hijriDate.hYear
      ..hMonth = 9
      ..hDay = 1;
    final DateTime firstDayOfRamadanGregorian = HijriCalendar().hijriToGregorian(firstDayOfRamadan.hYear, firstDayOfRamadan.hMonth, firstDayOfRamadan.hDay);

    // Calculate the date for the first Taraweeh (night before the first day of Ramadan)
    final String firstTaraweeh = dateFormat.format(firstDayOfRamadanGregorian.subtract(const Duration(days: 1))) + ' (চাঁদ দেখার উপর নির্ভরশীল)';
    final String laylatAlQadr = 'প্রত্যাশিত ২১তম, ২৩তম, ২৫তম, ২৭তম বা ২৯তম রাতে';

    // Define today's Sehri and Iftar times
    final DateTime sehriTime = DateTime(now.year, now.month, now.day, 4, 30); // Example Sehri time: 4:30 AM
    final DateTime iftarTime = DateTime(now.year, now.month, now.day, 18, 30); // Example Iftar time: 6:30 PM

    // Calculate the duration between Sehri and Iftar
    final Duration fastingDuration = iftarTime.difference(sehriTime);
    final String fastingTime = '${fastingDuration.inHours} ঘণ্টা ${fastingDuration.inMinutes.remainder(60)} মিনিট';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('রমজান', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
            children: [
              Text(
                'রমজান ${hijriDate.hYear} হিজরি',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildRamadanInfoCard('রোজার সময়', fastingTime),
              _buildRamadanInfoCard('প্রথম তারাবি', firstTaraweeh),
              _buildRamadanInfoCard('লাইলাতুল কদর', laylatAlQadr),
              const SizedBox(height: 24),
              const Text(
                'রমজানের কার্যক্রম',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildActivityItem('দৈনিক কুরআন পাঠ'),
              _buildActivityItem('তারাবি নামাজ'),
              _buildActivityItem('দান ও যাকাত'),
              _buildActivityItem('ইফতার সমাবেশ'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NamazScheduleScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('সেহরি ও ইফতারের সময়সূচী দেখুন', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
          const Advertisement2(),
        ],
      ),
    );
  }

  Widget _buildRamadanInfoCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF00BFA5)),
          const SizedBox(width: 8),
          Text(activity, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}