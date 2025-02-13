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

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = screenWidth * 0.1;
    final fontSize = screenWidth * 0.03;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.01),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: features.map((feature) {
                return _buildFeatureItem(context, feature, iconSize, fontSize, () {
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
      BuildContext context, Map<String, dynamic> feature, double iconSize, double fontSize, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(iconSize * 0.33),
              decoration: BoxDecoration(
                color: const Color(0xFF00BFA5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(iconSize * 0.33),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: const Color(0xFF00BFA5),
                size: iconSize,
              ),
            ),
            SizedBox(height: iconSize * 0.22),
            Text(
              feature['name'] as String,
              style: TextStyle(
                color: const Color(0xFF00BFA5),
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
