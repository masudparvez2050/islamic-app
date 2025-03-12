import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ভাষা'),
      ),
      body: const Center(
        child: Text('Language Selection Screen'),
      ),
    );
  }
}
