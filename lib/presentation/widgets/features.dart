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
              return GestureDetector(
                onTap: () {
                  if (feature['name'] == 'All') {
                    _showAllFeaturesModal(context);
                  } else {
                    // Handle other feature taps
                    print('Tapped on ${feature['name']}');
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
      transitionDuration: const Duration(milliseconds: 500),
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

class AllFeaturesModal extends StatelessWidget {
  const AllFeaturesModal({super.key});

  @override
  Widget build(BuildContext context) {
    final allFeatures = [
      {'name': 'Quran', 'icon': Icons.book},
      {'name': 'Adzan', 'icon': Icons.volume_up},
      {'name': 'Qibla', 'icon': Icons.explore},
      {'name': 'Donation', 'icon': Icons.favorite},
      {'name': 'Namaj schedule', 'icon': Icons.schedule},
      {'name': 'Sehri & Iftar', 'icon': Icons.restaurant_menu},
      {'name': 'Ramadan', 'icon': Icons.calendar_today},
      {'name': 'Tajbih', 'icon': Icons.repeat},
      {'name': 'Hadith', 'icon': Icons.library_books},
      {'name': 'Allah\'s 99 Name', 'icon': Icons.format_list_numbered},
    ];

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          color: Colors.black.withOpacity(0.0),
          child: GestureDetector(
            onTap: () {}, // Prevents taps from closing the modal
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
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'All Features',
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
                            return Column(
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
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
      ),
    );
  }
}
