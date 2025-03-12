import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksScreen extends StatelessWidget {
  const SocialLinksScreen({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'alhudaacademy2023@gmail.com',
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email');
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+8801601332914',
    );

    if (!await launchUrl(phoneLaunchUri)) {
      throw Exception('Could not launch phone');
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappLaunchUri = Uri.parse('https://wa.me/01601332914');

    if (!await launchUrl(whatsappLaunchUri)) {
      throw Exception('Could not launch WhatsApp');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('সোশ্যাল লিংক'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
        children: [
          _buildSocialCard(
            context,
            FontAwesomeIcons.globe,
            'Website',
            () => _launchURL('https://alhudabd.com'),
          ),
          _buildSocialCard(
            context,
            FontAwesomeIcons.facebook,
            'Facebook',
            () => _launchURL('https://www.facebook.com/share/1E2Sy7qSQ1/'),
          ),
          _buildSocialCard(
            context,
            FontAwesomeIcons.youtube,
            'YouTube',
            () => _launchURL('https://www.youtube.com/@alhudaacademy1123'),
          ),
          _buildSocialCard(
            context,
            FontAwesomeIcons.envelope,
            'Email',
            () => _launchEmail(),
          ),
          _buildSocialCard(
            context,
            FontAwesomeIcons.whatsapp,
            'WhatsApp',
            () => _launchWhatsApp(),
          ),
          _buildSocialCard(
            context,
            FontAwesomeIcons.phone,
            'Phone',
            () => _launchPhone(),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialCard(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: const Color(0xFF00BFA5)),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
