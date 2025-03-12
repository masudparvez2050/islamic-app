import 'package:flutter/material.dart';

class RamadanRulesScreen extends StatelessWidget {
  const RamadanRulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('রমজান মাসের বিধি-নিষেধ'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'রমজান মাসের বিধি-নিষেধ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildRuleItem('১. সকল মুসলিম নর-নারীর জন্য রোজা রাখা ফরজ।'),
                  _buildRuleItem('২. রোজাকালীন সময়ে মিথ্যা বলা, গীবত করা ও খারাপ কাজ থেকে নিজেকে বাঁচিয়ে রাখা আবশ্যক।'),
                  _buildRuleItem('৩. রোজার সময় খাদ্য ও পানীয় গ্রহণ থেকে বিরত থাকতে হবে।'),
                  _buildRuleItem('৪. তারাবীহ নামাজ পড়া সুন্নত।'),
                  _buildRuleItem('৫. ইফতারের আগে দোয়া করা উত্তম।'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleItem(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, height: 1.5),
        textAlign: TextAlign.left,
      ),
    );
  }
}
