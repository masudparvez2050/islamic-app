import 'package:flutter/material.dart';

class SehriIftarScreen extends StatelessWidget {
  const SehriIftarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sehri & Iftar'),
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
                Text('Ramadan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('1444 AH', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return _buildSehriIftarItem(index + 1, '04:30', '18:45');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSehriIftarItem(int day, String sehriTime, String iftarTime) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Day $day', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Sehri: $sehriTime', style: const TextStyle(fontSize: 16)),
                Text('Iftar: $iftarTime', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

