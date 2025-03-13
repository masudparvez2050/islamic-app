import 'package:flutter/material.dart';
import '../widgets/meditation_progress_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আমার প্রোফাইল'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User profile header
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile_avatar.png'),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'আব্দুল্লাহ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('abdullah@example.com'),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Achievements section with meditation progress
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'আমার অর্জন',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 15),
            
            // Show current meditation progress in profile
            MeditationProgressCard(
              currentDay: 12,
              totalDays: 40,
              stepTitle: 'মেডিটেশনের ১ম ধাপ',
              onTap: () {
                Navigator.pushNamed(context, '/meditation');
              },
            ),
            
            const SizedBox(height: 30),
            
            // More profile sections
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('মেডিটেশন হিস্টোরি'),
              onTap: () {
                // Navigate to meditation history
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('সেটিংস'),
              onTap: () {
                // Navigate to settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
