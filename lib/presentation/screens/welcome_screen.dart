import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup animations
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    // Start animation
    _controller.forward();
    
    // Navigate to home screen after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF00BFA5),
              const Color(0xFF009688),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Subtle background pattern
            Positioned(
              bottom: -height * 0.2,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  'assets/images/home_bg.png',
                  height: height * 0.7,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Content
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.22,
                            height: width * 0.22,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(width * 0.11),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.05),
                              child: Image.asset(
                                'assets/images/screen_logo.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: height * 0.04),
                          
                          Text(
                            'ধর্ম - Dharma',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.5,
                            ),
                          ),
                          
                          SizedBox(height: height * 0.02),
                          
                          Text(
                            'আধুনিক জীবনের জন্য আধ্যাত্মিক জ্ঞান',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: width * 0.032,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                            ),
                          ),
                          
                          SizedBox(height: height * 0.06),
                          
                          _buildLoadingIndicator(width),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLoadingIndicator(double width) {
    return SizedBox(
      width: width * 0.1,
      height: 4,
      child: LinearProgressIndicator(
        backgroundColor: Colors.white.withOpacity(0.1),
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:dharma/presentation/screens/home_screen.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Future.delayed(const Duration(seconds: 3), () {
//         if (mounted) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()),
//           );
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;

//     return Scaffold(
//       backgroundColor: const Color(0xFF00BFA5),
//       body: Stack(
//         children: [
//           Positioned(
//             bottom: -height * 0.25,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/images/home_bg.png',
//               color: const Color.fromARGB(255, 3, 70, 44).withOpacity(0.1),
//               height: height * 0.75,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               alignment: Alignment.bottomCenter,
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: width * 0.25,
//                   height: width * 0.25,
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 5, 207, 140).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(width * 0.125),
//                   ),
//                   child: Image.asset(
//                     'assets/images/screen_logo.png',
//                     color: Colors.white,
//                     height: width * 0.125,
//                     width: double.infinity,
//                   ),
//                 ),
//                 // const SizedBox(height: 20),
//                 // Text(
//                 //   'Welcome',
//                 //   style: TextStyle(
//                 //     color: Colors.white,
//                 //     fontSize: width * 0.08,
//                 //     fontWeight: FontWeight.bold,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

