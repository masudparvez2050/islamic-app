import 'package:flutter/material.dart';

class AlarmSettingsScreen extends StatelessWidget {
  const AlarmSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('এলার্ম সেটিংস'),
      ),
      body: const Center(
        child: Text('Alarm Settings Screen'),
      ),
    );
  }
}
