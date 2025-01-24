import 'package:flutter/material.dart';

class AdzanScreen extends StatelessWidget {
  const AdzanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adzan'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF00BFA5).withOpacity(0.1),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Next Prayer', style: TextStyle(fontSize: 18)),
                Text('Asr - 15:30', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildPrayerTimeItem('Fajr', '05:30'),
                _buildPrayerTimeItem('Dhuhr', '12:30'),
                _buildPrayerTimeItem('Asr', '15:30'),
                _buildPrayerTimeItem('Maghrib', '18:30'),
                _buildPrayerTimeItem('Isha', '20:00'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeItem(String prayerName, String time) {
    return ListTile(
      title: Text(prayerName),
      trailing: Text(time),
      leading: const Icon(Icons.access_time, color: Color(0xFF00BFA5)),
    );
  }
}

