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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('সোশ্যাল লিংক'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Top curved container with illustration
          Container(
            width: double.infinity,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                    size: screenWidth * 0.08,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'আমাদের সাথে যোগাযোগ করুন',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Social media links
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildSectionTitle('ভিজিট করুন', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnimatedSocialCard(
                          context,
                          FontAwesomeIcons.globe,
                          'ওয়েবসাইট',
                          Colors.blue[700]!,
                          () => _launchURL('https://alhudabd.com'),
                          screenWidth,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: _buildAnimatedSocialCard(
                          context,
                          FontAwesomeIcons.facebook,
                          'ফেসবুক',
                          Colors.indigo,
                          () => _launchURL('https://www.facebook.com/share/1E2Sy7qSQ1/'),
                          screenWidth,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: screenHeight * 0.02),
                  
                  Row(
                    children: [
                      Expanded(
                      child: _buildAnimatedSocialCard(
                        context,
                        FontAwesomeIcons.youtube,
                        'ইউটিউব',
                        Colors.red,
                        () => _launchURL('https://www.youtube.com/@alhudaacademy1123'),
                        screenWidth,
                      ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                       Expanded(
                      child: _buildAnimatedSocialCard(
                        context,
                        FontAwesomeIcons.whatsapp,
                        'হোয়াটসঅ্যাপ',
                        const Color(0xFF25D366),
                        () => _launchWhatsApp(),
                        screenWidth,
                      ),
                      ),
                    ],
                    ),
                 
                  SizedBox(height: screenHeight * 0.03),
                  
                  _buildSectionTitle('যোগাযোগ করুন', screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  
                  _buildContactCard(
                    context,
                    FontAwesomeIcons.envelope,
                    'ইমেইল',
                    'alhudaacademy2023@gmail.com',
                    Colors.amber[800]!,
                    () => _launchEmail(),
                    screenWidth,
                  ),
                  
                  SizedBox(height: screenHeight * 0.015),
                  
                  _buildContactCard(
                    context,
                    FontAwesomeIcons.whatsapp,
                    'হোয়াটসঅ্যাপ',
                    '+৮৮০১৬০১৩৩২৯১৪',
                    const Color(0xFF25D366),
                    () => _launchWhatsApp(),
                    screenWidth,
                  ),
                  
                  SizedBox(height: screenHeight * 0.015),
                  
                  _buildContactCard(
                    context,
                    FontAwesomeIcons.phone,
                    'ফোন',
                    '+৮৮০১৬০১৩৩২৯১৪',
                    Colors.blue,
                    () => _launchPhone(),
                    screenWidth,
                  ),
                  
                  SizedBox(height: screenHeight * 0.04),
                  
                  // Feedback button
                    ElevatedButton(
                    onPressed: () {
                      // Launch Facebook group page
                      _launchURL('https://www.facebook.com/groups/1469984167721446/?ref=share&mibextid=NSMWBT');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('আপনার মতামত জানান'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.01, bottom: screenWidth * 0.01),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildAnimatedSocialCard(
    BuildContext context, 
    IconData icon, 
    String title, 
    Color color,
    VoidCallback onTap,
    double screenWidth,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.06,
          horizontal: screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: FaIcon(
                icon, 
                size: screenWidth * 0.07, 
                color: color,
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.038,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context, 
    IconData icon, 
    String title, 
    String subtitle,
    Color color,
    VoidCallback onTap,
    double screenWidth,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FaIcon(
                icon, 
                size: screenWidth * 0.05, 
                color: color,
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: screenWidth * 0.04,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}