import 'package:flutter/material.dart';

class ThemeModeScreen extends StatelessWidget {
  const ThemeModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('মুড (ডার্ক/লাইট)'),
      ),
      body: const Center(
        child: Text('Theme Mode Selection Screen'),
      ),
    );
  }
}
