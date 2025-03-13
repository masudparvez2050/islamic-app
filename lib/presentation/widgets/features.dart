import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dharma/presentation/screens/quran_screen.dart';
import 'package:dharma/presentation/screens/adzan_screen.dart';
import 'package:dharma/presentation/screens/qibla_screen.dart';
import 'package:dharma/presentation/screens/donation_screen.dart';
import 'package:dharma/presentation/screens/namaz_schedule_screen.dart';
import 'package:dharma/presentation/screens/sehri_iftar_screen.dart';
import 'package:dharma/presentation/screens/ramadan_screen.dart';
import 'package:dharma/presentation/screens/tasbih_screen.dart';
import 'package:dharma/presentation/screens/hadith_screen.dart';
import 'package:dharma/presentation/screens/allah_names_screen.dart';
import 'package:dharma/presentation/screens/recent_news_screen.dart';
import 'package:dharma/presentation/screens/meditation_screen.dart';
import 'package:dharma/presentation/screens/motivation_screen.dart';
import 'dart:ui' as ui;

class Features extends StatelessWidget {
  const Features({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {'name': 'নামাজ সময়সূচী', 'icon': FontAwesomeIcons.clock},
      {'name': 'সেহরি ইফতার', 'icon': FontAwesomeIcons.utensils},
      {'name': 'রমজান', 'icon': FontAwesomeIcons.calendarAlt},
      {'name': 'আল\'কুরান', 'icon': FontAwesomeIcons.bookOpen},
      {'name': 'আজান', 'icon': FontAwesomeIcons.volumeUp},
      {'name': 'কিবলা', 'icon': FontAwesomeIcons.compass},
      {'name': 'দান করুন', 'icon': FontAwesomeIcons.handHoldingHeart},
      {'name': 'তাসবিহ', 'icon': FontAwesomeIcons.stopwatch},
      {'name': 'হাদিস', 'icon': FontAwesomeIcons.book},
      {'name': 'আল্লাহর ৯৯ নাম', 'icon': FontAwesomeIcons.listOl},
      {'name': 'ইসলামি খবর', 'icon': FontAwesomeIcons.newspaper},
      
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemWidth = screenWidth / 4 - 16;
    final itemHeight = itemWidth * 1.3;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.01),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: itemWidth / itemHeight,
              crossAxisSpacing: screenWidth * 0.02, // Reduced horizontal spacing
              mainAxisSpacing: screenHeight * 0.01, // Reduced vertical spacing
            ),
            itemCount: features.length + 1, // +1 for the "সকল" item
            itemBuilder: (context, index) {
              if (index == features.length) {
                // "সকল" item
                return _buildFeatureItem(
                  context,
                  {'name': 'সকল', 'icon': FontAwesomeIcons.thLarge},
                  () => _showAllFeaturesModal(context),
                  itemWidth,
                  itemHeight,
                );
              } else {
                final feature = features[index];
                return _buildFeatureItem(context, feature, () {
                  switch (feature['name']) {
                    case 'নামাজ সময়সূচী':
                      _navigateWithAnimation(context, const NamazScheduleScreen());
                      break;
                    case 'সেহরি ইফতার':
                      _navigateWithAnimation(context, const SehriIftarScreen());
                      break;
                    case 'রমজান':
                      _navigateWithAnimation(context, const RamadanScreen());
                      break;
                    case 'আল\'কুরান':
                      _navigateWithAnimation(context, const QuranScreen());
                      break;
                    case 'আজান':
                      _navigateWithAnimation(context, const AdzanScreen());
                      break;
                    case 'কিবলা':
                      _navigateWithAnimation(context, const QiblaScreen());
                      break;
                    case 'দান করুন':
                      _navigateWithAnimation(context, const DonationScreen());
                      break;
                    case 'তাসবিহ':
                      _navigateWithAnimation(context, const TasbihScreen());
                      break;
                    case 'হাদিস':
                      _navigateWithAnimation(context, const HadithScreen());
                      break;
                    case 'আল্লাহর ৯৯ নাম':
                      _navigateWithAnimation(context, const AllahNamesScreen());
                      break;
                    case 'ইসলামি খবর':
                      _navigateWithAnimation(context, const RecentNewsScreen());
                      break;
                    
                  }
                }, itemWidth, itemHeight);
              }
            },
          ),
        ],
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

  Widget _buildFeatureItem(BuildContext context, Map<String, dynamic> feature,
      VoidCallback onTap, double itemWidth, double itemHeight) {
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
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                children: [
                  Material(
                    elevation: 2,
                    shadowColor: iconColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(itemWidth * 0.25),
                    child: Container(
                      padding: EdgeInsets.all(itemWidth * 0.15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(itemWidth * 0.25),
                        boxShadow: [
                          BoxShadow(
                            color: gradientColors[0].withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      // Fixed: Replaced ShaderMask with directly colored icon
                      child: Icon(
                        feature['icon'] as IconData,
                        color: Colors.white,
                        size: itemWidth * 0.45,
                      ),
                    ),
                  ),
                  SizedBox(height: itemHeight * 0.08),
                  Text(
                    feature['name'] as String,
                    style: TextStyle(
                      color: HSLColor.fromAHSL(1, hue, 0.7, 0.35).toColor(),
                      fontSize: itemWidth * 0.145,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAllFeaturesModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const AllFeaturesModal();
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        
        // Removed the BackdropFilter that was causing issues
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(curvedAnimation),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class AllFeaturesModal extends StatefulWidget {
  const AllFeaturesModal({Key? key}) : super(key: key);

  @override
  _AllFeaturesModalState createState() => _AllFeaturesModalState();
}

class _AllFeaturesModalState extends State<AllFeaturesModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final allFeatures = [
    {'name': 'আল\'কুরান', 'icon': FontAwesomeIcons.bookOpen, 'screen': QuranScreen()},
    {'name': 'আজান', 'icon': FontAwesomeIcons.volumeUp, 'screen': AdzanScreen()},
    {'name': 'কিবলা', 'icon': FontAwesomeIcons.compass, 'screen': QiblaScreen()},
    {'name': 'দান করুন', 'icon': FontAwesomeIcons.handHoldingHeart, 'screen': DonationScreen()},
    {'name': 'নামাজ সময়সূচী', 'icon': FontAwesomeIcons.clock, 'screen': NamazScheduleScreen()},
    {'name': 'সেহরি এবং ইফতার', 'icon': FontAwesomeIcons.utensils, 'screen': SehriIftarScreen()},
    {'name': 'রমজান', 'icon': FontAwesomeIcons.calendarAlt, 'screen': RamadanScreen()},
    {'name': 'তাসবিহ', 'icon': FontAwesomeIcons.stopwatch, 'screen': TasbihScreen()},
    {'name': 'হাদিস', 'icon': FontAwesomeIcons.book, 'screen': HadithScreen()},
    {'name': 'আল্লাহর ৯৯ টি নাম', 'icon': FontAwesomeIcons.listOl, 'screen': AllahNamesScreen()},
    {'name': 'ইসলামি খবর', 'icon': FontAwesomeIcons.newspaper, 'screen': const RecentNewsScreen()},
    {'name': 'দৈনিক মেডিটেশন', 'icon': FontAwesomeIcons.spa, 'screen': const MeditationScreen()},
    {'name': 'মোটিভেশন', 'icon': FontAwesomeIcons.solidLightbulb, 'screen': const MotivationScreen()},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemWidth = screenWidth / 4 - 20;
    final itemHeight = itemWidth * 1.2;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 10) {
          Navigator.of(context).pop();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.black.withOpacity(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Modify the ClipRRect and BackdropFilter approach to avoid sample count mismatch
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: screenHeight * 0.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.97),
                          Colors.white.withOpacity(0.99),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.005,
                          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(screenHeight * 0.0025),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ফিচার সমূহ',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.056,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF00BFA5),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Color(0xFF00BFA5),
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: itemWidth / itemHeight,
                              crossAxisSpacing: screenWidth * 0.03, // Reduced horizontal spacing
                              mainAxisSpacing: screenHeight * 0.005, // Reduced vertical spacing
                            ),
                            itemCount: allFeatures.length,
                            itemBuilder: (context, index) {
                              final feature = allFeatures[index];
                              
                              // Create a staggered animation for each grid item
                              return AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  final delay = (index * 0.1).clamp(0.0, 1.0);
                                  final animValue = CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(
                                      delay,
                                      1.0,
                                      curve: Curves.easeOutQuart,
                                    ),
                                  ).value;
                                  
                                  return Transform.scale(
                                    scale: 0.5 + (0.5 * animValue),
                                    child: Opacity(
                                      opacity: animValue,
                                      child: child,
                                    ),
                                  );
                                },
                                child: _buildFeatureGridItem(
                                  context,
                                  feature,
                                  itemWidth,
                                  itemHeight,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureGridItem(BuildContext context, Map<String, Object?> feature, double itemWidth, double itemHeight) {
    // Create gradient colors that have a consistent theme but slight variations
    final int index = allFeatures.indexWhere((item) => 
        item['name'] == feature['name'] && 
        item['icon'] == feature['icon']);
    final hue = (index >= 0 ? index : 0) * 30 % 360;
    
    final List<Color> gradientColors = [
      HSLColor.fromAHSL(1, hue.toDouble(), 0.8, 0.55).toColor(),
      HSLColor.fromAHSL(1, hue.toDouble(), 0.9, 0.45).toColor(),
    ];
    
    final Color textColor = HSLColor.fromAHSL(1, hue.toDouble(), 0.7, 0.35).toColor();
    
    return Hero(
      tag: 'all_feature_${feature['name']}',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            _navigateToFeatureScreen(context, feature['screen'] as Widget);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(itemWidth * 0.15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(itemWidth * 0.25),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                // Fixed: Replaced ShaderMask with directly colored icon
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.white,  
                  size: itemWidth * 0.45,
                ),
              ),
              SizedBox(height: itemHeight * 0.08),
              Text(
                feature['name'] as String,
                style: TextStyle(
                  color: textColor,
                  fontSize: itemWidth * 0.145,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFeatureScreen(BuildContext context, Widget screen) {
    // Use a simpler transition that doesn't involve BackdropFilter
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          
          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
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
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:dharma/presentation/screens/quran_screen.dart';
// import 'package:dharma/presentation/screens/adzan_screen.dart';
// import 'package:dharma/presentation/screens/qibla_screen.dart';
// import 'package:dharma/presentation/screens/donation_screen.dart';
// import 'package:dharma/presentation/screens/namaz_schedule_screen.dart';
// import 'package:dharma/presentation/screens/sehri_iftar_screen.dart';
// import 'package:dharma/presentation/screens/ramadan_screen.dart';
// import 'package:dharma/presentation/screens/tasbih_screen.dart';
// import 'package:dharma/presentation/screens/hadith_screen.dart';
// import 'package:dharma/presentation/screens/allah_names_screen.dart';
// import 'package:dharma/presentation/screens/recent_news_screen.dart';

// class Features extends StatelessWidget {
//   const Features({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final features = [
//       {'name': 'নামাজ সময়সূচী', 'icon': FontAwesomeIcons.clock},
//       {'name': 'সেহরি ইফতার', 'icon': FontAwesomeIcons.utensils},
//       {'name': 'রমজান', 'icon': FontAwesomeIcons.calendarAlt},
//       {'name': 'আল\'কুরান', 'icon': FontAwesomeIcons.bookOpen},
//       {'name': 'আজান', 'icon': FontAwesomeIcons.volumeUp},
//       {'name': 'কিবলা', 'icon': FontAwesomeIcons.compass},
//       {'name': 'দান করুন', 'icon': FontAwesomeIcons.handHoldingHeart},
//       {'name': 'তাসবিহ', 'icon': FontAwesomeIcons.stopwatch},
//       {'name': 'হাদিস', 'icon': FontAwesomeIcons.book},
//       {'name': 'আল্লাহর ৯৯ নাম', 'icon': FontAwesomeIcons.listOl},
//       {'name': 'ইসলামি খবর', 'icon': FontAwesomeIcons.newspaper},
//     ];

//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final itemWidth = screenWidth / 4 - 16;
//     final itemHeight = itemWidth * 1.3;

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: screenHeight * 0.01),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               childAspectRatio: itemWidth / itemHeight,
//               crossAxisSpacing: screenWidth * 0.04,
//               mainAxisSpacing: screenHeight * 0.01,
//             ),
//             itemCount: features.length + 1, // +1 for the "সকল" item
//             itemBuilder: (context, index) {
//               if (index == features.length) {
//                 // "সকল" item
//                 return _buildFeatureItem(
//                   context,
//                   {'name': 'সকল', 'icon': FontAwesomeIcons.thLarge},
//                   () => _showAllFeaturesModal(context),
//                   itemWidth,
//                   itemHeight,
//                 );
//               } else {
//                 final feature = features[index];
//                 return _buildFeatureItem(context, feature, () {
//                   switch (feature['name']) {
//                     case 'নামাজ সময়সূচী':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const NamazScheduleScreen()));
//                       break;
//                     case 'সেহরি ইফতার':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const SehriIftarScreen()));
//                       break;
//                     case 'রমজান':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RamadanScreen()));
//                       break;
//                     case 'আল\'কুরান':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const QuranScreen()));
//                       break;
//                     case 'আজান':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AdzanScreen()));
//                       break;
//                     case 'কিবলা':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const QiblaScreen()));
//                       break;
//                     case 'দান করুন':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const DonationScreen()));
//                       break;
//                     case 'তাসবিহ':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const TasbihScreen()));
//                       break;
//                     case 'হাদিস':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HadithScreen()));
//                       break;
//                     case 'আল্লাহর ৯৯ নাম':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const AllahNamesScreen()));
//                       break;
//                     case 'ইসলামি খবর':
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RecentNewsScreen()));
//                       break;
//                   }
//                 }, itemWidth, itemHeight);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeatureItem(BuildContext context, Map<String, dynamic> feature,
//       VoidCallback onTap, double itemWidth, double itemHeight) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(itemWidth * 0.2),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00BFA5).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(itemWidth * 0.2),
//             ),
//             child: Icon(
//               feature['icon'] as IconData,
//               color: const Color(0xFF00BFA5),
//               size: itemWidth * 0.4,
//             ),
//           ),
//           SizedBox(height: itemHeight * 0.1),
//           Text(
//             feature['name'] as String,
//             style: TextStyle(
//               color: const Color(0xFF00BFA5),
//               fontSize: itemWidth * 0.14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAllFeaturesModal(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       pageBuilder: (BuildContext buildContext, Animation<double> animation,
//           Animation<double> secondaryAnimation) {
//         return const AllFeaturesModal();
//       },
//       barrierDismissible: true,
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: const Duration(milliseconds: 400),
//       transitionBuilder: (context, animation, secondaryAnimation, child) {
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0, 1),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );
//       },
//     );
//   }
// }

// class AllFeaturesModal extends StatefulWidget {
//   const AllFeaturesModal({Key? key}) : super(key: key);

//   @override
//   _AllFeaturesModalState createState() => _AllFeaturesModalState();
// }

// class _AllFeaturesModalState extends State<AllFeaturesModal> {
//   final allFeatures = [
//     {'name': 'আল\'কুরান', 'icon': FontAwesomeIcons.bookOpen, 'screen': QuranScreen()},
//     {'name': 'আজান', 'icon': FontAwesomeIcons.volumeUp, 'screen': AdzanScreen()},
//     {'name': 'কিবলা', 'icon': FontAwesomeIcons.compass, 'screen': QiblaScreen()},
//     {'name': 'দান করুন', 'icon': FontAwesomeIcons.handHoldingHeart, 'screen': DonationScreen()},
//     {'name': 'নামাজ সময়সূচী', 'icon': FontAwesomeIcons.clock, 'screen': NamazScheduleScreen()},
//     {'name': 'সেহরি এবং ইফতার', 'icon': FontAwesomeIcons.utensils, 'screen': SehriIftarScreen()},
//     {'name': 'রমজান', 'icon': FontAwesomeIcons.calendarAlt, 'screen': RamadanScreen()},
//     {'name': 'তাসবিহ', 'icon': FontAwesomeIcons.stopwatch, 'screen': TasbihScreen()},
//     {'name': 'হাদিস', 'icon': FontAwesomeIcons.book, 'screen': HadithScreen()},
//     {'name': 'আল্লাহর ৯৯ টি নাম', 'icon': FontAwesomeIcons.listOl, 'screen': AllahNamesScreen()},
//     {'name': 'ইসলামি খবর', 'icon': FontAwesomeIcons.newspaper, 'screen': const RecentNewsScreen()},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final itemWidth = screenWidth / 4 - 16;
//     final itemHeight = itemWidth * 1.2;

//     return GestureDetector(
//       onVerticalDragUpdate: (details) {
//         if (details.primaryDelta! > 10) {
//           Navigator.of(context).pop();
//         }
//       },
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           color: Colors.black.withOpacity(0.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 height: screenHeight * 0.8,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: screenWidth * 0.1,
//                       height: screenHeight * 0.005,
//                       margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(screenHeight * 0.0025),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(screenWidth * 0.04),
//                       child: Text(
//                         'ফিচার সমূহ',
//                         style: TextStyle(
//                           fontSize: screenWidth * 0.05,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF00BFA5),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: GridView.builder(
//                         padding: EdgeInsets.all(screenWidth * 0.04),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 4,
//                           childAspectRatio: itemWidth / itemHeight,
//                           crossAxisSpacing: screenWidth * 0.04,
//                           mainAxisSpacing: screenHeight * 0.01,
//                         ),
//                         itemCount: allFeatures.length,
//                         itemBuilder: (context, index) {
//                           final feature = allFeatures[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                               _navigateToFeatureScreen(
//                                   context, feature['screen'] as Widget);
//                             },
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.all(itemWidth * 0.2),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFF00BFA5).withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(itemWidth * 0.2),
//                                   ),
//                                   child: Icon(
//                                     feature['icon'] as IconData,
//                                     color: const Color(0xFF00BFA5),
//                                     size: itemWidth * 0.4,
//                                   ),
//                                 ),
//                                 SizedBox(height: itemHeight * 0.1),
//                                 Text(
//                                   feature['name'] as String,
//                                   style: TextStyle(
//                                     color: const Color(0xFF00BFA5),
//                                     fontSize: itemWidth * 0.14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _navigateToFeatureScreen(BuildContext context, Widget screen) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => screen,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(1.0, 0.0);
//           const end = Offset.zero;
//           const curve = Curves.easeInOut;
//           var tween =
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);
//           return SlideTransition(position: offsetAnimation, child: child);
//         },
//       ),
//     );
//   }
// }
