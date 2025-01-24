import 'package:flutter/material.dart';

class RamadanScreen extends StatelessWidget {
  const RamadanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramadan'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Ramadan 1444 AH',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildRamadanInfoCard('Fasting Hours', '14 hours 30 minutes'),
          _buildRamadanInfoCard('First Taraweeh', '22 March 2023'),
          _buildRamadanInfoCard('Laylat al-Qadr', 'Expected on 17th, 19th, 21st, 23rd, 25th, 27th or 29th night'),
          const SizedBox(height: 24),
          const Text(
            'Ramadan Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildActivityItem('Daily Quran Reading'),
          _buildActivityItem('Taraweeh Prayers'),
          _buildActivityItem('Charity and Zakat'),
          _buildActivityItem('Iftar Gatherings'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to Sehri & Iftar screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('View Sehri & Iftar Timings', style: TextStyle(fontSize: 18)),
          ),
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

