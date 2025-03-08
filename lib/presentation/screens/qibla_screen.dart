import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:religion/presentation/widgets/common/headerAdzan.dart'; // Assuming similar header structure

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  _QiblaScreenState createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double? qiblaDirection; // Angle to Qibla from user's location
  double? heading; // Device heading from compass
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQiblaDirection();
    _startCompassListener();
  }

  Future<void> _fetchQiblaDirection() async {
    try {
      Position position = await _determinePosition();
      // Kaaba coordinates (Mecca)
      const double kaabaLat = 21.4225;
      const double kaabaLon = 39.8262;

      // Calculate Qibla direction
      qiblaDirection = Geolocator.bearingBetween(
        position.latitude,
        position.longitude,
        kaabaLat,
        kaabaLon,
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching location: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _startCompassListener() {
    FlutterCompass.events?.listen((CompassEvent event) {
      if (mounted) {
        setState(() {
          heading = event.heading; // Update heading dynamically
        });
      }
    });
  }

  String _getDirectionText(double? angle) {
    if (angle == null) return 'দিক নির্ধারণ করা যায়নি';
    angle = angle % 360;
    if (angle >= 337.5 || angle < 22.5) return 'উত্তর';
    if (angle >= 22.5 && angle < 67.5) return 'উত্তর-পূর্ব';
    if (angle >= 67.5 && angle < 112.5) return 'পূর্ব';
    if (angle >= 112.5 && angle < 157.5) return 'দক্ষিণ-পূর্ব';
    if (angle >= 157.5 && angle < 202.5) return 'দক্ষিণ';
    if (angle >= 202.5 && angle < 247.5) return 'দক্ষিণ-পশ্চিম';
    if (angle >= 247.5 && angle < 292.5) return 'পশ্চিম';
    if (angle >= 292.5 && angle < 337.5) return 'উত্তর-পশ্চিম';
    return 'দিক নির্ধারণ করা যায়নি';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveHeader(title: 'কিবলার দিক'),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'কিবলার দিক',
                  //   style: TextStyle(
                  //     fontSize: screenWidth * 0.06, // 6% of screen width
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: screenHeight * 0.03), // 3% of screen height
                  Container(
                    width: screenWidth * 0.7, // 50% of screen width
                    height: screenWidth * 0.7,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   border: Border.all(color: const Color(0xFF00BFA5), width: screenWidth * 0.005),
                    // ),
                    child: Center(
                      child: Transform.rotate(
                        angle: heading != null && qiblaDirection != null
                            ? (qiblaDirection! - heading!) * math.pi / 180 // Convert to radians
                            : 0,
                        child: Image.asset(
                          'assets/images/kaaba.png', // Add your Kaaba image in assets
                          width: screenWidth * 1.25, // 25% of screen width
                          height: screenWidth * 1.25,
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: screenHeight * 0.03),
                    Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: 'আপনার অবস্থান থেকে কিবলার দিক ',
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
      ),
      TextSpan(
        text: qiblaDirection != null ? _getDirectionText(qiblaDirection) : 'দিক গণনা হচ্ছে...',
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          decoration: qiblaDirection != null ? TextDecoration.underline : TextDecoration.none,
          decorationThickness: 5.0,
        ),
      ),
    ],
  ),
),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    'কিবলার দিকে নামাজ পড়তে ${qiblaDirection != null ? _getDirectionText(qiblaDirection) : 'দিক নির্ধারণ করা যায়নি'} মুখ করুন',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
            ),
    );
  }
}