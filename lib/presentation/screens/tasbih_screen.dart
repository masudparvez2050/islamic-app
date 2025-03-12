import 'package:flutter/material.dart';
import 'package:dharma/presentation/widgets/common/headerAdzan.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({Key? key}) : super(key: key);

  @override
  _TasbihScreenState createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _totalCount = 0;
  String _selectedTasbih = 'সাধারণ'; // Default tasbih type

  String _bnDigit(int number) {
    final bn = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return number.toString().split('').map((e) => bn[int.parse(e)]).join();
  }

  void _incrementCount() {
    setState(() {
      _count++;
      _totalCount++;
    });
  }

  void _resetCount() {
    setState(() {
      _count = 0;
    });
  }

  void _resetTotalCount() {
    setState(() {
      _totalCount = 0;
      _count = 0;
    });
  }

  void _setPresetCount(int count) {
    setState(() {
      _count = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveHeader(title: 'তাসবিহ'), // Using responsive header
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tasbih Type Dropdown
            DropdownButton<String>(
              value: _selectedTasbih,
              items: <String>['সাধারণ', 'সুবহানআল্লাহ', 'আলহামদুলিল্লাহ', 'আল্লাহু আকবার']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTasbih = newValue!;
                  if (_selectedTasbih != 'সাধারণ') {
                    _setPresetCount(33); // Set to 33 for Allah's names
                  } else {
                    _count = 0; // Reset for general tasbih
                  }
                });
              },
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            // Current Count Display
            Text(
              _bnDigit(_count),
              style: TextStyle(
                fontSize: screenWidth * 0.18, // 18% of screen width
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00BFA5),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            // Total Count Display
            Text(
              'মোট গণনা: ${_bnDigit(_totalCount)}',
              style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
            ),
            SizedBox(height: screenHeight * 0.05), // 5% of screen height
            // Increment Button
            GestureDetector(
              onTap: _incrementCount,
              child: Container(
                width: screenWidth * 0.4, // 40% of screen width
                height: screenWidth * 0.4, // Square shape, 40% of screen width
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00BFA5), Color(0xFF00C4B4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: screenWidth * 0.15, // 15% of screen width
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            // Reset Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _resetCount,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08, // 8% of screen width
                    vertical: screenHeight * 0.015, // 1.5% of screen height
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  ),
                  child: Text(
                  'বর্তমান রিসেট',
                  style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white), // 4% of screen width
                  ),
                ),
                SizedBox(width: screenWidth * 0.03), // 3% of screen width
                ElevatedButton(
                  onPressed: _resetTotalCount,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08, // 8% of screen width
                    vertical: screenHeight * 0.015, // 1.5% of screen height
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  ),
                  child: Text(
                  'মোট রিসেট',
                  style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white), // 4% of screen width
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}