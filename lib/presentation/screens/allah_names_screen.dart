import 'package:flutter/material.dart';

class AllahNamesScreen extends StatelessWidget {
  const AllahNamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allah\'s 99 Names'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 99,
        itemBuilder: (context, index) {
          return _buildNameCard(index + 1, 'Ar-Rahman', 'The Most Gracious');
        },
      ),
    );
  }

  Widget _buildNameCard(int number, String arabicName, String englishMeaning) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00BFA5)),
            ),
            const SizedBox(height: 4),
            Text(
              arabicName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              englishMeaning,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

