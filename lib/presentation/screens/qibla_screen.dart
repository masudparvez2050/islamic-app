import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  _QiblaScreenState createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> with SingleTickerProviderStateMixin {
  double? qiblaDirection; // Angle to Qibla from user's location
  double? heading; // Device heading from compass
  bool isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _fetchQiblaDirection();
    _startCompassListener();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

    // Modern color scheme
    const Color primaryColor = Color(0xFF3D5AFE);
    const Color accentColor = Color(0xFF00E5FF);
    const Color backgroundColor = Color(0xFFF8F9FF);
    const Color cardColor = Colors.white;
    const Color textColor = Color(0xFF2C3E50);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'কিবলার দিক',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05, // 5% of screen width
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: textColor,
            size: screenWidth * 0.06, // 6% of screen width
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.125, // 12.5% of screen width
                    height: screenWidth * 0.125, // 12.5% of screen width
                    child: CircularProgressIndicator(
                      strokeWidth: screenWidth * 0.0075, // 0.75% of screen width
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025), // 2.5% of screen height
                  Text(
                    'আপনার অবস্থান নির্ধারণ করা হচ্ছে...',
                    style: TextStyle(
                      color: textColor.withOpacity(0.8),
                      fontSize: screenWidth * 0.04, // 4% of screen width
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : FadeTransition(
              opacity: _animation,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // 6% of screen width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.05), // 5% of screen height
                    // Compass Card
                    Container(
                      width: screenWidth * 0.88, // 88% of screen width
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(screenWidth * 0.06), // 6% of screen width
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: screenWidth * 0.05, // 5% of screen width
                            offset: Offset(0, screenHeight * 0.0125), // 1.25% of screen height
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.05), // 5% of screen width
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(screenWidth * 0.025), // 2.5% of screen width
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(screenWidth * 0.03), // 3% of screen width
                                  ),
                                  child: Icon(
                                    Icons.compass_calibration_rounded,
                                    color: primaryColor,
                                    size: screenWidth * 0.06, // 6% of screen width
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03), // 3% of screen width
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'কিবলার দিক',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: screenWidth * 0.045, // 4.5% of screen width
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'মক্কার দিকে',
                                      style: TextStyle(
                                        color: textColor.withOpacity(0.6),
                                        fontSize: screenWidth * 0.035, // 3.5% of screen width
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03, // 3% of screen width
                                    vertical: screenHeight * 0.0075, // 0.75% of screen height
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(screenWidth * 0.05), // 5% of screen width
                                  ),
                                  child: Text(
                                    qiblaDirection != null
                                        ? '${qiblaDirection!.toStringAsFixed(1)}°'
                                        : 'N/A',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.035, // 3.5% of screen width
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: screenHeight * 0.00125, // 0.125% of screen height
                            thickness: screenWidth * 0.0025, // 0.25% of screen width
                            indent: screenWidth * 0.05, // 5% of screen width
                            endIndent: screenWidth * 0.05, // 5% of screen width
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.06), // 6% of screen width
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Compass ring
                                Container(
                                  width: screenWidth * 0.7, // 70% of screen width
                                  height: screenWidth * 0.7, // 70% of screen width
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: screenWidth * 0.02, // 2% of screen width
                                    ),
                                  ),
                                ),
                                // Inner circle
                                Container(
                                  width: screenWidth * 0.6, // 60% of screen width
                                  height: screenWidth * 0.6, // 60% of screen width
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.05),
                                  ),
                                ),
                               
                                // Kaaba indicator with rotation
                                TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: heading != null && qiblaDirection != null
                                        ? (qiblaDirection! - heading!) * math.pi / 180
                                        : 0,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic,
                                  builder: (_, angle, __) {
                                    return Transform.rotate(
                                      angle: angle,
                                        child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: screenHeight * 0.00625), // 0.625% of screen height
                                          Container(
                                          padding: EdgeInsets.all(screenWidth * 0.05), // Reduced padding
                                          decoration: const BoxDecoration(
                                            color: Colors.teal,
                                            shape: BoxShape.circle, // Changed to circle shape
                                          ),
                                          child: Image.asset(
                                            'assets/images/kaaba1.png',
                                            width: screenWidth * 0.55, // 15% of screen width
                                            height: screenWidth * 0.55, // 15% of screen width
                                            color: Colors.white,
                                          ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.04), // 4% of screen height

                    // Direction info card
                    Container(
                      width: screenWidth * 0.88, // 88% of screen width
                      padding: EdgeInsets.all(screenWidth * 0.05), // 5% of screen width
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(screenWidth * 0.06), // 6% of screen width
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: screenWidth * 0.05, // 5% of screen width
                            offset: Offset(0, screenHeight * 0.0125), // 1.25% of screen height
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'কিবলার দিক',
                            style: TextStyle(
                              color: textColor.withOpacity(0.6),
                              fontSize: screenWidth * 0.035, // 3.5% of screen width
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01), // 1% of screen height
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.025), // 2.5% of screen width
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03), // 3% of screen width
                                ),
                                child: Icon(
                                  Icons.navigation_rounded,
                                  color: accentColor,
                                  size: screenWidth * 0.06, // 6% of screen width
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04), // 4% of screen width
                              Text(
                                qiblaDirection != null
                                    ? _getDirectionText(qiblaDirection)
                                    : 'দিক গণনা হচ্ছে...',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: screenWidth * 0.055, // 5.5% of screen width
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02), // 2% of screen height
                          Text(
                            'কিবলার দিকে নামাজ পড়তে ${qiblaDirection != null ? _getDirectionText(qiblaDirection) : 'দিক নির্ধারণ করা যায়নি'} মুখ করুন',
                            style: TextStyle(
                              color: textColor.withOpacity(0.8),
                              fontSize: screenWidth * 0.0375, // 3.75% of screen width
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Calibration button at bottom
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.0375), // 3.75% of screen height
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          _fetchQiblaDirection().then((_) {
                            _animationController.reset();
                            _animationController.forward();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06, // 6% of screen width
                            vertical: screenHeight * 0.01875, // 1.875% of screen height
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.04), // 4% of screen width
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: screenWidth * 0.05, // 5% of screen width
                            ),
                            SizedBox(width: screenWidth * 0.02), // 2% of screen width
                            Text(
                              'কম্পাস ক্যালিব্রেট করুন',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04, // 4% of screen width
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}