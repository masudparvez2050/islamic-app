import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:religion/presentation/screens/welcome_screen.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(); // Fix: No need to pass 'en' or 'bn_BD'
  // MobileAds.instance.initialize(); // Initialize Mobile Ads

 // debugPaintSizeEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00BFA5),
        scaffoldBackgroundColor: const Color(0xFF00BFA5),
        fontFamily: 'LalSalu',
      ),
      home: const WelcomeScreen(),
    );
  }
}
