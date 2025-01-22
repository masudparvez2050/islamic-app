import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16)
          .copyWith(bottom: 20),
      child: Stack(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '04:41',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Isha Time | 6.55PM - 10.55PM',
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  'Time Left: 3 hours 9 min',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSunTimeInfo(
                      Icons.wb_sunny_outlined, 'Sunrise', '05:42 AM'),
                  const SizedBox(height: 8),
                  _buildSunTimeInfo(
                      Icons.nightlight_round, 'Sunset', '06:38 PM'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimeInfo(IconData icon, String label, String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 16,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
