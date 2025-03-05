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
import 'package:religion/presentation/widgets/common/headerAdzan.dart';
import 'package:religion/presentation/widgets/add_2.dart';

class AdzanScreen extends StatefulWidget {
  const AdzanScreen({Key? key}) : super(key: key);

  @override
  _AdzanScreenState createState() => _AdzanScreenState();
}

class _AdzanScreenState extends State<AdzanScreen> {
  late PrayerTimes prayerTimes;
  bool isLoading = true;
  List<Map<String, dynamic>> prayerList = [
    {'name': 'ফজর', 'time': null, 'isAlertOn': false},
    {'name': 'জোহর', 'time': null, 'isAlertOn': false},
    {'name': 'আসর', 'time': null, 'isAlertOn': false},
    {'name': 'মাগরিব', 'time': null, 'isAlertOn': false},
    {'name': 'ইশা', 'time': null, 'isAlertOn': false},
    {'name': 'টেস্ট', 'time': null, 'isAlertOn': false},
  ];
  Timer? _prayerCheckTimer;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initializeNotifications().then((_) {
      _loadToggleStates();
      _fetchPrayerTimes();
    });
  }

  @override
  void dispose() {
    _prayerCheckTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Create notification channel for Android
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

      setState(() {
       
        
       
        prayerList[0]['time'] = prayerTimes.fajr;
        prayerList[1]['time'] = prayerTimes.dhuhr;
        prayerList[2]['time'] = prayerTimes.asr;
        prayerList[3]['time'] = prayerTimes.maghrib;
        prayerList[4]['time'] = prayerTimes.isha;
        prayerList[5]['time'] = DateTime.now().add(const Duration(minutes: 1));
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services authorities disabled.');
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
    // Skip first item (current time) as it shouldn't have an alert
    for (var i = 1; i < prayerList.length; i++) {
      var prayer = prayerList[i];
      if (prayer['isAlertOn'] && prayer['time'] != null) {
        final prayerTime = prayer['time'] as DateTime;
        final diff = prayerTime.difference(now).inMinutes.abs();
        if (diff <= 1 && !prayer.containsKey('alertShown')) {
          _showAzanAlert(prayer['name']);
          setState(() {
            prayer['alertShown'] = true;
          });
          // Reset alert flag after 23 hours to allow next day's alert
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
    // Play azan sound
    final player = AudioPlayer();
    try {
      await player.play(AssetSource('azan.mp3'));
    } catch (e) {
      print('Error playing azan: $e');
    }

    // Show notification
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
        DateTime.now().millisecond, // Unique ID
        'আজান',
        '$prayerName এর আজান বাজছে!',
        platformDetails,
      );
    } catch (e) {
      print('Error showing notification: $e');
    }

    // Show in-app alert dialog
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

      await flutterLocalNotificationsPlugin.zonedSchedule(
  prayerName.hashCode,
  'আজান',
  '$prayerName এর আজান বাজছে!',
  tz.TZDateTime.from(prayerTime, tz.local),
  platformDetails,
  // Replace androidAllowWhileIdle with androidScheduleMode
  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
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
    if (!isLoading) {
      final now = DateTime.now();
      // Skip current time for next prayer calculation
      for (var i = 1; i < prayerList.length; i++) {
        final prayerTime = prayerList[i]['time'] as DateTime?;
        if (prayerTime != null && now.isBefore(prayerTime)) {
          nextPrayer = prayerList[i]['name'];
          nextTime = _formatTime(prayerTime);
          break;
        }
      }
      // If no next prayer found today, show first prayer
      if (nextPrayer.isEmpty) {
        nextPrayer = prayerList[1]['name'];
        nextTime = _formatTime(prayerList[1]['time'] as DateTime?);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ResponsiveHeader(title: 'আজান'),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  color: const Color(0xFF00BFA5).withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'পরবর্তী নামাজ',
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                      Text(
                        '$nextPrayer - $nextTime',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: prayerList.length,
                    itemBuilder: (context, index) {
                      return _buildPrayerTimeItem(
                        prayerList[index]['name'],
                        _formatTime(prayerList[index]['time'] as DateTime?),
                        prayerList[index]['isAlertOn'],
                         (value) {
                          setState(() {
                            prayerList[index]['isAlertOn'] = value;
                            _saveToggleState(prayerList[index]['name'], value);
                          });
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.1,
                  child: const Advertisement2(),
                ),
              ],
            ),
    );
  }

  Widget _buildPrayerTimeItem(String prayerName, String time, bool isAlertOn, Function(bool)? onToggle) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListTile(
      leading: Icon(
        Icons.access_time,
        color: const Color(0xFF00BFA5),
        size: screenWidth * 0.08,
      ),
      title: Text(
        prayerName,
        style: TextStyle(fontSize: screenWidth * 0.05),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyle(fontSize: screenWidth * 0.05),
          ),
          SizedBox(width: screenWidth * 0.02),
          
            Transform.scale(
              scale: 0.7,
              child: Switch(
                value: isAlertOn,
                onChanged: onToggle,
                activeColor: const Color(0xFF00BFA5),
              ),
            ),
        ],
      ),
    );
  }
}
