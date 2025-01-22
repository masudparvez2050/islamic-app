import 'package:flutter/material.dart';

class RamadanInfo extends StatelessWidget {
  const RamadanInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 117, 121).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'পরবর্তী সময়সূচী সেহরি ও ইফতার ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeInfo('সেহরি', '04:15 AM', 'শেষ'),
              _buildTimeInfo('ইফতার', '06:32 PM', 'শুরু'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String title, String time, String label) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
