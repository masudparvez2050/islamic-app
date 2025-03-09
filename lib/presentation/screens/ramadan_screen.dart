import 'package:flutter/material.dart';
import 'package:dharma/presentation/widgets/add_2.dart';
import 'package:dharma/presentation/screens/namaz_schedule_screen.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:dharma/presentation/widgets/common/headerRamadan.dart'; // Updated header import

class RamadanScreen extends StatelessWidget {
  const RamadanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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

    // Define today's Sehri and Iftar times (using placeholder, can be dynamic)
    final DateTime sehriTime = DateTime(now.year, now.month, now.day, 4, 30); // Example Sehri time: 4:30 AM
    final DateTime iftarTime = DateTime(now.year, now.month, now.day, 18, 30); // Example Iftar time: 6:30 PM

    // Calculate the duration between Sehri and Iftar
    final Duration fastingDuration = iftarTime.difference(sehriTime);
    final String fastingTime = '${fastingDuration.inHours} ঘণ্টা ${fastingDuration.inMinutes.remainder(60)} মিনিট';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: ResponsiveHeader(
          title: 'রমজান',
          // onBackPressed: () => Navigator.pop(context), // Optional back navigation
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0, // Remove shadow for cleaner look
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.04, // 4% of screen width
              screenHeight * 0.02, // 2% of screen height
              screenWidth * 0.04, // 4% of screen width
              screenHeight * 0.1, // 10% of screen height for bottom padding (for ad)
            ),
            children: [
              Text(
                'রমজান ${hijriDate.hYear} হিজরি',
                style: TextStyle(
                  fontSize: screenWidth * 0.06, // 6% of screen width
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00BFA5),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildRamadanInfoCard(context, 'রোজার সময়', fastingTime),
              _buildRamadanInfoCard(context, 'প্রথম তারাবি', firstTaraweeh),
              _buildRamadanInfoCard(context, 'লাইলাতুল কদর', laylatAlQadr),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'রমজানের কার্যক্রম',
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // 5% of screen width
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00BFA5),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildActivityItem(context, 'দৈনিক কুরআন পাঠ'),
              _buildActivityItem(context, 'তারাবি নামাজ'),
              _buildActivityItem(context, 'দান ও যাকাত'),
              _buildActivityItem(context, 'ইফতার সমাবেশ'),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NamazScheduleScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA5),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.025, // 2.5% of screen height
                    horizontal: screenWidth * 0.06, // 6% of screen width
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03), // 3% of screen width
                  ),
                ),
                child: Text(
                  'সেহরি ও ইফতারের সময়সূচী দেখুন',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // 4.5% of screen width
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const Advertisement2(),
        ],
      ),
    );
  }

  Widget _buildRamadanInfoCard(BuildContext context, String title, String content) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.045, // 4.5% of screen width
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00BFA5),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              content,
              style: TextStyle(
                fontSize: screenWidth * 0.04, // 4% of screen width
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, String activity) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: const Color(0xFF00BFA5),
            size: screenWidth * 0.05, // 5% of screen width
          ),
          SizedBox(width: screenWidth * 0.03),
          Text(
            activity,
            style: TextStyle(
              fontSize: screenWidth * 0.04, // 4% of screen width
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}