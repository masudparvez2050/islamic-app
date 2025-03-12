import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('লোকেশন'),
      ),
      body: const Center(
        child: Text('Location Settings Screen'),
      ),
    );
  }
}
