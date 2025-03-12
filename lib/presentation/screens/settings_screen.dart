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

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('সেটিংস', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          _buildSettingItem(context, 'হোম', Icons.home, () {
            _navigateToScreen(context, const HomeScreen());
          }),
          // _buildSettingItem(context, 'লগইন / প্রোফাইল', Icons.person, () {
          //   _navigateToScreen(context, const LoginProfileScreen());
          // }),
          // _buildSettingItem(context, 'ভাষা', Icons.language, () {
          //   _navigateToScreen(context, const LanguageScreen());
          // }),
          // _buildSettingItem(context, 'মুড (ডার্ক/লাইট)', Icons.brightness_6, () {
          //   _navigateToScreen(context, const ThemeModeScreen());
          // }),
          // _buildSettingItem(context, 'লোকেশন', Icons.location_on, () {
          //   _navigateToScreen(context, const LocationScreen());
          // }),
          // _buildSettingItem(context, 'মাজহাব (হানাফি/শাফি)', Icons.school, () {
          //   _navigateToScreen(context, const MadhabScreen());
          // }),
          // _buildSettingItem(context, 'আজান সেটিংস', Icons.volume_up, () {
          //   _navigateToScreen(context, const AdhanSettingsScreen());
          // }),
          // _buildSettingItem(context, 'এলার্ম সেটিংস', Icons.alarm, () {
          //   _navigateToScreen(context, const AlarmSettingsScreen());
          // }),
          _buildSettingItem(context, 'আমাদের সম্পর্কে', Icons.info, () {
            _navigateToScreen(context, const AboutUsScreen());
          }),
          // _buildSettingItem(context, 'ডেভেলপার', Icons.code, () {
          //   _navigateToScreen(context, const DevelopersScreen());
          // }),
          _buildSettingItem(context, 'পাওয়ার্ড বাই', Icons.power, () {
            _navigateToScreen(context, const PoweredByScreen());
          }),
          _buildSettingItem(context, 'সোশ্যাল লিংক', Icons.share, () {
            _navigateToScreen(context, const SocialLinksScreen());
          }),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00BFA5)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
