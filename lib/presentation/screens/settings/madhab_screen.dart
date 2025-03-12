import 'package:flutter/material.dart';

class MadhabScreen extends StatelessWidget {
  const MadhabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('মাজহাব (হানাফি/শাফি)'),
      ),
      body: const Center(
        child: Text('Madhab Selection Screen'),
      ),
    );
  }
}
