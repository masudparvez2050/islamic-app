import 'package:flutter/material.dart';

class DevelopersScreen extends StatelessWidget {
  const DevelopersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ডেভেলপার'),
      ),
      body: const Center(
        child: Text('Developers Screen'),
      ),
    );
  }
}
