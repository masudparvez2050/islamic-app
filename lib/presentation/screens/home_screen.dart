import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/header.dart';
import 'package:religion/presentation/widgets/time_display.dart';
import 'package:religion/presentation/widgets/prayer_times.dart';
import 'package:religion/presentation/widgets/ramadan_info.dart';
import 'package:religion/presentation/widgets/features.dart';
import 'package:religion/presentation/widgets/donation_carousel.dart';
import 'package:religion/presentation/widgets/book_library.dart';
import 'package:religion/presentation/widgets/video_gallery.dart';
import 'package:religion/presentation/widgets/recent_news.dart';
import 'package:religion/presentation/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Column(
              children: [
                Expanded(
                  child: orientation == Orientation.portrait
                      ? _buildPortraitContent()
                      : _buildLandscapeContent(),
                ),
                const BottomNavBar(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortraitContent() {
    return Column(
      children: [
        const Header(),
        const TimeDisplay(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -400,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/home_bg.png',
                  color: const Color.fromARGB(255, 3, 70, 44).withOpacity(0.1),
                  height: 1200,
                  width: double.infinity,
                ),
              ),
            ),
            const PrayerTimesWidget(),
          ],
        ),
        const RamadanInfo(),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                Features(),
                DonationCarousel(),
                SizedBox(height: 16),
                BookLibrary(),
                VideoGallery(),
                RecentNews(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Header(),
          const TimeDisplay(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -400,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/home_bg.png',
                    color:
                        const Color.fromARGB(255, 3, 70, 44).withOpacity(0.1),
                    height: 1200,
                    width: double.infinity,
                  ),
                ),
              ),
              const PrayerTimesWidget(),
            ],
          ),
          const RamadanInfo(),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: const [
                Features(),
                DonationCarousel(),
                SizedBox(height: 16),
                BookLibrary(),
                VideoGallery(),
                RecentNews(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
