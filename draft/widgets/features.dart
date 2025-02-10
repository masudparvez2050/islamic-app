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

class Features extends StatelessWidget {
  const Features({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final features = [
      {'name': 'নামাজ সময়সূচী', 'icon': Icons.schedule},
      {'name': 'সেহরি ইফতার', 'icon': Icons.restaurant_menu},
      {'name': 'রমজান', 'icon': Icons.calendar_today},
      {'name': 'আল\'কুরান', 'icon': Icons.book},
      {'name': 'সকল', 'icon': Icons.grid_view},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ফিচার সমূহ',
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
              return GestureDetector(
                onTap: () {
                  if (feature['name'] == 'সকল') {
                    _showAllFeaturesModal(context);
                  } else {
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
                    }
                  }
                },
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
              );
            }).toList(),
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
    {
      'name': 'নামাজ সময়সূচী',
      'icon': Icons.schedule,
      'screen': NamazScheduleScreen()
    },
    {
      'name': 'সেহরি এবং ইফতার',
      'icon': Icons.restaurant_menu,
      'screen': SehriIftarScreen()
    },
    {'name': 'রমজান', 'icon': Icons.calendar_today, 'screen': RamadanScreen()},
    {'name': 'তাসবিহ', 'icon': Icons.repeat, 'screen': TasbihScreen()},
    {'name': 'হাদিস', 'icon': Icons.library_books, 'screen': HadithScreen()},
    {
      'name': 'আল্লাহর ৯৯ টি নাম',
      'icon': Icons.format_list_numbered,
      'screen': AllahNamesScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.8,
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
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'ফিচার সমূহ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BFA5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
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
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00BFA5)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    feature['icon'] as IconData,
                                    color: const Color(0xFF00BFA5),
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  feature['name'] as String,
                                  style: const TextStyle(
                                    color: Color(0xFF00BFA5),
                                    fontSize: 12,
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
