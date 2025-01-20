import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hijri/hijri_calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  await initializeDateFormatting('bn_BD', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00BFA5),
        scaffoldBackgroundColor: const Color(0xFF00BFA5),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00BFA5),
      body: Stack(
        children: [
          // Mosque silhouette at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'images/screen_bg.png',
              color: Colors.white.withOpacity(0.1),
              height: 500,
              width: double.infinity,
            ),
          ),
          // Logo and text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.nights_stay,
                    color: Color(0xFF00BFA5),
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Islam App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           _buildHeader(),
  //           _buildTimeDisplay(),
  //           Stack(
  //             children: [
  //               Positioned(
  //                 top: -25, // Move the icon upward
  //                 left: 0,
  //                 right: 0,
  //                 child: Icon(
  //                   Icons.mosque,
  //                   size: 300,
  //                   color: Colors.white.withOpacity(0.1),
  //                 ),
  //               ),
  //               _buildPrayerTimes(),
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Expanded(
  //             child: Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(30),
  //                   topRight: Radius.circular(30),
  //                 ),
  //               ),
  //               child: ListView(
  //                 children: [
  //                   _buildFeatures(),
  //                   _buildNgajiSection(),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           _buildBottomNavBar(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTimeDisplay(),
            Stack(
              clipBehavior:
                  Clip.none, // Allows the icon to overflow without clipping
              children: [
                // Positioned icon at the top but within the same space
                Positioned(
                  top: -450, // Move the icon upwards
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment:
                        Alignment.topCenter, // Center the icon horizontally
                    child: Image.asset(
                      'images/screen_bg.png',
                      color: Colors.white.withOpacity(0.1),
                      height: 1000,
                      width: double.infinity,
                    ),
                  ),
                ),
                _buildPrayerTimes(), // Keep this below the icon
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    _buildFeatures(),
                    _buildNgajiSection(),
                  ],
                ),
              ),
            ),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final now = DateTime.now();
    final englishDate = DateFormat('d MMMM yyyy').format(now);
    final banglaDate = DateFormat('d MMMM yyyy', 'bn_BD').format(now);
    final hijri = HijriCalendar.now();
    final hijriDate =
        '${hijri.hDay} ${hijri.getLongMonthName()} ${hijri.hYear} H';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  englishDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  banglaDate,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  hijriDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // const Text(
                //   'Dhaka, Bangladesh',
                //   style: TextStyle(
                //     color: Colors.white70,
                //     fontSize: 14,
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'BN',
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    dropdownColor: const Color(0xFF00BFA5),
                    items: const [
                      DropdownMenuItem(
                        value: 'BN',
                        child: Text(
                          'BN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'EN',
                        child: Text(
                          'EN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (String? value) {
                      // Handle language change
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //version 1

  // Widget _buildTimeDisplay() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 20),
  //     child: Column(
  //       children: const [
  //         Text(
  //           '04:41',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 72,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Text(
  //           'Fajr 3 hour 9 min left',
  //           style: TextStyle(color: Colors.white70),
  //         ),
  //       ],
  //     ),
  //   );
  // }

// version 2
  // Widget _buildTimeDisplay() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const Expanded(
  //           child: Column(
  //             children: [
  //               Text(
  //                 '04:41',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 72,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               Text(
  //                 'Fajr 3 hour 9 min left',
  //                 style: TextStyle(color: Colors.white70),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             _buildSunTimeInfo(Icons.wb_sunny_outlined, 'Sunrise', '05:42 AM'),
  //             const SizedBox(height: 8),
  //             _buildSunTimeInfo(Icons.nightlight_round, 'Sunset', '06:38 PM'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTimeDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Stack(
        children: [
          // Centered Time and Prayer Info
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '04:41',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Fajr 3 hour 9 min left',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Positioned Sun Times Info at the bottom-right of the screen
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16), // Optional padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSunTimeInfo(
                      Icons.wb_sunny_outlined, 'Sunrise', '05:42 AM'),
                  const SizedBox(height: 8),
                  _buildSunTimeInfo(
                      Icons.nightlight_round, 'Sunset', '06:38 PM'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimeInfo(IconData icon, String label, String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 16,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildPrayerTimes() {
  //   final prayers = [
  //     {'name': 'Fajr', 'time': '04:41', 'icon': Icons.wb_twilight},
  //     {'name': 'Dzuhr', 'time': '12:00', 'icon': Icons.wb_sunny},
  //     {'name': 'Asr', 'time': '15:14', 'icon': Icons.wb_cloudy},
  //     {'name': 'Maghrib', 'time': '18:02', 'icon': Icons.nights_stay},
  //     {'name': 'Isha', 'time': '19:11', 'icon': Icons.star},
  //   ];

  //   return Container(
  //     height: 100,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: prayers.length,
  //       itemBuilder: (context, index) {
  //         final prayer = prayers[index];
  //         return Container(
  //           width: 80,
  //           margin: const EdgeInsets.symmetric(horizontal: 4),
  //           padding: const EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             color: Colors.white.withOpacity(0.1),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(prayer['icon'] as IconData, color: Colors.white, size: 24),
  //               const SizedBox(height: 8),
  //               Text(
  //                 prayer['name'] as String,
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               Text(
  //                 prayer['time'] as String,
  //                 style: const TextStyle(
  //                   color: Colors.white70,
  //                   fontSize: 12,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildPrayerTimes() {
    final prayers = [
      {'name': 'Fajr', 'time': '04:41', 'icon': Icons.wb_twilight},
      {'name': 'Dzuhr', 'time': '12:00', 'icon': Icons.wb_sunny},
      {'name': 'Asr', 'time': '15:14', 'icon': Icons.wb_cloudy},
      {'name': 'Maghrib', 'time': '18:02', 'icon': Icons.nights_stay},
      {'name': 'Isha', 'time': '19:11', 'icon': Icons.star},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: prayers.length,
        padding: const EdgeInsets.symmetric(
            horizontal: 16), // Add padding to center items
        itemBuilder: (context, index) {
          final prayer = prayers[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.symmetric(
                horizontal: 8), // Space between items
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Even spacing vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(prayer['icon'] as IconData, color: Colors.white, size: 24),
                Text(
                  prayer['name'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  prayer['time'] as String,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatures() {
    final features = [
      {'name': 'Quran', 'icon': Icons.book},
      {'name': 'Adzan', 'icon': Icons.volume_up},
      {'name': 'Qibla', 'icon': Icons.explore},
      {'name': 'Donation', 'icon': Icons.favorite},
      {'name': 'All', 'icon': Icons.grid_view},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Features',
            style: TextStyle(
              color: Color(0xFF00BFA5),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: features.map((feature) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00BFA5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      feature['icon'] as IconData,
                      color: const Color(0xFF00BFA5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feature['name'] as String,
                    style: const TextStyle(
                      color: Color(0xFF00BFA5),
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNgajiSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Ngajii Online',
                style: TextStyle(
                  color: Color(0xFF00BFA5),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildNgajiCard(true),
                _buildNgajiCard(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNgajiCard(bool isLive) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF00BFA5).withOpacity(0.1),
      ),
      child: Stack(
        children: [
          if (isLive)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children: const [
                Icon(Icons.remove_red_eye, color: Color(0xFF00BFA5), size: 16),
                SizedBox(width: 4),
                Text(
                  '3.6K viewers',
                  style: TextStyle(color: Color(0xFF00BFA5), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Color(0xFF00BFA5)),
          Icon(Icons.calendar_today, color: Colors.grey),
          Icon(Icons.note, color: Colors.grey),
          Icon(Icons.person_outline, color: Colors.grey),
        ],
      ),
    );
  }
}
