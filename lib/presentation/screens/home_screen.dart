import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/header.dart';
import 'package:religion/presentation/widgets/time_display.dart';
import 'package:religion/presentation/widgets/prayer_times.dart';
import 'package:religion/presentation/widgets/features.dart';
import 'package:religion/presentation/widgets/top_features.dart';
import 'package:religion/presentation/widgets/donation_carousel.dart';
import 'package:religion/presentation/widgets/add_1.dart';
import 'package:religion/presentation/widgets/add_2.dart';
import 'package:religion/presentation/widgets/text_slide.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

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
                          ? _buildPortraitContent(width, height)
                          : _buildLandscapeContent(width, height),
                    ),
                  ],
                );
              },
            ),
          ),
          Advertisement2(),
        ],
      ),
    );
  }

  /// Builds UI for Portrait Mode
  Widget _buildPortraitContent(double width, double height) {
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
              SizedBox(height: height * 0.01),
              const Advertisement1(),
              SizedBox(height: height * 0.01),
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
                    children: [
                      TextSlide(),
                      TopFeatures(),
                      SizedBox(height: height * 0.02),
                      Features(),
                      SizedBox(height: height * 0.02),
                      DonationCarousel(),
                      SizedBox(height: height * 0.07), // Add padding for bottom nav bar
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds UI for Landscape Mode
  Widget _buildLandscapeContent(double width, double height) {
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
                SizedBox(height: height * 0.01),
                const Advertisement1(),
                SizedBox(height: height * 0.02),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextSlide(),
                      TopFeatures(),
                      SizedBox(height: height * 0.02),
                      Features(),
                      SizedBox(height: height * 0.02),
                      DonationCarousel(),
                      SizedBox(height: height * 0.07), // Add padding for bottom nav bar
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
