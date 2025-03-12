import 'package:flutter/material.dart';
import 'package:dharma/presentation/widgets/powered_by.dart';
import 'package:dharma/presentation/widgets/footer.dart';

class PoweredByScreen extends StatelessWidget {
  const PoweredByScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('পাওয়ার্ড বাই'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PoweredBy(),
            SizedBox(height: 20), // Add some space between PoweredBy and Footer
            Footer(),
          ],
        ),
      ),
    );
  }
}
