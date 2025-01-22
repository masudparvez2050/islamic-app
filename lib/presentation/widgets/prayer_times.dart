import 'package:flutter/material.dart';

class PrayerTimes extends StatelessWidget {
  const PrayerTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prayers = [
      {'name': 'Fajr', 'time': '04:41', 'icon': Icons.wb_twilight},
      {'name': 'Dzuhr', 'time': '12:00', 'icon': Icons.wb_sunny},
      {'name': 'Asr', 'time': '15:14', 'icon': Icons.wb_cloudy},
      {'name': 'Maghrib', 'time': '18:02', 'icon': Icons.nights_stay},
      {'name': 'Isha', 'time': '19:11', 'icon': Icons.star},
    ];

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: prayers.map((prayer) {
              return Container(
                width: 80,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(prayer['icon'] as IconData,
                        color: Colors.white, size: 28),
                    const SizedBox(height: 8),
                    Text(
                      prayer['name'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prayer['time'] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
