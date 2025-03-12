import 'package:flutter/material.dart';

class AdhanSettingsScreen extends StatelessWidget {
  const AdhanSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আজান সেটিংস'),
      ),
      body: const Center(
        child: Text('Adhan Settings Screen'),
      ),
    );
  }
}
