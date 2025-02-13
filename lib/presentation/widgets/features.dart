import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/quran_screen.dart';
import 'package:religion/presentation/screens/adzan_screen.dart';
import 'package:religion/presentation/screens/qibla_screen.dart';
import 'package:religion/presentation/screens/donation_screen.dart';
import 'package:religion/presentation/screens/namaz_schedule_screen.dart';
import 'package:religion/presentation/screens/sehri_iftar_screen.dart';
import 'package:religion/presentation/screens/ramadan_screen.dart';
import 'package:religion/presentation/screens/tasbih_screen.dart';
import 'package:religion/presentation/screens/hadith_screen.dart';
import 'package:religion/presentation/screens/allah_names_screen.dart';
import 'package:religion/presentation/screens/recent_news_screen.dart';

class Features extends StatelessWidget {
  const Features({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {'name': 'নামাজ সময়সূচী', 'icon': Icons.schedule},
      {'name': 'সেহরি ইফতার', 'icon': Icons.restaurant_menu},
      {'name': 'রমজান', 'icon': Icons.calendar_today},
      {'name': 'আল\'কুরান', 'icon': Icons.book},
      {'name': 'আজান', 'icon': Icons.volume_up},
      {'name': 'কিবলা', 'icon': Icons.explore},
      {'name': 'দান করুন', 'icon': Icons.favorite},
      {'name': 'তাসবিহ', 'icon': Icons.repeat},
      {'name': 'হাদিস', 'icon': Icons.library_books},
      {'name': 'আল্লাহর ৯৯ টি নাম', 'icon': Icons.format_list_numbered},
      {'name': 'সাম্প্রতিক খবর', 'icon': Icons.newspaper},
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
              crossAxisCount:4 ,
              childAspectRatio: itemWidth / itemHeight,
              crossAxisSpacing: screenWidth * 0.04,
              mainAxisSpacing: screenHeight * 0.01,
            ),
            itemCount: features.length + 1, // +1 for the "সকল" item
            itemBuilder: (context, index) {
              if (index == features.length) {
                // "সকল" item
                return _buildFeatureItem(
                  context,
                  {'name': 'সকল', 'icon': Icons.grid_view},
                  () => _showAllFeaturesModal(context),
                  itemWidth,
                  itemHeight,
                );
              } else {
                final feature = features[index];
                return _buildFeatureItem(context, feature, () {
                  switch (feature['name']) {
                    case 'নামাজ সময়সূচী':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NamazScheduleScreen()));
                      break;
                    case 'সেহরি ইফতার':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SehriIftarScreen()));
                      break;
                    case 'রমজান':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RamadanScreen()));
                      break;
                    case 'আল\'কুরান':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuranScreen()));
                      break;
                    case 'আজান':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdzanScreen()));
                      break;
                    case 'কিবলা':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QiblaScreen()));
                      break;
                    case 'দান করুন':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DonationScreen()));
                      break;
                    case 'তাসবিহ':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TasbihScreen()));
                      break;
                    case 'হাদিস':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HadithScreen()));
                      break;
                    case 'আল্লাহর ৯৯ টি নাম':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllahNamesScreen()));
                      break;
                    case 'সাম্প্রতিক খবর':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RecentNewsScreen()));
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

  Widget _buildFeatureItem(BuildContext context, Map<String, dynamic> feature,
      VoidCallback onTap, double itemWidth, double itemHeight) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(itemWidth * 0.2),
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(itemWidth * 0.2),
            ),
            child: Icon(
              feature['icon'] as IconData,
              color: const Color(0xFF00BFA5),
              size: itemWidth * 0.4,
            ),
          ),
          SizedBox(height: itemHeight * 0.1),
          Text(
            feature['name'] as String,
            style: TextStyle(
              color: const Color(0xFF00BFA5),
              fontSize: itemWidth * 0.14,
            ),
          ),
        ],
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
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
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

class _AllFeaturesModalState extends State<AllFeaturesModal> {
  final allFeatures = [
    {'name': 'আল\'কুরান', 'icon': Icons.book, 'screen': QuranScreen()},
    {'name': 'আজান', 'icon': Icons.volume_up, 'screen': AdzanScreen()},
    {'name': 'কিবলা', 'icon': Icons.explore, 'screen': QiblaScreen()},
    {'name': 'দান করুন', 'icon': Icons.favorite, 'screen': DonationScreen()},
    {'name': 'নামাজ সময়সূচী', 'icon': Icons.schedule, 'screen': NamazScheduleScreen()},
    {'name': 'সেহরি এবং ইফতার', 'icon': Icons.restaurant_menu, 'screen': SehriIftarScreen()},
    {'name': 'রমজান', 'icon': Icons.calendar_today, 'screen': RamadanScreen()},
    {'name': 'তাসবিহ', 'icon': Icons.repeat, 'screen': TasbihScreen()},
    {'name': 'হাদিস', 'icon': Icons.library_books, 'screen': HadithScreen()},
    {'name': 'আল্লাহর ৯৯ টি নাম', 'icon': Icons.format_list_numbered, 'screen': AllahNamesScreen()},
    {'name': 'সাম্প্রতিক খবর', 'icon': Icons.newspaper, 'screen': const RecentNewsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemWidth = screenWidth / 4 - 16;
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
              Container(
                height: screenHeight * 0.8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.1,
                      height: screenHeight * 0.005,
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(screenHeight * 0.0025),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Text(
                        'ফিচার সমূহ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: itemWidth / itemHeight,
                          crossAxisSpacing: screenWidth * 0.04,
                          mainAxisSpacing: screenHeight * 0.01,
                        ),
                        itemCount: allFeatures.length,
                        itemBuilder: (context, index) {
                          final feature = allFeatures[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              _navigateToFeatureScreen(
                                  context, feature['screen'] as Widget);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(itemWidth * 0.2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00BFA5).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(itemWidth * 0.2),
                                  ),
                                  child: Icon(
                                    feature['icon'] as IconData,
                                    color: const Color(0xFF00BFA5),
                                    size: itemWidth * 0.4,
                                  ),
                                ),
                                SizedBox(height: itemHeight * 0.1),
                                Text(
                                  feature['name'] as String,
                                  style: TextStyle(
                                    color: const Color(0xFF00BFA5),
                                    fontSize: itemWidth * 0.14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFeatureScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
