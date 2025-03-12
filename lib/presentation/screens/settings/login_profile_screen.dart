import 'package:flutter/material.dart';

class LoginProfileScreen extends StatelessWidget {
  const LoginProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('লগইন / প্রোফাইল'),
      ),
      body: const Center(
        child: Text('Login / Profile Screen'),
      ),
    );
  }
}
