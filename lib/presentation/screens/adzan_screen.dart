import 'package:flutter/material.dart';

class AdzanScreen extends StatelessWidget {
  const AdzanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('আজান', style: TextStyle(color: Colors.white)),
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
                Text('পরবর্তী নামাজ', style: TextStyle(fontSize: 18)),
                Text('আসর - 15:30', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildPrayerTimeItem('ফজর', '05:30'),
                _buildPrayerTimeItem('জোহর', '12:30'),
                _buildPrayerTimeItem('আসর', '15:30'),
                _buildPrayerTimeItem('মাগরিব', '18:30'),
                _buildPrayerTimeItem('ইশা', '20:00'),
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

