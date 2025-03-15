import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/home_screen.dart';
import 'package:dharma/presentation/screens/settings/login_profile_screen.dart';
import 'package:dharma/presentation/screens/settings/language_screen.dart';
import 'package:dharma/presentation/screens/settings/theme_mode_screen.dart';
import 'package:dharma/presentation/screens/settings/location_screen.dart';
import 'package:dharma/presentation/screens/settings/madhab_screen.dart';
import 'package:dharma/presentation/screens/settings/adhan_settings_screen.dart';
import 'package:dharma/presentation/screens/settings/alarm_settings_screen.dart';
import 'package:dharma/presentation/screens/settings/about_us_screen.dart';
import 'package:dharma/presentation/screens/settings/developers_screen.dart';
import 'package:dharma/presentation/screens/settings/powered_by_screen.dart';
import 'package:dharma/presentation/screens/settings/social_links_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<GlobalKey> _listItemKeys = List.generate(12, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFF5F7FA)
          : const Color(0xFF1A1D21),
      appBar: AppBar(
        title: Text(
          'সেটিংস',
          style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: screenWidth * 0.05, // 5% of screen width
        color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.white,
            size: screenWidth * 0.06, // 6% of screen width
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, // 4% of screen width
            vertical: screenHeight * 0.015, // 1.5% of screen height
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: screenHeight * 0.02, // 2% of screen height
                    top: screenHeight * 0.01, // 1% of screen height
                  ),
                  child: Text(
                    'অ্যাপ্লিকেশন সেটিংস',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // 4% of screen width
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[700]
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildAnimatedSettingGroup(context, [
                    _buildSettingData('হোম', Icons.home_rounded, const HomeScreen()),
                    // _buildSettingData('লগইন / প্রোফাইল', Icons.person_rounded, const LoginProfileScreen()),
                    // _buildSettingData('ভাষা', Icons.translate_rounded, const LanguageScreen()),
                    // _buildSettingData('মুড (ডার্ক/লাইট)', Icons.dark_mode_rounded, const ThemeModeScreen()),
                  ], 0),
                  
                  // SizedBox(height: screenHeight * 0.03), // 3% of screen height
                  
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: screenHeight * 0.02), // 2% of screen height
                  //   child: Text(
                  //     'প্রার্থনা সেটিংস',
                  //     style: TextStyle(
                  //       fontSize: screenWidth * 0.04, // 4% of screen width
                  //       fontWeight: FontWeight.w500,
                  //       color: Theme.of(context).brightness == Brightness.light
                  //           ? Colors.grey[700]
                  //           : Colors.grey[300],
                  //     ),
                  //   ),
                  // ),
                  
                  // _buildAnimatedSettingGroup(context, [
                  //   _buildSettingData('লোকেশন', Icons.location_on_rounded, const LocationScreen()),
                  //   _buildSettingData('মাজহাব (হানাফি/শাফি)', Icons.school_rounded, const MadhabScreen()),
                  //   _buildSettingData('আজান সেটিংস', Icons.volume_up_rounded, const AdhanSettingsScreen()),
                  //   _buildSettingData('এলার্ম সেটিংস', Icons.alarm_rounded, const AlarmSettingsScreen()),
                  // ], 4),
                  
                  SizedBox(height: screenHeight * 0.03), // 3% of screen height
                  
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02), // 2% of screen height
                    child: Text(
                      'অন্যান্য',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // 4% of screen width
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[700]
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                  
                  _buildAnimatedSettingGroup(context, [
                    _buildSettingData('আমাদের সম্পর্কে', Icons.info_rounded, const AboutUsScreen()),
                    // _buildSettingData('ডেভেলপার', Icons.code_rounded, const DevelopersScreen()),
                    _buildSettingData('পাওয়ার্ড বাই', Icons.bolt_rounded, const PoweredByScreen()),
                    // _buildSettingData('সোশ্যাল লিংক', Icons.share_rounded, const SocialLinksScreen()),
                  ], 8),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSettingGroup(BuildContext context, List<_SettingItemData> items, int startIndex) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF282C31),
        borderRadius: BorderRadius.circular(screenWidth * 0.04), // 4% of screen width
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: screenWidth * 0.025, // 2.5% of screen width
            offset: Offset(0, screenHeight * 0.005), // 0.5% of screen height
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final itemIndex = startIndex + index;
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final delay = itemIndex * 0.1;
              final animationValue = Curves.easeOutCubic.transform(
                ((_controller.value - delay) / (1.0 - delay)).clamp(0.0, 1.0),
              );
              
              return Transform.translate(
                offset: Offset(0, screenHeight * 0.025 * (1 - animationValue)), // 2.5% of screen height
                child: Opacity(
                  opacity: animationValue,
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                _buildSettingItem(
                  context,
                  items[index].title,
                  items[index].icon,
                  () => _navigateToScreen(context, items[index].screen),
                  key: _listItemKeys[itemIndex],
                ),
                if (index < items.length - 1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% of screen width
                    child: Divider(
                      height: screenHeight * 0.00125, // 0.125% of screen height
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    {Key? key}
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      key: key,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(screenWidth * 0.03), // 3% of screen width
        highlightColor: const Color(0xFF00BFA5).withOpacity(0.1),
        splashColor: const Color(0xFF00BFA5).withOpacity(0.2),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005), // 0.5% of screen height
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // 5% of screen width
              vertical: screenHeight * 0.01, // 1% of screen height
            ),
            leading: Container(
              width: screenWidth * 0.1, // 10% of screen width
              height: screenWidth * 0.1, // 10% of screen width
              decoration: BoxDecoration(
                color: const Color(0xFF00BFA5).withOpacity(0.15),
                borderRadius: BorderRadius.circular(screenWidth * 0.03), // 3% of screen width
              ),
              child: Icon(
                icon,
                color: const Color(0xFF00BFA5),
                size: screenWidth * 0.055, // 5.5% of screen width
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.04, // 4% of screen width
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black87
                    : Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: screenWidth * 0.04, // 4% of screen width
              color: const Color(0xFF00BFA5),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

class _SettingItemData {
  final String title;
  final IconData icon;
  final Widget screen;

  _SettingItemData(this.title, this.icon, this.screen);
}

extension on _SettingsScreenState {
  _SettingItemData _buildSettingData(String title, IconData icon, Widget screen) {
    return _SettingItemData(title, icon, screen);
  }
}