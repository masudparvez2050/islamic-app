import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  const Features({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {'name': 'Quran', 'icon': Icons.book},
      {'name': 'Adzan', 'icon': Icons.volume_up},
      {'name': 'Qibla', 'icon': Icons.explore},
      {'name': 'Donation', 'icon': Icons.favorite},
      {'name': 'All', 'icon': Icons.grid_view},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Features',
            style: TextStyle(
              color: Color(0xFF00BFA5),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: features.map((feature) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00BFA5).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      feature['icon'] as IconData,
                      color: const Color(0xFF00BFA5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feature['name'] as String,
                    style: const TextStyle(
                      color: Color(0xFF00BFA5),
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

