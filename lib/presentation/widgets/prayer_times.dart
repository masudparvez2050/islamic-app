import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math' as math;

class PrayerTimesWidget extends StatefulWidget {
  const PrayerTimesWidget({Key? key}) : super(key: key);

  @override
  _PrayerTimesWidgetState createState() => _PrayerTimesWidgetState();
}

class _PrayerTimesWidgetState extends State<PrayerTimesWidget> with SingleTickerProviderStateMixin {
  double get screenHeight => MediaQuery.of(context).size.height;
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  Timer? _timer;
  bool _isLoading = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startTimer();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _updatePrayerTimes();
      });
    } catch (e) {
      print("Error getting location: $e");
      _updatePrayerTimes(); // Use default location
    }
  }

  void _updatePrayerTimes() {
    final coordinates = Coordinates(
      _currentPosition?.latitude ?? 23.8103,
      _currentPosition?.longitude ?? 90.4125,
    );
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final newPrayerTimes = PrayerTimes.today(coordinates, params);

    setState(() {
      _prayerTimes = newPrayerTimes;
      _isLoading = false;
    });
  }

  String _getTimeRemaining() {
    if (_prayerTimes == null) return '--:--';

    final now = DateTime.now();
    final nextPrayerTime = _getNextPrayerTime();
    if (nextPrayerTime == null) return '--:--';

    final difference = nextPrayerTime.difference(now);
    final hours = difference.inHours;
    final hourString = hours > 0 ? '${_convertToBanglaNumber(hours)} ঘণ্টা ' : '';
    final minutes = difference.inMinutes % 60;
    return '$hourString${_convertToBanglaNumber(minutes)} মিনিট';
  }

  String _convertToBanglaNumber(int number) {
    const englishToBanglaDigits = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };
    return number.toString().split('').map((digit) => englishToBanglaDigits[digit]!).join('');
  }

  DateTime? _getNextPrayerTime() {
    if (_prayerTimes == null) return null;
    final now = DateTime.now();

    if (now.isBefore(_prayerTimes!.fajr)) return _prayerTimes!.fajr;
    if (now.isBefore(_prayerTimes!.sunrise)) return _prayerTimes!.sunrise;
    if (now.isBefore(_getIshraqTime())) return _getIshraqTime();
    if (now.isBefore(_getChashtStartTime())) return _getChashtStartTime();
    if (now.isBefore(_getZawalStartTime())) return _prayerTimes!.dhuhr;
    if (now.isBefore(_prayerTimes!.dhuhr)) return _prayerTimes!.dhuhr;
    if (now.isBefore(_prayerTimes!.asr)) return _prayerTimes!.asr;
    if (now.isBefore(_getSunsetForbiddenStart())) return _prayerTimes!.maghrib;
    if (now.isBefore(_prayerTimes!.maghrib)) return _prayerTimes!.maghrib;
    if (now.isBefore(_prayerTimes!.isha)) return _prayerTimes!.isha;
    if (now.isBefore(_getTahajjudTime())) return _getTahajjudTime();

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowPrayers = PrayerTimes.today(
      Coordinates(_currentPosition?.latitude ?? 23.8103, _currentPosition?.longitude ?? 90.4125),
      CalculationMethod.karachi.getParameters(),
    );
    return tomorrowPrayers.fajr;
  }

  String _getCurrentPrayer() {
    if (_prayerTimes == null) return '';
    final now = DateTime.now();

    if (now.isBefore(_prayerTimes!.fajr)) return 'তাহাজ্জুদ';
    if (now.isBefore(_prayerTimes!.sunrise)) return 'ফজর';
    if (now.isBefore(_getIshraqTime())) return 'নিষিদ্ধ সময়';
    if (now.isBefore(_getChashtStartTime())) return 'ইশরাক';
    if (now.isBefore(_getZawalStartTime())) return 'চাশত';
    if (now.isBefore(_prayerTimes!.dhuhr)) return 'নিষিদ্ধ সময়';
    if (now.isBefore(_prayerTimes!.asr)) {
      return DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর';
    }
    if (now.isBefore(_getSunsetForbiddenStart())) return 'আসর';
    if (now.isBefore(_prayerTimes!.maghrib)) return 'নিষিদ্ধ সময় ';
    if (now.isBefore(_prayerTimes!.isha)) return 'মাগরিব';
    if (now.isBefore(_getTahajjudTime())) return 'ইশা';
    return 'তাহাজ্জুদ';
  }

  DateTime _getPrayerStartTime(String prayer) {
    if (_prayerTimes == null) return DateTime.now();

    switch (prayer) {
      case 'ফজর':
        return _prayerTimes!.fajr;
      case 'নিষিদ্ধ সময়-১':
        return _prayerTimes!.sunrise.add(const Duration(minutes: 1));
      case 'ইশরাক':
        return _getIshraqTime().add(const Duration(minutes: 1));
      case 'চাশত':
        return _getChashtStartTime().add(const Duration(minutes: 1));
      case 'নিষিদ্ধ সময়-২':
        return _getZawalStartTime().add(const Duration(minutes: 1));
      case "জুম'আ":
      case 'জোহর':
        return _prayerTimes!.dhuhr.add(const Duration(minutes: 1));
      case 'আসর':
        return _prayerTimes!.asr.add(const Duration(minutes: 1));
      case 'নিষিদ্ধ সময়-৩':
        return _getSunsetForbiddenStart().subtract(const Duration(minutes: 10)).add(const Duration(minutes: 1));
      case 'মাগরিব':
        return _prayerTimes!.maghrib.add(const Duration(minutes: 1));
      case 'ইশা':
        return _prayerTimes!.isha.add(const Duration(minutes: 1));
      case 'তাহাজ্জুদ':
        return _getTahajjudTime();
      default:
        return DateTime.now();
    }
  }

  DateTime _getPrayerEndTime(String prayer) {
    if (_prayerTimes == null) return DateTime.now();

    switch (prayer) {
      case 'ফজর':
        return _prayerTimes!.sunrise;
      case 'নিষিদ্ধ সময়-১':
        return _getIshraqTime();
      case 'ইশরাক':
        return _getChashtStartTime();
      case 'চাশত':
        return _getZawalStartTime();
      case 'নিষিদ্ধ সময়-২':
        return _prayerTimes!.dhuhr;
      case "জুম'আ":
      case 'জোহর':
        return _prayerTimes!.asr;
      case 'আসর':
        return _getSunsetForbiddenStart();
      case 'নিষিদ্ধ সময়-৩':
        return _prayerTimes!.maghrib;
      case 'মাগরিব':
        return _prayerTimes!.isha;
      case 'ইশা':
        return _getNextDayFajr();
      case 'তাহাজ্জুদ':
        return _prayerTimes!.fajr.subtract(const Duration(minutes: 1));
      default:
        return DateTime.now();
    }
  }

  IconData _getPrayerIcon(String prayerName) {
    final prayerIcons = {
      'ফজর': Icons.wb_twilight,
      'নিষিদ্ধ সময়-১': Icons.block,
      'ইশরাক': Icons.wb_sunny_outlined,
      'চাশত': Icons.wb_sunny_outlined,
      'নিষিদ্ধ সময়-২': Icons.block,
      "জুম'আ": Icons.wb_sunny,
      'জোহর': Icons.wb_sunny,
      'আসর': Icons.wb_cloudy,
      'নিষিদ্ধ সময়-৩': Icons.block,
      'মাগরিব': Icons.nights_stay,
      'ইশা': Icons.star,
      'তাহাজ্জুদ': Icons.nightlight_round,
    };
    return prayerIcons[prayerName] ?? Icons.error;
  }

  DateTime _getTahajjudTime() {
    if (_prayerTimes == null) return DateTime.now();
    final isha = _prayerTimes!.isha;
    final fajr = _prayerTimes!.fajr.add(const Duration(days: 1));
    final midpoint = isha.add(fajr.difference(isha) ~/ 2);
    return midpoint;
  }

  DateTime _getIshraqTime() {
    if (_prayerTimes == null) return DateTime.now();
    return _prayerTimes!.sunrise.add(const Duration(minutes: 20));
  }

  DateTime _getChashtStartTime() {
    if (_prayerTimes == null) return DateTime.now();
    return _prayerTimes!.sunrise.add(const Duration(minutes: 110));
  }

  DateTime _getZawalStartTime() {
    if (_prayerTimes == null) return DateTime.now();
    return _prayerTimes!.dhuhr.subtract(const Duration(minutes: 15));
  }

  DateTime _getSunsetForbiddenStart() {
    if (_prayerTimes == null) return DateTime.now();
    return _prayerTimes!.maghrib.subtract(const Duration(minutes: 5));
  }

  DateTime _getNextDayFajr() {
    if (_prayerTimes == null) return DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowPrayers = PrayerTimes.today(
      Coordinates(_currentPosition?.latitude ?? 23.8103, _currentPosition?.longitude ?? 90.4125),
      CalculationMethod.karachi.getParameters(),
    );
    return tomorrowPrayers.fajr;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                foregroundPainter: GlowingBorderPainter(
                  progress: _controller.value,
                  glowColors: [
                    Colors.red.withOpacity(0.8),
                    Colors.orange.withOpacity(0.8),
                    Colors.yellow.withOpacity(0.8),
                    Colors.green.withOpacity(0.8),
                    Colors.blue.withOpacity(0.8),
                    Colors.indigo.withOpacity(0.8),
                    Colors.purple.withOpacity(0.8),
                  ],
                  borderRadius: screenWidth * 1,
                ),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(screenWidth * 0.01),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.005,
                    horizontal: screenWidth * 0.06,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(screenWidth * 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'এখন চলছে',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.001),
                      Text(
                        '${_getCurrentPrayer()} | ${_formatTime(_getPrayerStartTime(_getCurrentPrayer()))} - ${_formatTime(_getPrayerEndTime(_getCurrentPrayer()))}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.048,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.001),
                      Text(
                        'সময় বাকি: ${_getTimeRemaining()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.048,
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.55,
                        height: 1,
                        color: Colors.white.withOpacity(0.3),
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'সেহরি শেষ : ${_formatTime(_getNextDayFajr())}',
                              style: TextStyle(
                                color: Colors.yellow.withOpacity(0.8),
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' | ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'ইফতার শুরু : ${_formatTime(_prayerTimes?.maghrib)}',
                              style: TextStyle(
                                color: Colors.yellow.withOpacity(0.8),
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        // Replacing Row with GridView for all prayer times
        SizedBox(
          height: screenHeight * 0.07, // Adjust height as needed
          child: GridView.count(
            crossAxisCount: 5,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
           
            mainAxisSpacing: screenHeight * 0.01,
            crossAxisSpacing: screenWidth * 0.02,
            children: [
              _buildPrayerTimeCard(_prayerTimes?.fajr, 'ফজর', Icons.wb_twilight),
              // _buildPrayerTimeCard(_prayerTimes?.sunrise, 'নিষিদ্ধ সময় (সূর্যোদয়)', Icons.block),
              // _buildPrayerTimeCard(_getIshraqTime(), 'ইশরাক', Icons.wb_sunny_outlined),
              // _buildPrayerTimeCard(_getChashtStartTime(), 'চাশত', Icons.wb_sunny_outlined),
              // _buildPrayerTimeCard(_getZawalStartTime(), 'নিষিদ্ধ সময় (জাওয়াল)', Icons.block),
              _buildPrayerTimeCard(
                  _prayerTimes?.dhuhr,
                  DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'জোহর',
                  Icons.wb_sunny),
              _buildPrayerTimeCard(_prayerTimes?.asr, 'আসর', Icons.wb_cloudy),
              // _buildPrayerTimeCard(_getSunsetForbiddenStart(), 'নিষিদ্ধ সময় (সূর্যাস্তের আগে)', Icons.block),
              _buildPrayerTimeCard(_prayerTimes?.maghrib, 'মাগরিব', Icons.nights_stay),
              _buildPrayerTimeCard(_prayerTimes?.isha, 'ইশা', Icons.star),
              // _buildPrayerTimeCard(_getTahajjudTime(), 'তাহাজ্জুদ', Icons.nightlight_round),
            ],
          ),
        ),
      ],
    );
  }

 Widget _buildPrayerTimeCard(DateTime? time, String name, IconData icon) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isActivePrayer = name == _getCurrentPrayer();

  return Container(
    // padding: EdgeInsets.symmetric(
    //   vertical: screenWidth * 0.005,   // ভার্টিকাল প্যাডিং কমানো (0.5% of screen width)
    //   horizontal: screenWidth * 0.01,  // হরাইজন্টাল প্যাডিং আগের মতোই
    // ),
    padding: EdgeInsets.only( // Using EdgeInsets.only for custom padding
      // left: screenWidth * 0.05,  // Left padding (horizontal)
      // right: screenWidth * 0.05, // Right padding (horizontal)
      top: screenHeight * 0.0005, // Top padding (vertical)
      bottom: screenHeight * 0.02, // Bottom padding (vertical)
    ),
    decoration: BoxDecoration(
      color: isActivePrayer
          ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)
          : Colors.teal.withOpacity(0.5),
      borderRadius: BorderRadius.circular(screenWidth * 0.03),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            color: isActivePrayer ? const Color.fromARGB(255, 0, 190, 165) : Colors.white,
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          _formatTime(time),
          style: TextStyle(
            color: isActivePrayer ? Colors.teal : Colors.white,
            fontSize: screenWidth * 0.027,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

  String _formatTime(DateTime? time) {
    if (time == null) return '--:--';
    return DateFormat('hh:mm a', 'bn').format(time);
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double progress;
  final List<Color> glowColors;
  final double borderRadius;

  GlowingBorderPainter({
    required this.progress,
    required this.glowColors,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = SweepGradient(
        colors: glowColors,
        stops: List.generate(glowColors.length, (index) => index / (glowColors.length - 1)),
        startAngle: 0,
        endAngle: math.pi * 2,
        transform: GradientRotation(progress * math.pi * 2),
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(GlowingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.glowColors != glowColors;
  }
}