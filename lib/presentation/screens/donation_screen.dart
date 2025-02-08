import 'package:flutter/material.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Donation'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Support Our Cause',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your donation helps us continue our mission to spread Islamic knowledge and support the community.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildDonationOption('One-time Donation', Icons.attach_money),
          _buildDonationOption('Monthly Donation', Icons.repeat),
          _buildDonationOption('Zakat', Icons.favorite),
          _buildDonationOption('Sadaqah', Icons.volunteer_activism),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Handle donation process
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Donate Now', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationOption(String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00BFA5)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle specific donation option
        },
      ),
    );
  }
}
