import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:islam_app/presentation/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  await initializeDateFormatting('bn_BD', null);

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
        fontFamily: 'HindSiliguri',
      ),
      home: const WelcomeScreen(),
    );
  }
}
