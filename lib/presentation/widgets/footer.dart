import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

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
      path: '+88001601332914',
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
    return Container(
      width: double.infinity,
      color: Colors.teal,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Created & Directed By',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 12),
          // Logo
            Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Image.asset(
              'assets/images/alhuda_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'AL HUDA ACADEMY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 12),
          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.globe, 
                () => _launchURL('https://alhudabd.com')),
              _buildSocialIcon(FontAwesomeIcons.facebook, 
                () => _launchURL('https://facebook.com/alhudabdhttps://www.facebook.com/profile.php?id=100091305081988&mibextid=ZbWKwL')),
              _buildSocialIcon(FontAwesomeIcons.youtube, 
                () => _launchURL('https://www.youtube.com/@alhudaacademy1123')),
              _buildSocialIcon(FontAwesomeIcons.envelope, _launchEmail),
              _buildSocialIcon(FontAwesomeIcons.whatsapp, _launchWhatsApp),
              _buildSocialIcon(FontAwesomeIcons.phone, _launchPhone),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          icon,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }
}

