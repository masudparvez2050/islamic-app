import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/home_screen.dart';
import 'package:religion/presentation/screens/namaz_schedule_screen.dart';
import 'package:religion/presentation/screens/quran_screen.dart';
import 'package:religion/presentation/screens/ramadan_screen.dart';
import 'package:religion/presentation/screens/settings_screen.dart';
import 'package:religion/presentation/widgets/features.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
             
              blurRadius: 10, color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, Icons.home, 'Home', const HomeScreen()),
            _buildNavItem(context, Icons.calendar_today, 'Namaz',
                const NamazScheduleScreen()),
            _buildAllFeaturesButton(context),
            _buildNavItem(
                context, Icons.menu_book, 'Quran', const QuranScreen()),
            _buildNavItem(
                context, Icons.star, 'Ramadan', const RamadanScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF00BFA5)),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF00BFA5), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAllFeaturesButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAllFeaturesModal(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF00BFA5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00BFA5).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.grid_view,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  void _showAllFeaturesModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const AllFeaturesModal();
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
