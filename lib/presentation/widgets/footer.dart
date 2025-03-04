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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: double.infinity,
      color: Colors.teal,
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Created & Directed By',
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.03,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: height * 0.015),
          // Logo
          Container(
            width: width * 0.12,
            height: width * 0.12,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(width * 0.02),
            child: Image.asset(
              'assets/images/alhuda_logo.png',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            'AL HUDA ACADEMY',
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.06,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: height * 0.015),
          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.globe, 
                () => _launchURL('https://alhudabd.com'), width),
              _buildSocialIcon(FontAwesomeIcons.facebook, 
                () => _launchURL('https://www.facebook.com/groups/1469984167721446/?ref=share&mibextid=NSMWBT'), width),
              _buildSocialIcon(FontAwesomeIcons.youtube, 
                () => _launchURL('https://www.youtube.com/@alhudaacademy1123'), width),
              _buildSocialIcon(FontAwesomeIcons.envelope, _launchEmail, width),
              _buildSocialIcon(FontAwesomeIcons.whatsapp, _launchWhatsApp, width),
              _buildSocialIcon(FontAwesomeIcons.phone, _launchPhone, width),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap, double width) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Icon(
          icon,
          color: Colors.white,
          size: width * 0.03,
        ),
      ),
    );
  }
}
