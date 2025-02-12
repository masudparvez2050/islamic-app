import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/quran_screen.dart';
import 'package:religion/presentation/screens/book_library_screen.dart';


class TopFeatures extends StatelessWidget {
  const TopFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {'name': 'ইসলামিক বই', 'icon': Icons.library_books},
      {'name': 'ইসলামিক ভিডিও', 'icon': Icons.video_library},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: features.map((feature) {
                return _buildFeatureItem(context, feature, () {
                  switch (feature['name']) {
                    case 'ইসলামিক বই':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BookLibraryScreen()));
                      break;
                    case 'ইসলামিক ভিডিও':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BookLibraryScreen()));
                      break;
                  }
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
      BuildContext context, Map<String, dynamic> feature, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
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
                size: 36,
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
        ),
      ),
    );
  }
}
