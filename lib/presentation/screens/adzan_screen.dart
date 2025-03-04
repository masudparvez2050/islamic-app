import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/common/headerAdzan.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart'; // For formatting time
import 'package:audioplayers/audioplayers.dart'; // Optional for Azan sound
import 'package:religion/presentation/widgets/add_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdzanScreen extends StatefulWidget {
  const AdzanScreen({Key? key}) : super(key: key);

  @override
  _AdzanScreenState createState() => _AdzanScreenState();
}

class _AdzanScreenState extends State<AdzanScreen> {
  late PrayerTimes prayerTimes;
  bool isLoading = true;
  List<Map<String, dynamic>> prayerList = [
    {'name': 'ফজর', 'time': '', 'isAlertOn': false},
    {'name': 'জোহর', 'time': '', 'isAlertOn': false},
    {'name': 'আসর', 'time': '', 'isAlertOn': false},
    {'name': 'মাগরিব', 'time': '', 'isAlertOn': false},
    {'name': 'ইশা', 'time': '', 'isAlertOn': false},
  ];

  @override
  void initState() {
    super.initState();
    _loadToggleStates(); // Load saved states
    _fetchPrayerTimes();
    _startPrayerCheckTimer();
  }

  // Load toggle states from SharedPreferences
  Future<void> _loadToggleStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var prayer in prayerList) {
        prayer['isAlertOn'] = prefs.getBool('${prayer['name']}_alert') ?? false;
      }
    });
  }

  // Save toggle state to SharedPreferences
  Future<void> _saveToggleState(String prayerName, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${prayerName}_alert', value);
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      Position position = await _determinePosition();
      final coordinates = Coordinates(position.latitude, position.longitude);
      final params = CalculationMethod.karachi.getParameters();
      params.madhab =Madhab.hanafi;
      prayerTimes = PrayerTimes.today(coordinates, params);

      setState(() {
        prayerList[0]['time'] = _formatTime(prayerTimes.fajr);
        prayerList[1]['time'] = _formatTime(prayerTimes.dhuhr);
        prayerList[2]['time'] = _formatTime(prayerTimes.asr);
        prayerList[3]['time'] = _formatTime(prayerTimes.maghrib);
        prayerList[4]['time'] = _formatTime(prayerTimes.isha);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching prayer times: $e');
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

  String _formatTime(DateTime time) {
    // print(time);
    return DateFormat('hh:mm a', 'bn').format(time);
  }

  void _startPrayerCheckTimer() {
    Future.delayed(Duration(seconds: 60), () {
      _checkPrayerAlerts();
      _startPrayerCheckTimer();
    });
  }

  void _checkPrayerAlerts() {
    final now = DateTime.now();
    for (var prayer in prayerList) {
      if (prayer['isAlertOn']) {
        final prayerTime = DateTime(now.year, now.month, now.day,
            int.parse(prayer['time'].split(':')[0]),
            int.parse(prayer['time'].split(':')[1].split(' ')[0]));
        if (now.hour == prayerTime.hour && now.minute == prayerTime.minute) {
          _showAzanAlert(prayer['name']);
        }
      }
    }
  }

  void _showAzanAlert(String prayerName) async {
    final player = AudioPlayer();
    await player.play(AssetSource('azan.mp3'));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('আজান'),
        content: Text('$prayerName এর আজান বাজছে!'),
        actions: [
          TextButton(
            onPressed: () {
              player.stop();
              Navigator.pop(context);
            },
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    String nextPrayer = '';
    String nextTime = '';
    if (!isLoading) {
      final now = DateTime.now();
      final prayerTimesList = [
        {'name': 'ফজর', 'time': prayerTimes.fajr},
        {'name': 'জোহর', 'time': prayerTimes.dhuhr},
        {'name': 'আসর', 'time': prayerTimes.asr},
        {'name': 'মাগরিব', 'time': prayerTimes.maghrib},
        {'name': 'ইশা', 'time': prayerTimes.isha},
      ];
      for (var prayer in prayerTimesList) {
        if (now.isBefore(prayer['time'] as DateTime)) {
          nextPrayer = prayer['name'] as String;
          nextTime = _formatTime(prayer['time'] as DateTime);
          break;
        }
      }
      if (nextPrayer.isEmpty) {
        nextPrayer = prayerList[0]['name'];
        nextTime = prayerList[0]['time'];
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveHeader(title: 'আজান'),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
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
                        prayerList[index]['time'],
                        prayerList[index]['isAlertOn'],
                        (value) {
                          setState(() {
                            prayerList[index]['isAlertOn'] = value;
                            _saveToggleState(prayerList[index]['name'], value); // Save when toggled
                          });
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.1,
                  child: Advertisement2(),
                ),
              ],
            ),
    );
  }

  Widget _buildPrayerTimeItem(String prayerName, String time, bool isAlertOn, Function(bool) onToggle) {
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