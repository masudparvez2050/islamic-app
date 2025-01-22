import 'package:flutter/material.dart';
import 'package:islam_app/presentation/widgets/header.dart';
import 'package:islam_app/presentation/widgets/time_display.dart';
import 'package:islam_app/presentation/widgets/prayer_times.dart';
import 'package:islam_app/presentation/widgets/ramadan_info.dart';
import 'package:islam_app/presentation/widgets/features.dart';
import 'package:islam_app/presentation/widgets/donation_carousel.dart';
import 'package:islam_app/presentation/widgets/book_library.dart';
import 'package:islam_app/presentation/widgets/video_gallery.dart';
import 'package:islam_app/presentation/widgets/ngaji_section.dart';
import 'package:islam_app/presentation/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                const PrayerTimes(),
              ],
            ),
            const RamadanInfo(),
            const SizedBox(height: 20),
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
                  children: const [
                    Features(),
                    DonationCarousel(),
                    SizedBox(height: 16),
                    BookLibrary(),
                    VideoGallery(),
                    NgajiSection(),
                  ],
                ),
              ),
            ),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
