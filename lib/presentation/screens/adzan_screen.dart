import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:dharma/presentation/widgets/add_2.dart'; // Assuming this is your advertisement widget

class AdzanScreen extends StatefulWidget {
  const AdzanScreen({Key? key}) : super(key: key);

  @override
  _AdzanScreenState createState() => _AdzanScreenState();
}

class _AdzanScreenState extends State<AdzanScreen> {
  late PrayerTimes prayerTimes;
  bool isLoading = true;
  List<Map<String, dynamic>> prayerList = [
    {'name': 'ফজর', 'time': null, 'isAlertOn': false, 'icon': Icons.bedtime_outlined},
    {'name': 'জোহর', 'time': null, 'isAlertOn': false, 'icon': Icons.wb_sunny_outlined},
    {'name': 'আসর', 'time': null, 'isAlertOn': false, 'icon': Icons.wb_twilight_outlined},
    {'name': 'মাগরিব', 'time': null, 'isAlertOn': false, 'icon': Icons.nights_stay_outlined},
    {'name': 'ইশা', 'time': null, 'isAlertOn': false, 'icon': Icons.star_outline},
    {'name': 'তাহাজ্জুদ', 'time': null, 'isAlertOn': false, 'icon': Icons.nightlight_round, 'isCustomTime': true},
  ];
  Timer? _prayerCheckTimer;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  DateTime? _currentDate;
  String _currentLocation = 'লোকেশন লোড হচ্ছে...';

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initializeNotifications().then((_) {
      _loadToggleStates();
      _loadTahajjudTime();
      _fetchPrayerTimes();
    });
  }

  @override
  void dispose() {
    _prayerCheckTimer?.cancel();
    super.dispose();
  }

  // Load saved Tahajjud time from SharedPreferences
  Future<void> _loadTahajjudTime() async {
    final prefs = await SharedPreferences.getInstance();
    final tahajjudHour = prefs.getInt('tahajjud_hour');
    final tahajjudMinute = prefs.getInt('tahajjud_minute');
    
    if (tahajjudHour != null && tahajjudMinute != null) {
      final now = DateTime.now();
      final tahajjudTime = DateTime(
        now.year, 
        now.month, 
        now.day, 
        tahajjudHour, 
        tahajjudMinute
      );
      
      setState(() {
        final tahajjudPrayer = prayerList.firstWhere((p) => p['name'] == 'তাহাজ্জুদ');
        tahajjudPrayer['time'] = tahajjudTime;
      });
    }
  }

  // Save Tahajjud time to SharedPreferences
  Future<void> _saveTahajjudTime(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tahajjud_hour', time.hour);
    await prefs.setInt('tahajjud_minute', time.minute);
    
    final now = DateTime.now();
    final tahajjudTime = DateTime(
      now.year, 
      now.month, 
      now.day, 
      time.hour, 
      time.minute
    );
    
    setState(() {
      final tahajjudPrayer = prayerList.firstWhere((p) => p['name'] == 'তাহাজ্জুদ');
      tahajjudPrayer['time'] = tahajjudTime;
    });
    
    final tahajjudPrayer = prayerList.firstWhere((p) => p['name'] == 'তাহাজ্জুদ');
    if (tahajjudPrayer['isAlertOn'] == true) {
      _schedulePrayerNotification('তাহাজ্জুদ');
    }
  }

  // Show time picker for Tahajjud
  Future<void> _showTahajjudTimePicker(BuildContext context) async {
    final tahajjudPrayer = prayerList.firstWhere((p) => p['name'] == 'তাহাজ্জুদ');
    final initialTime = tahajjudPrayer['time'] != null 
        ? TimeOfDay.fromDateTime(tahajjudPrayer['time'] as DateTime)
        : const TimeOfDay(hour: 3, minute: 30); // Default Tahajjud time

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00BFA5),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      _saveTahajjudTime(pickedTime);
    }
  }

  Future<void> _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const androidChannel = AndroidNotificationChannel(
      'prayer_channel_id',
      'Prayer Alerts',
      description: 'Notifications for prayer times',
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      showBadge: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        if (details.payload != null) {
          print('Notification payload: ${details.payload}');
        }
      },
    );
  }

  Future<void> _loadToggleStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var prayer in prayerList) {
        prayer['isAlertOn'] = prefs.getBool('${prayer['name']}_alert') ?? false;
      }
    });
  }

  Future<void> _saveToggleState(String prayerName, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${prayerName}_alert', value);
    if (value) {
      _schedulePrayerNotification(prayerName);
    } else {
      _cancelPrayerNotification(prayerName);
    }
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      Position position = await _determinePosition();
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab = Madhab.hanafi;
      prayerTimes = PrayerTimes.today(coordinates, params);

      _getCurrentLocationName(position);

      setState(() {
        _currentDate = DateTime.now();
        prayerList[0]['time'] = prayerTimes.fajr;
        prayerList[1]['time'] = prayerTimes.dhuhr;
        prayerList[2]['time'] = prayerTimes.asr;
        prayerList[3]['time'] = prayerTimes.maghrib;
        prayerList[4]['time'] = prayerTimes.isha;
        isLoading = false;
      });
      _startPrayerCheckTimer();
    } catch (e) {
      print('Error fetching prayer times: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocationName(Position position) async {
    setState(() {
      _currentLocation = 'বর্তমান লোকেশন';
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
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

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    return DateFormat('hh:mm a', 'bn').format(time);
  }

  void _startPrayerCheckTimer() {
    _prayerCheckTimer?.cancel();
    _prayerCheckTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkPrayerAlerts();
    });
  }

  void _checkPrayerAlerts() {
    if (isLoading) return;

    final now = DateTime.now();
    for (var i = 0; i < prayerList.length; i++) {
      var prayer = prayerList[i];
      if (prayer['isAlertOn'] && prayer['time'] != null) {
        final prayerTime = prayer['time'] as DateTime;
        final diff = prayerTime.difference(now).inMinutes.abs();
        if (diff <= 1 && !prayer.containsKey('alertShown')) {
          _showAzanAlert(prayer['name']);
          setState(() {
            prayer['alertShown'] = true;
          });
          Future.delayed(const Duration(hours: 23), () {
            if (mounted) {
              setState(() {
                prayer.remove('alertShown');
              });
            }
          });
        }
      }
    }
  }

  Future<void> _showAzanAlert(String prayerName) async {
    final player = AudioPlayer();
    try {
      await player.play(AssetSource('azan.mp3'));
    } catch (e) {
      print('Error playing azan: $e');
    }

    const androidDetails = AndroidNotificationDetails(
      'prayer_channel_id',
      'Prayer Alerts',
      channelDescription: 'Notifications for prayer times',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      fullScreenIntent: true,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'azan.mp3',
      ),
    );

    try {
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond,
        'আজান',
        '$prayerName এর আজান বাজছে!',
        platformDetails,
      );
    } catch (e) {
      print('Error showing notification: $e');
    }

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('আজান'),
          content: Text('$prayerName এর আজান বাজছে!'),
          actions: [
            TextButton(
              onPressed: () {
                player.stop();
                Navigator.pop(context);
              },
              child: const Text('ঠিক আছে'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _schedulePrayerNotification(String prayerName) async {
    final prayer = prayerList.firstWhere((p) => p['name'] == prayerName);
    final prayerTime = prayer['time'] as DateTime?;
    if (prayerTime != null) {
      final androidDetails = AndroidNotificationDetails(
        'prayer_channel_id',
        'Prayer Alerts',
        channelDescription: 'Notifications for prayer times',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        fullScreenIntent: true,
      );

      final platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'azan.mp3',
        ),
      );

      // Schedule for today's time
      var scheduledDate = tz.TZDateTime.from(prayerTime, tz.local);
      
      // If it's Tahajjud or the scheduled time is in the past, set it for tomorrow
      final now = tz.TZDateTime.now(tz.local);
      if (prayerName == 'তাহাজ্জুদ' || scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        prayerName.hashCode,
        prayerName == 'তাহাজ্জুদ' ? 'তাহাজ্জুদ নামাজের সময়' : 'আজান',
        prayerName == 'তাহাজ্জুদ' ? 'তাহাজ্জুদ নামাজের সময় হয়েছে' : '$prayerName এর আজান বাজছে!',
        scheduledDate,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> _cancelPrayerNotification(String prayerName) async {
    await flutterLocalNotificationsPlugin.cancel(prayerName.hashCode);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    String nextPrayer = '';
    String nextTime = '';
    DateTime? nextPrayerTime;
    double progressValue = 0.0;
    int remainingMinutes = 0;

    if (!isLoading) {
      final now = DateTime.now();
      for (var i = 1; i < prayerList.length - 1; i++) {
        final prayerTime = prayerList[i]['time'] as DateTime?;
        if (prayerTime != null && now.isBefore(prayerTime)) {
          nextPrayer = prayerList[i]['name'];
          nextTime = _formatTime(prayerTime);
          nextPrayerTime = prayerTime;

          final previousPrayerTime = i > 0
              ? prayerList[i - 1]['time'] as DateTime?
              : prayerList.last['time'] as DateTime?;
          if (previousPrayerTime != null) {
            final totalMinutes = prayerTime.difference(previousPrayerTime).inMinutes;
            final elapsedMinutes = now.difference(previousPrayerTime).inMinutes;
            progressValue = totalMinutes > 0 ? elapsedMinutes / totalMinutes : 0.0;
            progressValue = progressValue.clamp(0.0, 1.0);
            remainingMinutes = prayerTime.difference(now).inMinutes;
          }
          break;
        }
      }

      if (nextPrayer.isEmpty) {
        nextPrayer = prayerList[0]['name'];
        nextTime = _formatTime(prayerList[0]['time'] as DateTime?);
        nextPrayerTime = prayerList[0]['time'] as DateTime?;
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      title: Text(
        'আজান',
        style: TextStyle(
        fontSize: screenWidth * 0.055,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        ),
      ),
      backgroundColor: Colors.teal,
      centerTitle: true,
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    _buildNextPrayerCard(
                        nextPrayer, nextTime, progressValue, remainingMinutes, nextPrayerTime, screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'আজকের নামাজের সময়',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildPrayerTimesList(screenWidth, screenHeight),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.1,
                      child: const Advertisement2(),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildNextPrayerCard(String prayerName, String time, double progressValue, int remainingMinutes,
      DateTime? prayerTime, double screenWidth, double screenHeight) {
    final IconData prayerIcon = prayerList
        .firstWhere(
          (p) => p['name'] == prayerName,
          orElse: () => {'icon': Icons.access_time_outlined} as Map<String, dynamic>,
        )['icon'];

    final timeRemaining = remainingMinutes > 60
        ? '${(remainingMinutes / 60).floor()} ঘণ্টা ${remainingMinutes % 60} মিনিট বাকি'
        : '$remainingMinutes মিনিট বাকি';

    final Map<String, Color> prayerColors = {
      'ফজর': Color(0xFF5E35B1),
      'জোহর': Color(0xFF00897B),
      'আসর': Color(0xFFFF8F00),
      'মাগরিব': Color(0xFF1565C0),
      'ইশা': Color(0xFF546E7A),
    };

    final Color prayerColor = prayerColors[prayerName] ?? Color(0xFF00BFA5);

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            prayerColor,
            prayerColor.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: prayerColor.withOpacity(0.3),
            blurRadius: screenWidth * 0.0375,
            offset: Offset(0, screenHeight * 0.00625),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -screenHeight * 0.025,
            right: -screenWidth * 0.05,
            child: _buildDecorativeCircle(prayerColor, screenWidth * 0.175, screenWidth, screenHeight),
          ),
          Positioned(
            bottom: -screenHeight * 0.05,
            left: -screenWidth * 0.05,
            child: _buildDecorativeCircle(prayerColor, screenWidth * 0.25, screenWidth, screenHeight),
          ),
          Positioned(
            top: screenHeight * 0.05,
            right: screenWidth * 0.15,
            child: _buildDecorativeCircle(prayerColor, screenWidth * 0.1, screenWidth, screenHeight),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'পরবর্তী নামাজ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03, vertical: screenHeight * 0.0075),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.0325,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Icon(
                    prayerIcon,
                    color: Colors.white,
                    size: screenWidth * 0.08,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    prayerName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.07,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: screenHeight * 0.0075,
                ),
              ),
              SizedBox(height: screenHeight * 0.0125),
              Text(
                timeRemaining,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle(Color baseColor, double size, double screenWidth, double screenHeight) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: screenWidth * 0.005,
        ),
      ),
    );
  }

  Widget _buildPrayerTimesList(double screenWidth, double screenHeight) {
    // Determine the next prayer outside of the ListView builder
    final now = DateTime.now();
    String nextPrayerName = '';
    
    for (var i = 0; i < prayerList.length - 1; i++) { // Skip tahajjud for standard prayers
      final prayerTime = prayerList[i]['time'] as DateTime?;
      if (prayerTime != null && now.isBefore(prayerTime)) {
        nextPrayerName = prayerList[i]['name'];
        break;
      }
    }
    
    // If no upcoming prayer found today, default to Fajr
    if (nextPrayerName.isEmpty && prayerList[0]['time'] != null) {
      nextPrayerName = prayerList[0]['name'];
    }
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: screenWidth * 0.025,
            offset: Offset(0, screenHeight * 0.0025),
          ),
        ],
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: prayerList.length,
        separatorBuilder: (context, index) => Divider(
            height: screenHeight * 0.00125,
            thickness: screenWidth * 0.00125,
            indent: screenWidth * 0.175,
            color: Colors.grey.withOpacity(0.2)),
        itemBuilder: (context, index) {
          final prayer = prayerList[index];
          return _buildPrayerTimeItem(
            prayer['name'],
            _formatTime(prayer['time'] as DateTime?),
            prayer['isAlertOn'],
            prayer['icon'],
            (value) {
              setState(() {
                prayer['isAlertOn'] = value;
                _saveToggleState(prayer['name'], value);
              });
            },
            prayer['isCustomTime'] == true,
            screenWidth,
            screenHeight,
          );
        },
      ),
    );
  }

  Widget _buildPrayerTimeItem(String prayerName, String time, bool isAlertOn, IconData icon, Function(bool)? onToggle,
      bool isCustomTime, double screenWidth, double screenHeight) {
    final now = DateTime.now();
    final prayerTime = prayerList.firstWhere((p) => p['name'] == prayerName)['time'] as DateTime?;

    // Find the next prayer that will occur after the current time
    String nextPrayerName = '';
    DateTime? nextPrayerTime;
    
    for (var i = 0; i < prayerList.length - 1; i++) { // Skip tahajjud in this calculation
      final prayer = prayerList[i];
      final time = prayer['time'] as DateTime?;
      if (time != null && now.isBefore(time)) {
        nextPrayerName = prayer['name'];
        nextPrayerTime = time;
        break;
      }
    }
    
    // If no upcoming prayer found today, default to Fajr (for the next day)
    if (nextPrayerName.isEmpty && prayerList[0]['time'] != null) {
      nextPrayerName = prayerList[0]['name'];
    }
    
    // A prayer is active only if it's the next one to occur
    final bool isActive = prayerName == nextPrayerName;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0075),
      child: ListTile(
        leading: Container(
          width: screenWidth * 0.12,
          height: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF00BFA5).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Icon(
            icon,
            color: isActive ? Color(0xFF00BFA5) : Colors.grey,
            size: screenWidth * 0.06,
          ),
        ),
        title: Text(
          prayerName,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: isActive ? Color(0xFF00BFA5) : Colors.black87,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isCustomTime 
            ? ElevatedButton(
                onPressed: () => _showTahajjudTimePicker(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00BFA5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.005
                  ),
                  minimumSize: Size(screenWidth * 0.15, screenHeight * 0.01),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                child: Text(
                  time.isEmpty ? 'সময় সেট করুন' : time,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              )
            : Text(
                time,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: isActive ? Color(0xFF00BFA5) : Colors.black54,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            SizedBox(width: screenWidth * 0.03),
            Transform.scale(
              scale: 0.75,
              child: Switch.adaptive(
                value: isAlertOn,
                onChanged: onToggle,
                activeColor: Color(0xFF00BFA5),
                activeTrackColor: Color(0xFF00BFA5).withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}