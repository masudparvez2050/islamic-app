import 'package:flutter/material.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Quran Chapters',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Example list of Quran chapters
          for (int i = 1; i <= 10; i++)
            ListTile(
              title: Text('Surah $i'),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF00BFA5),
                child: Text('$i', style: const TextStyle(color: Colors.white)),
              ),
              onTap: () {
                // Navigate to specific Surah
              },
            ),
        ],
      ),
    );
  }
}

