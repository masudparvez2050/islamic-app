import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF00BFA5),
      body: Stack(
        children: [
          Positioned(
            bottom: -height * 0.25,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/home_bg.png',
              color: const Color.fromARGB(255, 3, 70, 44).withOpacity(0.1),
              height: height * 0.75,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.25,
                  height: width * 0.25,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 5, 207, 140).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(width * 0.125),
                  ),
                  child: Image.asset(
                    'assets/images/screen_logo.png',
                    color: Colors.white,
                    height: width * 0.125,
                    width: double.infinity,
                  ),
                ),
                // const SizedBox(height: 20),
                // Text(
                //   'Welcome',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: width * 0.08,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
