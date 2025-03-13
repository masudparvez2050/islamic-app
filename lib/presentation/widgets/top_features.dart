import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/quran_screen.dart';
import 'package:dharma/presentation/screens/book_library_screen.dart';
import 'package:dharma/presentation/screens/video_library_screen.dart';

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
          SizedBox(height: screenHeight * 0.005),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: features.map((feature) {
                return _buildFeatureItem(context, feature, iconSize, fontSize, () {
                  switch (feature['name']) {
                    case 'ইসলামিক বই':
                      _navigateWithAnimation(context, const BookLibraryScreen());
                      break;
                    case 'ইসলামিক ভিডিও':
                      _navigateWithAnimation(context, const VideoLibraryScreen());
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
    // Generate a unique color based on the feature name
    final int nameHash = feature['name'].toString().hashCode;
    final double hue = (nameHash % 360).toDouble();
    
    // Create vibrant but harmonious color
    final Color iconColor = HSLColor.fromAHSL(1, hue, 0.85, 0.56).toColor();
    
    // Modern gradient colors
    final List<Color> gradientColors = [
      HSLColor.fromAHSL(1, hue, 0.8, 0.55).toColor(),
      HSLColor.fromAHSL(1, hue, 0.9, 0.4).toColor(),
    ];
    
    return Hero(
      tag: 'feature_${feature['name']}',
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
          child: Column(
            children: [
              Material(
                elevation: 2,
                shadowColor: iconColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(iconSize * 0.33),
                child: Container(
                  padding: EdgeInsets.all(iconSize * 0.30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(iconSize * 0.33),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
              SizedBox(height: iconSize * 0.22),
              Text(
                feature['name'] as String,
                style: TextStyle(
                  color: HSLColor.fromAHSL(1, hue, 0.7, 0.35).toColor(),
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _navigateWithAnimation(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, secondaryAnimation) => screen,
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:dharma/presentation/screens/quran_screen.dart';
// import 'package:dharma/presentation/screens/book_library_screen.dart';
// import 'package:dharma/presentation/screens/video_library_screen.dart';

// class TopFeatures extends StatelessWidget {
//   const TopFeatures({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final features = [
//       {'name': 'ইসলামিক বই', 'icon': Icons.library_books},
//       {'name': 'ইসলামিক ভিডিও', 'icon': Icons.video_library},
//     ];

//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final iconSize = screenWidth * 0.1;
//     final fontSize = screenWidth * 0.03;

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: screenHeight * 0.005),
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: features.map((feature) {
//                 return _buildFeatureItem(context, feature, iconSize, fontSize, () {
//                   switch (feature['name']) {
//                     case 'ইসলামিক বই':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const BookLibraryScreen()));
//                       break;
//                     case 'ইসলামিক ভিডিও':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const VideoLibraryScreen()));
//                       break;
//                   }
//                 });
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeatureItem(
//       BuildContext context, Map<String, dynamic> feature, double iconSize, double fontSize, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(iconSize * 0.30),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF00BFA5).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(iconSize * 0.33),
//               ),
//               child: Icon(
//                 feature['icon'] as IconData,
//                 color: const Color(0xFF00BFA5),
//                 size: iconSize,
//               ),
//             ),
//             SizedBox(height: iconSize * 0.22),
//             Text(
//               feature['name'] as String,
//               style: TextStyle(
//                 color: const Color(0xFF00BFA5),
//                 fontSize: fontSize,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
