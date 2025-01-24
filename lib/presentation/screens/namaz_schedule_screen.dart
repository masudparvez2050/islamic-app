import 'package:flutter/material.dart';

class NamazScheduleScreen extends StatelessWidget {
  const NamazScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Namaz Schedule'),
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
                Text('Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('23 April 2023', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildNamazScheduleItem('Fajr', '05:30', '06:45'),
                _buildNamazScheduleItem('Dhuhr', '12:30', '15:00'),
                _buildNamazScheduleItem('Asr', '15:30', '18:00'),
                _buildNamazScheduleItem('Maghrib', '18:30', '19:45'),
                _buildNamazScheduleItem('Isha', '20:00', '21:30'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNamazScheduleItem(String namazName, String startTime, String endTime) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(namazName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Starts: $startTime', style: const TextStyle(fontSize: 16)),
                Text('Ends: $endTime', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

