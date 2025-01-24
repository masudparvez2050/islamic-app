import 'package:flutter/material.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Hadith Collections',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildHadithCollectionCard('Sahih al-Bukhari', '7,563 hadiths'),
          _buildHadithCollectionCard('Sahih Muslim', '7,500 hadiths'),
          _buildHadithCollectionCard('Sunan Abu Dawood', '5,274 hadiths'),
          _buildHadithCollectionCard('Jami at-Tirmidhi', '3,956 hadiths'),
          _buildHadithCollectionCard('Sunan an-Nasa\'i', '5,761 hadiths'),
          _buildHadithCollectionCard('Sunan ibn Majah', '4,341 hadiths'),
        ],
      ),
    );
  }

  Widget _buildHadithCollectionCard(String title, String count) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(count),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to specific hadith collection
        },
      ),
    );
  }
}

