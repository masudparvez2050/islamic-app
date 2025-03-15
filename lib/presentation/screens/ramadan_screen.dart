import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/sehri_iftar_screen.dart';
import 'package:dharma/presentation/screens/ramadan/ramadan_calendar_screen.dart';
import 'package:dharma/presentation/screens/ramadan/ramadan_dua_screen_with_header.dart';
import 'package:dharma/presentation/screens/ramadan/ramadan_rules_screen.dart';
import 'package:dharma/presentation/screens/ramadan/donation_screen.dart';
import 'package:dharma/presentation/screens/ramadan/itikaf_screen.dart';
import 'package:dharma/presentation/widgets/common/headerRamadanScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class RamadanScreen extends StatelessWidget {
  const RamadanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Top gradient background
          Container(
            height: screenHeight * 0.28,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF009688), Color(0xFF00BFA5)],
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (extracted to a separate widget)
                Header(
                  title: 'রমজান',
                  subtitle: 'মাহে রমজানের সমস্ত প্রয়োজনীয় তথ্য',
                ),
                // Feature cards section
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.02,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: screenWidth * 0.04,
                        mainAxisSpacing: screenHeight * 0.02,
                      ),
                      itemCount: _ramadanFeatures.length,
                      itemBuilder: (context, index) {
                        final feature = _ramadanFeatures[index];
                        return _buildFeatureCard(
                          context,
                          feature['title'] as String,
                          feature['icon'] as IconData,
                          feature['color'] as Color,
                          feature['screen'] as Widget,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get _ramadanFeatures => [
        {
          'title': 'সেহরি ও ইফতারের সময়',
          'icon': Icons.schedule_rounded,
          'color': const Color(0xFF2196F3),
          'screen': const SehriIftarScreen(),
        },
        {
          'title': 'রমজানের ক্যালেন্ডার',
          'icon': Icons.calendar_today_rounded,
          'color': const Color(0xFF795548),
          'screen': const RamadanCalendarScreen(),
        },
        {
          'title': 'রমজানের দোয়া',
          'icon': FontAwesomeIcons.handsPraying, // Using FontAwesome icon
          'color': const Color(0xFFE91E63),
          'screen': const RamadanDuaScreenWithHeader(),
        },
        {
          'title': 'রমজানের নিয়মাবলী',
          'icon': Icons.rule_folder_rounded,
          'color': const Color(0xFF673AB7),
          'screen': const RamadanRulesScreen(),
        },
        {
          'title': 'দান ও সাদাকাহ',
          'icon': Icons.volunteer_activism_rounded,
          'color': const Color(0xFF4CAF50),
          'screen': const DonationScreen(),
        },
        {
          'title': 'ইতিকাফ',
          'icon': Icons.night_shelter_rounded,
          'color': const Color(0xFFFF9800),
          'screen': const ItikafScreen(),
        },
      ];

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: screenWidth * 0.025,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToScreen(context, screen),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: screenWidth * 0.08,
                    color: color,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}