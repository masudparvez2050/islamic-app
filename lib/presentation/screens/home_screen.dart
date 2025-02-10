import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/header.dart';
import 'package:religion/presentation/widgets/time_display.dart';
import 'package:religion/presentation/widgets/prayer_times.dart';
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
      body: Stack(
        children: [
          SafeArea(
            child: OrientationBuilder(
              builder: (context, orientation) {
                return Column(
                  children: [
                    Expanded(
                      child: orientation == Orientation.portrait
                          ? _buildPortraitContent()
                          : _buildLandscapeContent(),
                    ),
                  ],
                );
              },
            ),
          ),
          // const BottomNavBar(),
        ],
      ),
    );
  }

  /// Builds UI for Portrait Mode
  Widget _buildPortraitContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          
          decoration: BoxDecoration(
            
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.png'),
              fit: BoxFit.contain,
              
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 3, 70, 44).withOpacity(0.1),
                BlendMode.srcIn,
              ),
            ),
          ),
          child: Column(
            children: [
              const Header(),
              const TimeDisplay(),
             
 
              const PrayerTimesWidget(), 
             
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
                      
                      SizedBox(height: 16),
                      BookLibrary(),
                      VideoGallery(),
                      RecentNews(),
                      DonationCarousel(),
                      SizedBox(height: 70), // Add padding for bottom nav bar
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  /// Builds UI for Landscape Mode
  Widget _buildLandscapeContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter, // Move the image to the top
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 3, 70, 44).withOpacity(0.1),
                BlendMode.srcIn,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                const TimeDisplay(),
 
                const PrayerTimesWidget(),
                
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
                      
                      SizedBox(height: 16),
                      BookLibrary(),
                      VideoGallery(),
                      RecentNews(),
                      DonationCarousel(),
                      SizedBox(height: 70), // Add padding for bottom nav bar
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
