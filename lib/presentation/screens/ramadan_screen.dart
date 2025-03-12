import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/sehri_iftar_screen.dart';
import 'package:dharma/presentation/screens/ramadan/ramadan_calendar_screen.dart';
import 'package:dharma/presentation/screens/ramadan/ramadan_dua_screen.dart';
import 'package:dharma/presentation/screens/ramadan/ramadan_rules_screen.dart';
import 'package:dharma/presentation/screens/ramadan/donation_screen.dart';
import 'package:dharma/presentation/screens/ramadan/itikaf_screen.dart';

class RamadanScreen extends StatelessWidget {
  const RamadanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        title: const Text('রমজান'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
          children: [
            _buildFeatureCard(
              context,
              'সেহরি ও ইফতারের সময়',
              Icons.access_time,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SehriIftarScreen()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              'রমজানের ক্যালেন্ডার',
              Icons.calendar_today,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RamadanCalendarScreen()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              'রমজানের দোয়া',
              Icons.favorite,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RamadanDuaScreen()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              'রমজানের নিয়মাবলী',
              Icons.rule,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RamadanRulesScreen()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              'দান ও সাদাকাহ',
              Icons.monetization_on,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonationScreen()),
                );
              },
            ),
            _buildFeatureCard(
              context,
              'ইতিকাফ',
              Icons.person,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ItikafScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: const Color(0xFF00BFA5)),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
