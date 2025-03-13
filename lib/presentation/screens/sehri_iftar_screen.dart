import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:adhan/adhan.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:dharma/presentation/widgets/add_2.dart';
import 'package:flutter/services.dart';
import 'package:dharma/presentation/widgets/common/headerSehriIftar.dart';
class SehriIftarScreen extends StatefulWidget {
  const SehriIftarScreen({Key? key}) : super(key: key);

  @override
  _SehriIftarScreenState createState() => _SehriIftarScreenState();
}

class _SehriIftarScreenState extends State<SehriIftarScreen> with TickerProviderStateMixin {
  late DateTime _selectedDate;
  late List<PrayerTimes> _prayerTimesList;
  bool _isCalendarVisible = false;
  Position? _currentPosition;
  String _locationName = "আপনার অবস্থান";
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimationController _calendarAnimationController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _prayerTimesList = [];
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
        desiredAccuracy: LocationAccuracy.medium,
      );
      setState(() {
        _currentPosition = position;
        _updateLocationName(position);
        _updatePrayerTimes();
      });
    } catch (e) {
      print("Error getting location: $e");
      _useDefaultLocation();
    }
  }

  Future<void> _updateLocationName(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          if (place.locality != null && place.locality!.isNotEmpty) {
            _locationName = place.locality!;
          } else if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
            _locationName = place.subAdministrativeArea!;
          } else if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
            _locationName = place.administrativeArea!;
          }
        });
      }
    } catch (e) {
      print("Error getting location name: $e");
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
      _locationName = "ঢাকা";
      _updatePrayerTimes();
    });
  }

  void _updatePrayerTimes() {
    if (_currentPosition == null) return;

    final coordinates = Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    setState(() {
      _prayerTimesList = List.generate(10, (index) {
        final date = _selectedDate.add(Duration(days: index));
        final dateComponents = DateComponents.from(date);
        return PrayerTimes(coordinates, dateComponents, params);
      });
    });
  }

  HijriCalendar _getAdjustedHijriDate(DateTime date) {
    final hijriDate = HijriCalendar.fromDate(date);
    hijriDate.hDay -= 1;
    if (hijriDate.hDay < 1) {
      hijriDate.hMonth -= 1;
      if (hijriDate.hMonth < 1) {
        hijriDate.hMonth = 12;
        hijriDate.hYear -= 1;
      }
      hijriDate.hDay = 30;
    }
    return hijriDate;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Header(
          title: 'সেহরি ও ইফতার',
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF00BFA5),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(screenWidth, screenHeight),
              Expanded(
                child: _prayerTimesList.isEmpty
                    ? _buildLoadingIndicator(screenWidth, screenHeight)
                    : _buildSehriIftarTimesList(screenWidth, screenHeight),
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

  Widget _buildLoadingIndicator(double screenWidth, double screenHeight) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: const Color(0xFF00BFA5),
            strokeWidth: screenWidth * 0.008,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'সময়সূচী লোড হচ্ছে...',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: screenWidth * 0.015,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(screenWidth * 0.05),
          bottomRight: Radius.circular(screenWidth * 0.05),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00BFA5).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          size: screenWidth * 0.045,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        _locationName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.012),
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
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.008,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('EEEE, d MMMM yyyy', 'bn_BD').format(_selectedDate),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Icon(
                            Icons.calendar_today_rounded,
                            size: screenWidth * 0.04,
                            color: const Color(0xFF00BFA5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: screenWidth * 0.12,
                width: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: const Color(0xFF00BFA5),
                    size: screenWidth * 0.06,
                  ),
                  onPressed: () {
                    _getCurrentLocation();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('সময়সূচী আপডেট করা হয়েছে'),
                        backgroundColor: const Color(0xFF00BFA5),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (_prayerTimesList.isNotEmpty) _buildRamadanStatus(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget _buildRamadanStatus(double screenWidth, double screenHeight) {
    final hijriDate = _getAdjustedHijriDate(_selectedDate);
    final bool isRamadan = hijriDate.hMonth == 9;

    if (isRamadan) {
      final dayOfRamadan = hijriDate.hDay;
      final String banglaDay = _convertToBanglaNumber(dayOfRamadan.toString());

      return Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.015),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.01,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF00BFA5).withOpacity(0.1),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: const Color(0xFF00BFA5),
                size: screenWidth * 0.04,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                'রমজান মাসের $banglaDay তম দিন',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildCalendar(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF00BFA5).withOpacity(0.1),
          height: screenHeight * 0.03,
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
          icon: Icon(Icons.close_rounded, size: screenWidth * 0.05),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: screenWidth * 0.04, minHeight: screenWidth * 0.04),
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
            fontSize: screenWidth * 0.040,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF00BFA5),
          ),
              ),
              IconButton(
          icon: Icon(Icons.today_rounded, size: screenWidth * 0.05),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: screenWidth * 0.04, minHeight: screenWidth * 0.04),
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
              selectedDecoration: BoxDecoration(
                color: const Color(0xFF00BFA5),
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

  Widget _buildSehriIftarTimesList(double screenWidth, double screenHeight) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: screenHeight * 0.075),
      physics: const BouncingScrollPhysics(),
      itemCount: _prayerTimesList.length,
      itemBuilder: (context, index) {
        final date = _selectedDate.add(Duration(days: index));
        final prayerTimes = _prayerTimesList[index];
        final hijriDate = _getAdjustedHijriDate(date);

        final sehriTime = _adjustSehriTime(prayerTimes.fajr);
        final iftarTime = prayerTimes.maghrib;

        final bool isToday = isSameDay(date, DateTime.now());
        final bool isFutureDay = date.isAfter(DateTime.now());

        return _buildTimeCard(
          screenWidth,
          screenHeight,
          date: date,
          hijriDate: hijriDate,
          sehriTime: sehriTime,
          iftarTime: iftarTime,
          isToday: isToday,
          isFutureDay: isFutureDay,
        );
      },
    );
  }

  DateTime _adjustSehriTime(DateTime fajr) {
    return fajr.subtract(const Duration(minutes: 10));
  }

  Widget _buildTimeCard(
    double screenWidth,
    double screenHeight, {
    required DateTime date,
    required HijriCalendar hijriDate,
    required DateTime sehriTime,
    required DateTime iftarTime,
    required bool isToday,
    required bool isFutureDay,
  }) {
    final now = DateTime.now();
    final bool isSehriTime = isToday && now.isBefore(sehriTime);
    final bool isFastingTime = isToday && now.isAfter(sehriTime) && now.isBefore(iftarTime);
    final bool isIftarTime = isToday && now.isAfter(iftarTime) && now.isBefore(iftarTime.add(const Duration(hours: 1)));

    String statusText = '';
    Color statusColor = Colors.grey;

    if (isSehriTime) {
      statusText = 'সেহরি বাকি আছে';
      statusColor = Colors.blue;
    } else if (isFastingTime) {
      statusText = 'রোজা চলছে';
      statusColor = Colors.amber[800]!;
    } else if (isIftarTime) {
      statusText = 'ইফতারের সময়';
      statusColor = Colors.green;
    }

    String timeRemainingText = '';
    if (isSehriTime) {
      timeRemainingText = _getTimeLeft(sehriTime);
    } else if (isFastingTime) {
      timeRemainingText = _getTimeLeft(iftarTime);
    }

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.05,
      ),
      elevation: isToday ? 4 : 1,
      shadowColor: isToday ? Colors.black26 : Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        side: BorderSide(
          color: isToday ? const Color(0xFF00BFA5) : Colors.transparent,
          width: isToday ? screenWidth * 0.004 : 0,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          gradient: isToday
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    const Color(0xFF00BFA5).withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.01,
              ),
              decoration: BoxDecoration(
                color: isToday ? const Color(0xFF00BFA5).withOpacity(0.1) : Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.04),
                  topRight: Radius.circular(screenWidth * 0.04),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (isToday)
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.01),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00BFA5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: screenWidth * 0.035,
                          ),
                        ),
                      SizedBox(width: isToday ? screenWidth * 0.02 : 0),
                      Text(
                        DateFormat('EEEE, d MMMM', 'bn_BD').format(date),
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                          color: isToday ? const Color(0xFF00BFA5) : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _getBanglaHijriDate(hijriDate),
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Icon(
                          Icons.breakfast_dining,
                          color: Colors.blue[700],
                          size: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'সেহরি শেষ',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              DateFormat('h:mm a', 'bn_BD').format(sehriTime),
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: isSehriTime ? FontWeight.bold : FontWeight.w500,
                                color: isSehriTime ? Colors.blue[700] : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSehriTime) _buildTimeRemainingBadge(screenWidth, timeRemainingText, Colors.blue),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.3),
                      height: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Icon(
                          Icons.dining,
                          color: Colors.amber[800],
                          size: screenWidth * 0.05,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ইফতার',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              DateFormat('h:mm a', 'bn_BD').format(iftarTime),
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: isFastingTime ? FontWeight.bold : FontWeight.w500,
                                color: isFastingTime ? Colors.amber[800] : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isFastingTime)
                        _buildTimeRemainingBadge(screenWidth, timeRemainingText, Colors.amber[800]!),
                    ],
                  ),
                ],
              ),
            ),
            if (isToday && statusText.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenWidth * 0.04),
                    bottomRight: Radius.circular(screenWidth * 0.04),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isSehriTime ? Icons.access_time_filled : Icons.notifications_active,
                      color: statusColor,
                      size: screenWidth * 0.04,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: statusColor,
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
  }

  Widget _buildTimeRemainingBadge(double screenWidth, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.025,
        vertical: screenWidth * 0.01,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: screenWidth * 0.0025,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getTimeLeft(DateTime endTime) {
    final now = DateTime.now();
    final difference = endTime.difference(now);
    if (difference.isNegative) return '';

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    if (hours > 0) {
      return '${_convertToBanglaNumber(hours.toString())}:${_convertToBanglaNumber(minutes.toString().padLeft(2, '0'))} ঘন্টা';
    } else {
      return '${_convertToBanglaNumber(minutes.toString())} মিনিট';
    }
  }

  String _convertToBanglaNumber(String number) {
    final banglaNumbers = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    String result = '';

    for (int i = 0; i < number.length; i++) {
      if (number[i].contains(RegExp(r'[0-9]'))) {
        result += banglaNumbers[int.parse(number[i])];
      } else {
        result += number[i];
      }
    }

    return result;
  }

  String _getBanglaHijriDate(HijriCalendar hijriDate) {
    final banglaNumbers = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    final hijriMonths = [
      'মুহাররম',
      'সফর',
      'রবিউল আউয়াল',
      'রবিউস সানি',
      'জমাদিউল আউয়াল',
      'জমাদিউস সানি',
      'রজব',
      'শাবান',
      'রমজান',
      'শাওয়াল',
      'জিলক্বদ',
      'জিলহজ্জ'
    ];

    String banglaDay = hijriDate.hDay.toString().split('').map((digit) => banglaNumbers[int.parse(digit)]).join('');

    return '$banglaDay ${hijriMonths[hijriDate.hMonth - 1]}';
  }
}