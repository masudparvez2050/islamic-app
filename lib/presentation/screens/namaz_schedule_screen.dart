import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:dharma/presentation/widgets/add_2.dart';
import 'package:geocoding/geocoding.dart';

class NamazScheduleScreen extends StatefulWidget {
  const NamazScheduleScreen({Key? key}) : super(key: key);

  @override
  _NamazScheduleScreenState createState() => _NamazScheduleScreenState();
}

class _NamazScheduleScreenState extends State<NamazScheduleScreen> with TickerProviderStateMixin {
  late DateTime _selectedDate;
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  bool _isCalendarVisible = false;
  String _locationName = "আপনার অবস্থান";
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimationController _calendarAnimationController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calendarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _calendarAnimationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _useDefaultLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _useDefaultLocation();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _updatePrayerTimes();
        _getAddressFromLatLng(position);
      });
    } catch (e) {
      print('Error getting location: $e');
      _useDefaultLocation();
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          if (place.subLocality != null && place.subLocality!.isNotEmpty) {
            _locationName = place.subLocality!;
          } else if (place.locality != null && place.locality!.isNotEmpty) {
            _locationName = place.locality!;
          } else if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
            _locationName = place.subAdministrativeArea!;
          } else if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
            _locationName = place.administrativeArea!;
          } else {
            _locationName = "আপনার বর্তমান অবস্থান";
          }
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        _locationName = "আপনার বর্তমান অবস্থান";
      });
    }
  }

  void _useDefaultLocation() {
    setState(() {
      _currentPosition = Position(
        latitude: 23.8103,
        longitude: 90.4125,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      _updatePrayerTimes();
      _locationName = "ঢাকা";
    });
  }

  void _updatePrayerTimes() {
    if (_currentPosition != null) {
      final coordinates = Coordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      final dateComponents = DateComponents.from(_selectedDate);
      setState(() {
        _prayerTimes = PrayerTimes(coordinates, dateComponents, params);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          'নামাজের সময়সূচী',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05,
          ),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF00BFA5),
          statusBarIconBrightness: Brightness.light,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: screenWidth * 0.06),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildDateSelector(screenWidth, screenHeight),
              Expanded(
                child: _prayerTimes != null
                    ? _buildPrayerTimesList(screenWidth, screenHeight)
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              child: CircularProgressIndicator(
                                color: const Color(0xFF00BFA5),
                                strokeWidth: screenWidth * 0.008,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              'নামাজের সময়সূচী লোড হচ্ছে...',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _calendarAnimationController,
            builder: (context, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: _isCalendarVisible ? screenHeight * 0.12 : -screenHeight * 0.6,
                left: 0,
                right: 0,
                height: screenHeight * 0.45,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  elevation: 8,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    child: _buildCalendar(screenWidth, screenHeight),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.07,
              child: const Advertisement2(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth * 0.05),
          bottomRight: Radius.circular(screenWidth * 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: screenWidth * 0.0025,
            blurRadius: screenWidth * 0.025,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: screenWidth * 0.05,
                        color: const Color(0xFF00BFA5),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        _locationName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isCalendarVisible = !_isCalendarVisible;
                        if (_isCalendarVisible) {
                          _calendarAnimationController.forward();
                        } else {
                          _calendarAnimationController.reverse();
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.006,
                        horizontal: screenWidth * 0.03,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('d MMMM yyyy', 'bn').format(_selectedDate),
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Icon(
                            Icons.calendar_month_rounded,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF00BFA5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: _refreshPrayerTimes,
                borderRadius: BorderRadius.circular(screenWidth * 0.12),
                child: Container(
                  height: screenWidth * 0.12,
                  width: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.refresh_rounded,
                    size: screenWidth * 0.06,
                    color: const Color(0xFF00BFA5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _refreshPrayerTimes() {
    setState(() {
      _selectedDate = DateTime.now();
      _updatePrayerTimes();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('নামাজের সময়সূচী আপডেট হয়েছে'),
        backgroundColor: Color(0xFF00BFA5),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildCalendar(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Container(
          height: screenHeight * 0.05, // Added fixed height
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005), // Added vertical margin
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002), // Halved vertical padding
          color: const Color(0xFF00BFA5).withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.close_rounded, size: screenWidth * 0.05),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: screenWidth * 0.08, minHeight: screenWidth * 0.08),
                color: const Color(0xFF00BFA5),
                onPressed: () {
                  setState(() {
                    _isCalendarVisible = false;
                    _calendarAnimationController.reverse();
                  });
                },
              ),
              Text(
                'তারিখ নির্বাচন করুন',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF00BFA5),
                ),
              ),
              IconButton(
                icon: Icon(Icons.today_rounded, size: screenWidth * 0.05),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: screenWidth * 0.08, minHeight: screenWidth * 0.08),
                color: const Color(0xFF00BFA5),
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime.now();
                    _updatePrayerTimes();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _updatePrayerTimes();
                _isCalendarVisible = false;
                _calendarAnimationController.reverse();
              });
            },
            calendarFormat: CalendarFormat.month,
            rowHeight: screenHeight * 0.045,
            daysOfWeekHeight: screenHeight * 0.025,
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Color(0xFF00BFA5),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: const Color(0xFF00BFA5).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(fontSize: screenWidth * 0.035),
              weekendTextStyle: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.red,
              ),
              outsideTextStyle: TextStyle(
                fontSize: screenWidth * 0.026,
                color: Colors.grey.withOpacity(0.6),
              ),
              selectedTextStyle: TextStyle(fontSize: screenWidth * 0.028, color: Colors.white),
              todayTextStyle: TextStyle(fontSize: screenWidth * 0.028, color: Colors.white),
              cellMargin: EdgeInsets.symmetric(horizontal: screenWidth * 0.005, vertical: screenHeight * 0.001),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: screenWidth * 0.036),
              leftChevronIcon: Icon(Icons.chevron_left, color: const Color(0xFF00BFA5), size: screenWidth * 0.05),
              rightChevronIcon: Icon(Icons.chevron_right, color: const Color(0xFF00BFA5), size: screenWidth * 0.05),
              titleTextFormatter: (date, locale) => DateFormat.yMMMM(locale).format(date),
              headerPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              headerMargin: EdgeInsets.only(bottom: screenHeight * 0.005),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontSize: screenWidth * 0.026),
              weekendStyle: TextStyle(fontSize: screenWidth * 0.026, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerTimesList(double screenWidth, double screenHeight) {
    final prayerTimes = [
      {'name': 'ফজর', 'startTime': _prayerTimes!.fajr, 'endTime': _prayerTimes!.sunrise, 'icon': Icons.wb_twilight},
      {
        'name': 'নিষিদ্ধ সময়',
        'startTime': _prayerTimes!.sunrise.add(const Duration(minutes: 1)),
        'endTime': _getIshraqTime(),
        'icon': Icons.wb_sunny_outlined,
        'isProhibited': true,
      },
      {
        'name': 'ইশরাক',
        'startTime': _getIshraqTime().add(const Duration(minutes: 1)),
        'endTime': _getChashtStartTime(),
        'icon': Icons.wb_sunny_outlined,
      },
      {
        'name': 'চাশত',
        'startTime': _getChashtStartTime().add(const Duration(minutes: 1)),
        'endTime': _getZawalStartTime(),
        'icon': Icons.wb_sunny,
      },
      {
        'name': 'নিষিদ্ধ সময়',
        'startTime': _getZawalStartTime().add(const Duration(minutes: 1)),
        'endTime': _prayerTimes!.dhuhr,
        'icon': Icons.block,
        'isProhibited': true,
      },
      {
        'name': DateTime.now().weekday == DateTime.friday ? "জুম'আ" : 'যোহর',
        'startTime': _prayerTimes!.dhuhr.add(const Duration(minutes: 1)),
        'endTime': _prayerTimes!.asr,
        'icon': Icons.wb_sunny,
      },
      {
        'name': 'আসর',
        'startTime': _prayerTimes!.asr.add(const Duration(minutes: 1)),
        'endTime': _getSunsetForbiddenStart().subtract(const Duration(minutes: 10)),
        'icon': Icons.wb_cloudy,
      },
      {
        'name': 'নিষিদ্ধ সময়',
        'startTime': _getSunsetForbiddenStart().subtract(const Duration(minutes: 10)).add(const Duration(minutes: 1)),
        'endTime': _prayerTimes!.maghrib,
        'icon': Icons.block,
        'isProhibited': true,
      },
      {
        'name': 'মাগরিব',
        'startTime': _prayerTimes!.maghrib.add(const Duration(minutes: 1)),
        'endTime': _prayerTimes!.isha,
        'icon': Icons.nights_stay,
      },
      {
        'name': 'ইশা',
        'startTime': _prayerTimes!.isha.add(const Duration(minutes: 1)),
        'endTime': _getTahajjudTime(),
        'icon': Icons.star,
      },
      {
        'name': 'তাহাজ্জুদ',
        'startTime': _getTahajjudTime(),
        'endTime': _prayerTimes!.fajr.subtract(const Duration(minutes: 1)),
        'icon': Icons.nightlight_round,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: screenHeight * 0.08),
        itemCount: prayerTimes.length,
        itemBuilder: (context, index) {
          final prayer = prayerTimes[index];
          final isActivePrayer = _isActivePrayer(
            prayer['startTime'] as DateTime,
            prayer['endTime'] as DateTime,
          );
          final isProhibited = prayer['isProhibited'] as bool? ?? false;

          return _buildPrayerTimeItem(
            prayerName: prayer['name'] as String,
            startTime: prayer['startTime'] as DateTime,
            endTime: prayer['endTime'] as DateTime,
            icon: prayer['icon'] as IconData,
            isActive: isActivePrayer,
            isProhibited: isProhibited,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          );
        },
      ),
    );
  }

  Widget _buildPrayerTimeItem({
    required String prayerName,
    required DateTime startTime,
    required DateTime endTime,
    required IconData icon,
    required bool isActive,
    required bool isProhibited,
    required double screenWidth,
    required double screenHeight,
  }) {
    final timeFormat = DateFormat('h:mm a', 'bn');
    final timeRemaining = isActive ? _getFormattedTimeRemaining(endTime) : null;

    Color cardColor = isProhibited
        ? const Color(0xFFFF6161).withOpacity(0.1)
        : isActive
            ? const Color(0xFF00BFA5).withOpacity(0.1)
            : Colors.white;

    Color iconColor = isProhibited
        ? const Color(0xFFFF6161)
        : isActive
            ? const Color(0xFF00BFA5)
            : Colors.grey[600]!;

    Color textColor = isProhibited
        ? const Color(0xFFFF6161)
        : isActive
            ? const Color(0xFF00BFA5)
            : Colors.grey[800]!;

    return Card(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005, horizontal: screenWidth * 0.02),
      elevation: isActive ? 2 : 0,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        side: BorderSide(
          color: isActive ? const Color(0xFF00BFA5) : Colors.grey.withOpacity(0.1),
          width: isActive ? screenWidth * 0.0025 : screenWidth * 0.00125,
        ),
      ),
      color: cardColor,
      child: InkWell(
        onTap: () => _showPrayerTimeDetails(prayerName, startTime, endTime, isProhibited, screenWidth, screenHeight),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.04),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: screenWidth * 0.06),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayerName,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    if (timeRemaining != null)
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.005),
                        child: Text(
                          timeRemaining,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: const Color(0xFF00BFA5),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'শুরু: ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        timeFormat.format(startTime),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Text(
                        'শেষ: ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        timeFormat.format(endTime),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrayerTimeDetails(String prayerName, DateTime startTime, DateTime endTime, bool isProhibited,
      double screenWidth, double screenHeight) {
    final startTimeStr = DateFormat('h:mm a', 'bn').format(startTime);
    final endTimeStr = DateFormat('h:mm a', 'bn').format(endTime);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenHeight * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.07)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: screenWidth * 0.025,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: screenWidth * 0.1,
              height: screenHeight * 0.006,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(screenWidth * 0.0075),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.035),
              decoration: BoxDecoration(
                color: isProhibited
                    ? const Color(0xFFFF6161).withOpacity(0.1)
                    : const Color(0xFF00BFA5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: Text(
                prayerName,
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: isProhibited ? const Color(0xFFFF6161) : const Color(0xFF00BFA5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.035),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      border: Border.all(color: Colors.grey[200]!, width: screenWidth * 0.0025),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'শুরু',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          startTimeStr,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      border: Border.all(color: Colors.grey[200]!, width: screenWidth * 0.0025),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'শেষ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          endTimeStr,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0125, horizontal: screenWidth * 0.04),
              decoration: BoxDecoration(
                color: isProhibited
                    ? const Color(0xFFFF6161).withOpacity(0.08)
                    : const Color(0xFF00BFA5).withOpacity(0.08),
                borderRadius: BorderRadius.circular(screenWidth * 0.075),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isProhibited ? Icons.block_rounded : Icons.check_circle_rounded,
                    color: isProhibited ? const Color(0xFFFF6161) : const Color(0xFF00BFA5),
                    size: screenWidth * 0.05,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    isProhibited ? 'এই সময়ে নফল নামাজ পড়া নিষিদ্ধ' : 'এই সময়ে নফল নামাজ পড়া যাবে',
                    style: TextStyle(
                      fontSize: screenWidth * 0.0375,
                      fontWeight: FontWeight.w500,
                      color: isProhibited ? const Color(0xFFFF6161) : const Color(0xFF00BFA5),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0175),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isProhibited ? const Color(0xFFFF6161) : const Color(0xFF00BFA5),
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                alignment: Alignment.center,
                child: Text(
                  'বন্ধ করুন',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + screenHeight * 0.01),
          ],
        ),
      ),
    );
  }

  String _getFormattedTimeRemaining(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) return '';

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    if (hours > 0) {
      return 'আর $hours ঘন্টা $minutes মিনিট বাকি';
    } else {
      return 'আর $minutes মিনিট বাকি';
    }
  }

  DateTime _getTahajjudTime() {
    final isha = _prayerTimes!.isha;
    final duration = _prayerTimes!.fajr.difference(isha);
    return isha.add(duration * 2 ~/ 3);
  }

  DateTime _getIshraqTime() {
    return _prayerTimes!.sunrise.add(const Duration(minutes: 20));
  }

  DateTime _getChashtStartTime() {
    return _prayerTimes!.sunrise.add(const Duration(minutes: 45));
  }

  DateTime _getZawalStartTime() {
    return _prayerTimes!.dhuhr.subtract(const Duration(minutes: 10));
  }

  DateTime _getSunsetForbiddenStart() {
    return _prayerTimes!.maghrib.subtract(const Duration(minutes: 15));
  }

  bool _isActivePrayer(DateTime startTime, DateTime endTime) {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }
}