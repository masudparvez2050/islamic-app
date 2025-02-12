import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/donation_screen.dart';

class DonationCarousel extends StatefulWidget {
  const DonationCarousel({Key? key}) : super(key: key);

  @override
  State<DonationCarousel> createState() => _DonationCarouselState();
}

class _DonationCarouselState extends State<DonationCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'text': ' আর্থিক অনুদান দিন',
      'subText': 'যাকাত-ফিতরা দেয়া যাবে না। সাধারন অনুদান দিতে পারেন',
    },
    {
      'text': 'সদকা করুন, জান্নাত লাভ করুন',
      'subText': 'আপনার সদকা মুসলিম উম্মাহর জন্য সহায়ক হবে',
    },
    {
      'text': 'ইসলামিক শিক্ষা প্রসারে সহযোগিতা করুন',
      'subText': 'আপনার অনুদান ইসলামিক শিক্ষা বিস্তারে সহায়ক হবে',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00BFA5).withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _slides[index]['text']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF00BFA5),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _slides[index]['subText']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFA5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'অনুদান দিন',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _slides.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? const Color(0xFF00BFA5)
                    : Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
