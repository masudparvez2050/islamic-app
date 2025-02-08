import 'package:flutter/material.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Qibla Direction'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Qibla Direction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF00BFA5), width: 2),
              ),
              child: const Center(
                child: Icon(Icons.explore, size: 100, color: Color(0xFF00BFA5)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '125° SE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Face southeast to pray towards the Qibla',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

