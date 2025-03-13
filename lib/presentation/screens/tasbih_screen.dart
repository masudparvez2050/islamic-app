// import 'package:flutter/material.dart';
// import 'package:dharma/presentation/widgets/common/headerAdzan.dart';

// class TasbihScreen extends StatefulWidget {
//   const TasbihScreen({Key? key}) : super(key: key);

//   @override
//   _TasbihScreenState createState() => _TasbihScreenState();
// }

// class _TasbihScreenState extends State<TasbihScreen> {
//   int _count = 0;
//   int _totalCount = 0;
//   String _selectedTasbih = 'সাধারণ'; // Default tasbih type

//   String _bnDigit(int number) {
//     final bn = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
//     return number.toString().split('').map((e) => bn[int.parse(e)]).join();
//   }

//   void _incrementCount() {
//     setState(() {
//       _count++;
//       _totalCount++;
//     });
//   }

//   void _resetCount() {
//     setState(() {
//       _count = 0;
//     });
//   }

//   void _resetTotalCount() {
//     setState(() {
//       _totalCount = 0;
//       _count = 0;
//     });
//   }

//   void _setPresetCount(int count) {
//     setState(() {
//       _count = count;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: ResponsiveHeader(title: 'তাসবিহ'), // Using responsive header
//       body: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Tasbih Type Dropdown
//             DropdownButton<String>(
//               value: _selectedTasbih,
//               items: <String>['সাধারণ', 'সুবহানআল্লাহ', 'আলহামদুলিল্লাহ', 'আল্লাহু আকবার']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
//                   ),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedTasbih = newValue!;
//                   if (_selectedTasbih != 'সাধারণ') {
//                     _setPresetCount(33); // Set to 33 for Allah's names
//                   } else {
//                     _count = 0; // Reset for general tasbih
//                   }
//                 });
//               },
//             ),
//             SizedBox(height: screenHeight * 0.03), // 3% of screen height
//             // Current Count Display
//             Text(
//               _bnDigit(_count),
//               style: TextStyle(
//                 fontSize: screenWidth * 0.18, // 18% of screen width
//                 fontWeight: FontWeight.bold,
//                 color: const Color(0xFF00BFA5),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02), // 2% of screen height
//             // Total Count Display
//             Text(
//               'মোট গণনা: ${_bnDigit(_totalCount)}',
//               style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
//             ),
//             SizedBox(height: screenHeight * 0.05), // 5% of screen height
//             // Increment Button
//             GestureDetector(
//               onTap: _incrementCount,
//               child: Container(
//                 width: screenWidth * 0.4, // 40% of screen width
//                 height: screenWidth * 0.4, // Square shape, 40% of screen width
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF00BFA5), Color(0xFF00C4B4)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                   size: screenWidth * 0.15, // 15% of screen width
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.03), // 3% of screen height
//             // Reset Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _resetCount,
//                   style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * 0.08, // 8% of screen width
//                     vertical: screenHeight * 0.015, // 1.5% of screen height
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   ),
//                   child: Text(
//                   'বর্তমান রিসেট',
//                   style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white), // 4% of screen width
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.03), // 3% of screen width
//                 ElevatedButton(
//                   onPressed: _resetTotalCount,
//                   style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orangeAccent,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: screenWidth * 0.08, // 8% of screen width
//                     vertical: screenHeight * 0.015, // 1.5% of screen height
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   ),
//                   child: Text(
//                   'মোট রিসেট',
//                   style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white), // 4% of screen width
//                   ),
//                 ),
                
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({Key? key}) : super(key: key);

  @override
  _TasbihScreenState createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> with SingleTickerProviderStateMixin {
  int _count = 0;
  int _totalCount = 0;
  String _selectedTasbih = 'সাধারণ'; // Default tasbih type
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOptionsVisible = false;
  final List<String> _tasbihTypes = [
    'সাধারণ',
    'সুবহানআল্লাহ',
    'আলহামদুলিল্লাহ',
    'আল্লাহু আকবার',
    'লা ইলাহা ইল্লাল্লাহু',
    'আস্তাগফিরুল্লাহ',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _bnDigit(int number) {
    final bn = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return number.toString().split('').map((e) => bn[int.parse(e)]).join();
  }

  void _incrementCount() {
    HapticFeedback.lightImpact();
    setState(() {
      _count++;
      _totalCount++;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _resetCount() {
    HapticFeedback.mediumImpact();
    setState(() {
      _count = 0;
    });
  }

  void _resetTotalCount() {
    HapticFeedback.heavyImpact();
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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color primaryColor = const Color(0xFF00BFA5);
    final Color secondaryColor = const Color(0xFF009688);
    final Color backgroundColor = isDarkMode ? const Color(0xFF121212) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final Color cardColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'তাসবিহ',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05, // 5% of screen width
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor, size: screenWidth * 0.06), // 6% of screen width
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isOptionsVisible ? Icons.close : Icons.more_vert,
              color: textColor,
              size: screenWidth * 0.06, // 6% of screen width
            ),
            onPressed: () {
              setState(() {
                _isOptionsVisible = !_isOptionsVisible;
              });
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor.withOpacity(0.05),
                  backgroundColor,
                  backgroundColor,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // 6% of screen width
              child: Column(
                children: [
                  // Tasbih selector
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015, // 1.5% of screen height
                      horizontal: screenWidth * 0.04, // 4% of screen width
                    ),
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.02, // 2% of screen height
                      bottom: screenHeight * 0.03, // 3% of screen height
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(screenWidth * 0.0375), // 3.75% of screen width
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: screenWidth * 0.025, // 2.5% of screen width
                          offset: Offset(0, screenHeight * 0.005), // 0.5% of screen height
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(screenWidth * 0.02), // 2% of screen width
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.auto_awesome,
                                  color: primaryColor,
                                  size: screenWidth * 0.05, // 5% of screen width
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04), // 4% of screen width
                              Expanded(
                                child: Text(
                                  _selectedTasbih,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04, // 4% of screen width
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: primaryColor,
                            size: screenWidth * 0.06, // 6% of screen width
                          ),
                          onPressed: () => _showTasbihSelector(context),
                        ),
                      ],
                    ),
                  ),

                  // Counts container
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Goal indicator (only for non-general tasbih)
                          if (_selectedTasbih != 'সাধারণ')
                            Column(
                              children: [
                                Text(
                                  'লক্ষ্য: ৩৩',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04, // 4% of screen width
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02), // 2% of screen height
                                // Progress indicator
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.4, // 40% of screen width
                                      height: screenWidth * 0.4, // 40% of screen width
                                      child: CircularProgressIndicator(
                                        value: _count / 33,
                                        strokeWidth: screenWidth * 0.02, // 2% of screen width
                                        backgroundColor: Colors.grey.withOpacity(0.2),
                                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                      ),
                                    ),
                                    // Current count
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(begin: 0, end: 1),
                                      duration: const Duration(milliseconds: 500),
                                      builder: (context, value, child) {
                                        return Opacity(
                                          opacity: value,
                                          child: child,
                                        );
                                      },
                                      child: Text(
                                        _bnDigit(_count),
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.12, // 12% of screen width
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          else
                            // Simple counter for general tasbih
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: 1.0 + _animation.value * 0.1,
                                  child: Text(
                                    _bnDigit(_count),
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.18, // 18% of screen width
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),

                          SizedBox(height: screenHeight * 0.03), // 3% of screen height

                          // Total count with subtle design
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06, // 6% of screen width
                              vertical: screenHeight * 0.01, // 1% of screen height
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(screenWidth * 0.075), // 7.5% of screen width
                            ),
                            child: Text(
                              'মোট গণনা: ${_bnDigit(_totalCount)}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04, // 4% of screen width
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom controls
                  Container(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.05), // 5% of screen height
                    child: Column(
                      children: [
                        // Main counter button
                        GestureDetector(
                          onTap: _incrementCount,
                          child: Container(
                            width: screenWidth * 0.28, // 28% of screen width
                            height: screenWidth * 0.28, // 28% of screen width
                            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 2% of screen height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [primaryColor, secondaryColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  spreadRadius: screenWidth * 0.0025, // 0.25% of screen width
                                  blurRadius: screenWidth * 0.0375, // 3.75% of screen width
                                  offset: Offset(0, screenHeight * 0.00625), // 0.625% of screen height
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: screenWidth * 0.1, // 10% of screen width
                              ),
                            ),
                          ),
                        ),

                        // Reset buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildResetButton(
                              onPressed: _resetCount,
                              label: 'বর্তমান রিসেট',
                              color: Colors.redAccent,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                            SizedBox(width: screenWidth * 0.04), // 4% of screen width
                            _buildResetButton(
                              onPressed: _resetTotalCount,
                              label: 'মোট রিসেট',
                              color: Colors.orangeAccent,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Options panel
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: _isOptionsVisible ? 0 : -screenWidth * 0.6, // 60% of screen width
            top: screenHeight * 0.1, // 10% of screen height
            child: Container(
              width: screenWidth * 0.6, // 60% of screen width
              padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenWidth * 0.05), // 5% of screen width
                  bottomLeft: Radius.circular(screenWidth * 0.05), // 5% of screen width
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: screenWidth * 0.025, // 2.5% of screen width
                    spreadRadius: screenWidth * 0.0025, // 0.25% of screen width
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'উপলব্ধ তাসবিহ',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% of screen width
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // 2% of screen height
                  ..._tasbihTypes.map((type) => _buildTasbihOption(type)),
                  SizedBox(height: screenHeight * 0.02), // 2% of screen height
                  Divider(),
                  SizedBox(height: screenHeight * 0.01), // 1% of screen height
                  _buildOptionItem(
                    icon: Icons.dark_mode,
                    title: 'ডার্ক মোড',
                    onTap: () {
                      // Toggle dark mode
                    },
                    screenWidth: screenWidth,
                  ),
                  _buildOptionItem(
                    icon: Icons.vibration,
                    title: 'ভাইব্রেশন',
                    onTap: () {
                      // Toggle vibration
                    },
                    screenWidth: screenWidth,
                  ),
                  _buildOptionItem(
                    icon: Icons.share,
                    title: 'শেয়ার',
                    onTap: () {
                      // Share app
                    },
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetButton({
    required VoidCallback onPressed,
    required String label,
    required Color color,
    required double screenWidth,
    required double screenHeight,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, // 4% of screen width
          vertical: screenHeight * 0.01, // 1% of screen height
        ),
        backgroundColor: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03), // 3% of screen width
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.refresh, size: screenWidth * 0.04), // 4% of screen width
          SizedBox(width: screenWidth * 0.01), // 1% of screen width
          Text(
            label,
            style: TextStyle(fontSize: screenWidth * 0.035), // 3.5% of screen width
          ),
        ],
      ),
    );
  }

  Widget _buildTasbihOption(String type) {
    final bool isSelected = _selectedTasbih == type;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        type,
        style: TextStyle(
          color: isSelected ? const Color(0xFF00BFA5) : null,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
        ),
      ),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected ? const Color(0xFF00BFA5) : Colors.grey,
        size: MediaQuery.of(context).size.width * 0.05, // 5% of screen width
      ),
      dense: true,
      onTap: () {
        setState(() {
          _selectedTasbih = type;
          if (_selectedTasbih != 'সাধারণ') {
            _setPresetCount(33); // Set to 33 for specific tasbih
          } else {
            _count = 0; // Reset for general tasbih
          }
          _isOptionsVisible = false;
        });
      },
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double screenWidth,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: screenWidth * 0.05), // 5% of screen width
      title: Text(
        title,
        style: TextStyle(fontSize: screenWidth * 0.04), // 4% of screen width
      ),
      dense: true,
      onTap: onTap,
    );
  }

  void _showTasbihSelector(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05), // 5% of screen width
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03), // 3% of screen height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // 6% of screen width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'তাসবিহ নির্বাচন করুন',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% of screen width
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: screenWidth * 0.06), // 6% of screen width
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            Divider(height: screenHeight * 0.00125), // 0.125% of screen height
            Expanded(
              child: ListView.builder(
                itemCount: _tasbihTypes.length,
                itemBuilder: (context, index) {
                  final type = _tasbihTypes[index];
                  final isSelected = type == _selectedTasbih;
                  return ListTile(
                    title: Text(
                      type,
                      style: TextStyle(fontSize: screenWidth * 0.04), // 4% of screen width
                    ),
                    trailing: isSelected
                        ? Icon(
                            Icons.check,
                            color: const Color(0xFF00BFA5),
                            size: screenWidth * 0.05, // 5% of screen width
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedTasbih = type;
                        if (_selectedTasbih != 'সাধারণ') {
                          _setPresetCount(33);
                        } else {
                          _count = 0;
                        }
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}