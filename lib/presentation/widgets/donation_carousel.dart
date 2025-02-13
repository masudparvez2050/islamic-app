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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: screenHeight * 0.138,
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
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00BFA5).withOpacity(0.3),
                    width: screenWidth * 0.0025,
                  ),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _slides[index]['text']!,
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF00BFA5),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            _slides[index]['subText']!,
                            style: TextStyle(
                              fontSize: screenWidth * 0.0360,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
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
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                      child: Text(
                        'অনুদান দিন',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.037,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _slides.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              width: screenWidth * 0.02,
              height: screenWidth * 0.02,
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
