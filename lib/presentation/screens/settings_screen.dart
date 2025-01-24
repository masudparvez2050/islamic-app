import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView(
        children: [
          _buildSettingItem(context, 'Login / Profile', Icons.person, () {
            // TODO: Implement login/profile functionality
          }),
          _buildSettingItem(context, 'Language', Icons.language, () {
            // TODO: Implement language selection
          }),
          _buildSettingItem(context, 'Mode (Dark/Light)', Icons.brightness_6, () {
            // TODO: Implement theme mode toggle
          }),
          _buildSettingItem(context, 'Location', Icons.location_on, () {
            // TODO: Implement location settings
          }),
          _buildSettingItem(context, 'Madhab (Hanafi/Shafi)', Icons.school, () {
            // TODO: Implement madhab selection
          }),
          _buildSettingItem(context, 'Adhan Settings', Icons.volume_up, () {
            // TODO: Implement adhan settings
          }),
          _buildSettingItem(context, 'Alarm Settings', Icons.alarm, () {
            // TODO: Implement alarm settings
          }),
          _buildSettingItem(context, 'About Us', Icons.info, () {
            // TODO: Implement about us page
          }),
          _buildSettingItem(context, 'Developers', Icons.code, () {
            // TODO: Implement developers page
          }),
          _buildSettingItem(context, 'Powered By', Icons.power, () {
            // TODO: Implement powered by page
          }),
          _buildSettingItem(context, 'Social Links', Icons.share, () {
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

