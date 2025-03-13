import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dharma/presentation/widgets/common/headerRamadanCalender.dart';

class RamadanCalendarScreen extends StatefulWidget {
  const RamadanCalendarScreen({Key? key}) : super(key: key);

  @override
  _RamadanCalendarScreenState createState() => _RamadanCalendarScreenState();
}

class _RamadanCalendarScreenState extends State<RamadanCalendarScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _ramadanTimings = [];
  final Map<String, String> _hijriBanglaMonths = {
    'Muharram': 'মুহাররম',
    'Safar': 'সফর',
    'Rabi\' al-awwal': 'রবিউল আউয়াল',
    'Rabi\' al-thani': 'রবিউস সানি',
    'Jumada al-awwal': 'জুমাদাল উলা',
    'Jumada al-thani': 'জুমাদাল উখরা',
    'Rajab': 'রজব',
    'Sha\'ban': 'শাবান',
    'Ramadan': 'রমজান',
    'Shawwal': 'শাওয়াল',
    'Dhu al-Qi\'dah': 'জিলকদ',
    'Dhu al-Hijjah': 'জিলহজ',
  };

  final Map<String, String> _englishToBanglaNumerals = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯'
  };

  late TabController _tabController;
  int _selectedDayIndex = 0;
  bool _isListView = false;
  String _selectedFilter = 'all';
  late double screenWidth; // Define as instance variable
  late double screenHeight; // Define as instance variable

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('bn_BD');
    _generateRamadanTimings();

    final now = DateTime.now();
    final todayIndex = _ramadanTimings.indexWhere((timing) {
      final date = timing['date'] as DateTime;
      return date.day == now.day && date.month == now.month && date.year == now.year;
    });

    _selectedDayIndex = todayIndex != -1 ? todayIndex : 0;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _convertToBanglaNumber(String number) {
    String result = '';
    for (int i = 0; i < number.length; i++) {
      result += _englishToBanglaNumerals[number[i]] ?? number[i];
    }
    return result;
  }

  String _formatHijriDateInBangla(HijriCalendar hijriDate) {
    String dayString = _convertToBanglaNumber(hijriDate.hDay.toString());
    String monthName = _hijriBanglaMonths[hijriDate.longMonthName] ?? hijriDate.longMonthName;
    String yearString = _convertToBanglaNumber(hijriDate.hYear.toString());
    return '$dayString $monthName $yearString হিজরি';
  }

  void _generateRamadanTimings() {
    DateTime gregorianDate = DateTime(2025, 3, 2);
    for (int i = 0; i < 30; i++) {
      final hijriDate = _getAdjustedHijriDate(gregorianDate);
      _ramadanTimings.add({
        'date': gregorianDate,
        'hijriDate': hijriDate,
        'sehri': _calculateSehriTime(gregorianDate),
        'iftar': _calculateIftarTime(gregorianDate),
        'day': i + 1,
      });
      gregorianDate = gregorianDate.add(const Duration(days: 1));
    }
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

  String _calculateSehriTime(DateTime date) {
    DateTime time = date.add(const Duration(hours: 5, minutes: 30));
    String formattedTime = DateFormat('hh:mm a').format(time);
    return _convertToBanglaNumber(formattedTime);
  }

  String _calculateIftarTime(DateTime date) {
    DateTime time = date.add(const Duration(hours: 18, minutes: 15));
    String formattedTime = DateFormat('hh:mm a').format(time);
    return _convertToBanglaNumber(formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Header(
          title: 'রমজান ক্যালেন্ডার ২০২৫',
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(_isListView ? Icons.grid_view_rounded : Icons.view_list_rounded),
            onPressed: () {
              setState(() {
                _isListView = !_isListView;
              });
            },
          ),
        ],
      ),
      body: _ramadanTimings.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildDetailCard(screenWidth, screenHeight),
                _buildViewToggleBar(screenWidth, screenHeight),
                Expanded(
                  child: _isListView
                      ? _buildListView(screenWidth, screenHeight)
                      : _buildGridView(screenWidth, screenHeight),
                ),
              ],
            ),
    );
  }

  Widget _buildDetailCard(double screenWidth, double screenHeight) {
    if (_ramadanTimings.isEmpty || _selectedDayIndex >= _ramadanTimings.length) {
      return const SizedBox();
    }

    final selectedDay = _ramadanTimings[_selectedDayIndex];
    final date = selectedDay['date'] as DateTime;
    final hijriDate = selectedDay['hijriDate'] as HijriCalendar;
    final sehri = selectedDay['sehri'] as String;
    final iftar = selectedDay['iftar'] as String;
    final day = selectedDay['day'] as int;

    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00BFA5), Color(0xFF009688)],
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00BFA5).withOpacity(0.3),
            blurRadius: screenWidth * 0.025,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.05,
              screenHeight * 0.025,
              screenWidth * 0.05,
              screenHeight * 0.012,
            ),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.12,
                  height: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.035),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _convertToBanglaNumber(day.toString()),
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                      Text(
                        'দিন',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE', 'bn_BD').format(date),
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        DateFormat('d MMMM, yyyy', 'bn_BD').format(date),
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        _formatHijriDateInBangla(hijriDate),
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white30, height: 1),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeColumn(
                  screenWidth,
                  icon: Icons.wb_twilight_rounded,
                  title: 'সেহরি শেষ',
                  time: sehri,
                ),
                Container(
                  height: screenHeight * 0.05,
                  width: 1,
                  color: Colors.white30,
                ),
                _buildTimeColumn(
                  screenWidth,
                  icon: Icons.wb_sunny_rounded,
                  title: 'ইফতার',
                  time: iftar,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(double screenWidth,
      {required IconData icon, required String title, required String time}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: screenWidth * 0.06,
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          time,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildViewToggleBar(double screenWidth, double screenHeight) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _isListView ? 'তালিকা দেখুন' : 'গ্রিড দেখুন',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
              fontSize: screenWidth * 0.04,
            ),
          ),
          Row(
            children: [
              _buildFilterChip(screenWidth, 'all', 'সব'),
              SizedBox(width: screenWidth * 0.02),
              _buildFilterChip(screenWidth, 'weekends', 'শুক্রবার'),
              SizedBox(width: screenWidth * 0.02),
              _buildFilterChip(screenWidth, 'even', 'জোড় দিন'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(double screenWidth, String value, String label) {
    final isSelected = _selectedFilter == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = value;
        });
      },
      borderRadius: BorderRadius.circular(screenWidth * 0.075),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenHeight * 0.0075,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00BFA5) : Colors.grey[200],
          borderRadius: BorderRadius.circular(screenWidth * 0.075),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(double screenWidth, double screenHeight) {
    final filteredTimings = _filterTimings();

    return GridView.builder(
      padding: EdgeInsets.all(screenWidth * 0.03),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: screenWidth * 0.03,
        mainAxisSpacing: screenHeight * 0.015,
      ),
      itemCount: filteredTimings.length,
      itemBuilder: (context, index) {
        final timing = filteredTimings[index];
        final originalIndex = _ramadanTimings.indexOf(timing);
        return _buildGridCard(screenWidth, screenHeight, timing, originalIndex);
      },
    );
  }

  Widget _buildListView(double screenWidth, double screenHeight) {
    final filteredTimings = _filterTimings();

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      itemCount: filteredTimings.length,
      itemBuilder: (context, index) {
        final timing = filteredTimings[index];
        final originalIndex = _ramadanTimings.indexOf(timing);
        return _buildListCard(screenWidth, screenHeight, timing, originalIndex);
      },
    );
  }

  List<Map<String, dynamic>> _filterTimings() {
    if (_selectedFilter == 'all') {
      return _ramadanTimings;
    } else if (_selectedFilter == 'weekends') {
      return _ramadanTimings
          .where((timing) => (timing['date'] as DateTime).weekday == DateTime.friday)
          .toList();
    } else if (_selectedFilter == 'even') {
      return _ramadanTimings.where((timing) => (timing['day'] as int) % 2 == 0).toList();
    }
    return _ramadanTimings;
  }

  Widget _buildGridCard(
      double screenWidth, double screenHeight, Map<String, dynamic> timing, int originalIndex) {
    final date = timing['date'] as DateTime;
    final hijriDate = timing['hijriDate'] as HijriCalendar;
    final sehri = timing['sehri'] as String;
    final iftar = timing['iftar'] as String;
    final day = timing['day'] as int;

    final isToday = DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;
    final isSelected = _selectedDayIndex == originalIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDayIndex = originalIndex;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00BFA5).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          border: Border.all(
            color: isSelected ? const Color(0xFF00BFA5) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            if (isSelected || isToday)
              BoxShadow(
                color: const Color(0xFF00BFA5).withOpacity(0.2),
                blurRadius: screenWidth * 0.02,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Stack(
          children: [
            if (isToday)
              Positioned(
                top: screenHeight * 0.01,
                right: screenWidth * 0.02,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00BFA5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: screenWidth * 0.03,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00BFA5).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: Text(
                          _convertToBanglaNumber(day.toString()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00BFA5),
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        child: Text(
                          DateFormat('d MMM', 'bn_BD').format(date),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                            fontSize: screenWidth * 0.03,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    DateFormat('EEEE', 'bn_BD').format(date),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.035,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'সেহরি',
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            sehri,
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ইফতার',
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            iftar,
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(
      double screenWidth, double screenHeight, Map<String, dynamic> timing, int originalIndex) {
    final date = timing['date'] as DateTime;
    final hijriDate = timing['hijriDate'] as HijriCalendar;
    final sehri = timing['sehri'] as String;
    final iftar = timing['iftar'] as String;
    final day = timing['day'] as int;

    final isToday = DateTime.now().day == date.day &&
        DateTime.now().month == date.month &&
        DateTime.now().year == date.year;
    final isSelected = _selectedDayIndex == originalIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDayIndex = originalIndex;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: screenHeight * 0.0125),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00BFA5).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          border: Border.all(
            color: isSelected ? const Color(0xFF00BFA5) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected || isToday)
              BoxShadow(
                color: const Color(0xFF00BFA5).withOpacity(0.2),
                blurRadius: screenWidth * 0.02,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
                child: Center(
                  child: Text(
                    _convertToBanglaNumber(day.toString()),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00BFA5),
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE', 'bn_BD').format(date),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    Text(
                      DateFormat('d MMMM, yyyy', 'bn_BD').format(date),
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'সেহরি',
                      style: TextStyle(
                        fontSize: screenWidth * 0.0275,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      sehri,
                      style: TextStyle(
                        fontSize: screenWidth * 0.0325,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ইফতার',
                      style: TextStyle(
                        fontSize: screenWidth * 0.0275,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      iftar,
                      style: TextStyle(
                        fontSize: screenWidth * 0.0325,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isToday)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5),
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: Text(
                    'আজ',
                    style: TextStyle(
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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