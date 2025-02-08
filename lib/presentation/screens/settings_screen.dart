import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('সেটিংস', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView(
        children: [
          _buildSettingItem(context, 'লগইন / প্রোফাইল', Icons.person, () {
            // TODO: Implement login/profile functionality
          }),
          _buildSettingItem(context, 'ভাষা', Icons.language, () {
            // TODO: Implement language selection
          }),
          _buildSettingItem(context, 'মুড (ডার্ক/লাইট)', Icons.brightness_6, () {
            // TODO: Implement theme mode toggle
          }),
          _buildSettingItem(context, 'লোকেশন', Icons.location_on, () {
            // TODO: Implement location settings
          }),
          _buildSettingItem(context, 'মাজহাব (হানাফি/শাফি)', Icons.school, () {
            // TODO: Implement madhab selection
          }),
          _buildSettingItem(context, 'আজান সেটিংস', Icons.volume_up, () {
            // TODO: Implement adhan settings
          }),
          _buildSettingItem(context, 'এলার্ম সেটিংস', Icons.alarm, () {
            // TODO: Implement alarm settings
          }),
          _buildSettingItem(context, 'আমাদের সম্পর্কে', Icons.info, () {
            // TODO: Implement about us page
          }),
          _buildSettingItem(context, 'ডেভেলপার', Icons.code, () {
            // TODO: Implement developers page
          }),
          _buildSettingItem(context, 'পাওয়ার্ড বাই', Icons.power, () {
            // TODO: Implement powered by page
          }),
          _buildSettingItem(context, 'সোশ্যাল লিংক', Icons.share, () {
            // TODO: Implement social links page
          }),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00BFA5)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

