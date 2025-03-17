import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('আমাদের সম্পর্কে'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App logo and version
            Center(
              child: Column(
                children: [
                    Container(
                    height: screenWidth * 0.20,
                    width: screenWidth * 0.20,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    'ধর্ম - Dharma',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  Text(
                    'ভার্সন ১.০.০',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: screenHeight * 0.04),
            
            _buildSectionTitle('অ্যাপ পরিচিতি', screenWidth, theme),
            _buildCardWithContent(
              context,
              [
                _buildParagraph(
                  'ধর্ম - Dharma একটি মোবাইল অ্যাপ। এ অ্যাপে বিভিন্ন ধরনের ইসলামি ফিচার রয়েছে। মুসলমানদের জীবনঘনিষ্ট ও অতীব প্রয়োজনীয় বিষয়গুলো এ অ্যাপে সুন্দর ও সহজভাবে উপস্থাপন করা হয়েছে।',
                  screenWidth,
                ),
                _buildParagraph(
                  'এ অ্যাপে নামাজ, রোজা, হজ ও যাকাতের বিধিবিধান সংবলিত ফিচার রয়েছে। দৈনন্দিন জীবনের বিভিন্ন মাসনুন দোয়া, সকাল-সন্ধ্যার আমল, জিকির ও তাসবিহসহ গুরুত্বপূর্ণ মাসয়ালা-মাসায়েল রয়েছে। ঈদ, কুরবানি, রমজান, শবে কদর, শবে বরাত ও জুমার দিনের আলম এবং এসব দিনে করণীয় ও বর্জনীয় বিষয়ে ফিচার রয়েছে। (ধাপে ধাপে আপডেট করা হবে, ইন শা-আল্লাহ)।',
                  screenWidth,
                ),
                _buildParagraph(
                  'আন্তর্জাতিক Time zone ব্যবহার করে নামাজের সময়সূচি যুক্ত করা হয়েছে। এর মাধ্যমে পৃথিবীর যেকোনো প্রান্ত থেকে সঠিক সময়ে নামাজ পড়া যাবে। নামাজ ও আজানের এলার্ম যুক্ত করা হয়েছে; এটা অ্যাপ ব্যবহারকারীকে নামাজের কথা স্মরণ করিয়ে দেবে। এই অ্যাপে কিবলা কম্পাস রয়েছে; যা অপরিচিত জায়গায় আপনাকে কিবলার দিক দেখিয়ে দেবে।',
                  screenWidth,
                ),
                _buildParagraph(
                  '২০২৫ সালে অ্যাপটি তৈরি করেছে আল হুদা একাডেমি (alhudabd.com)। এটির মানোন্নয়ন ও সম্প্রসারণের কাজ চলমান রয়েছে। এ কাজে কেউ স্ব-আগ্রহে আমাদের সঙ্গী হতে চাইলে আমরা তাকে স্বাগত জানাই।',
                  screenWidth,
                ),
              ],
            ),
            
            SizedBox(height: screenHeight * 0.03),
            
            _buildSectionTitle('সংশ্লিষ্ট কর্মকর্তা', screenWidth, theme),
            _buildCardWithContent(
              context,
              [
                _buildTeamMember('ধর্ম ও ফতোয়া বিষয়ক উপদেষ্টা', 'মুফতি ইমরান বিন ইলিয়াস', screenWidth, theme),
                _buildDivider(),
                _buildTeamMember('মিডিয়া ও সংস্কৃতি বিষয়ক উপদেষ্টা', 'হুমায়ুন আইয়ুব', screenWidth, theme),
                _buildDivider(),
                _buildTeamMember('পরিচালক', 'আতাউর রহমান আলহাদী', screenWidth, theme),
                _buildDivider(),
                _buildTeamMember('সহকারি পরিচালক (মহিলা বিষয়ক)', 'সানজিদা রহমান', screenWidth, theme),
                _buildDivider(),
                _buildTeamMember('নির্বাহী পরিচালক', 'খলিলুর রহমান মাহদী', screenWidth, theme),
                _buildTeamMember('অ্যাপ ডেভেলপার', 'মাসুদুর রহমান ও তার সহযোগী সদস্য', screenWidth, theme),
              ],
            ),
            
            SizedBox(height: screenHeight * 0.03),
            
            _buildSectionTitle('যোগাযোগ', screenWidth, theme),
            _buildContactCard(context, '+8801601332914', 'https://wa.me/8801601332914', 'alhudaacademy2023@gmail.com', screenWidth),
            
            SizedBox(height: screenHeight * 0.04),
            
            // Social media profiles
            Center(
              child: Wrap(
                spacing: screenWidth * 0.05,
                children: [
                  _buildSocialButton(FontAwesomeIcons.facebook, Colors.blue[800]!, 'https://www.facebook.com/share/1E2Sy7qSQ1/', screenWidth),
                  _buildSocialButton(FontAwesomeIcons.youtube, Colors.red, 'https://www.youtube.com/@alhudaacademy1123', screenWidth),
                  _buildSocialButton(FontAwesomeIcons.globe, Colors.blue, 'https://alhudabd.com', screenWidth),
                  // _buildSocialButton(FontAwesomeIcons.twitter, Colors.blue, 'https://twitter.com/alhudabd', screenWidth),
                ],
              ),
            ),
            
            SizedBox(height: screenHeight * 0.04),
               // Feedback button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Launch Facebook group page
                          _launchURL('https://www.facebook.com/groups/1469984167721446/?ref=share&mibextid=NSMWBT');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFA5),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.018,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text('আপনার মতামত জানান'),
                      ),
                    ),
                    
                    SizedBox(height: screenHeight * 0.03),
            
            // Copyright text
            Center(
              child: Text(
                '© ২০২৫ আল হুদা একাডেমি। সর্বস্বত্ব সংরক্ষিত।',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.03),
      child: Row(
        children: [
          Container(
            width: 4,
            height: screenWidth * 0.06,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithContent(BuildContext context, List<Widget> children) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.03),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          color: Colors.grey[800],
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildTeamMember(String position, String name, double screenWidth, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.04,
            backgroundColor: theme.primaryColor.withOpacity(0.2),
            child: Icon(
              Icons.person,
              size: screenWidth * 0.04,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  position,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 8, thickness: 0.5);
  }

  Widget _buildContactCard(BuildContext context, String phone, String whatsapp, String email, double screenWidth) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactItem(
              context,
              Icons.phone_rounded, 
              phone, 
              'মোবাইল', 
              'tel:$phone', 
              screenWidth,
              Colors.teal,
            ),
            _buildDivider(),
            _buildContactItem(
              context,
              FontAwesomeIcons.whatsapp, 
              'WhatsApp', 
              'ম্যাসেজ করুন', 
              whatsapp, 
              screenWidth,
              Color(0xFF25D366),
            ),
            _buildDivider(),
            _buildContactItem(
              context,
              Icons.email_rounded, 
              email, 
              'ইমেইল', 
              'mailto:$email', 
              screenWidth,
              Colors.red[700]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String text, String label, String url, double screenWidth, Color iconColor) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: screenWidth * 0.05),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
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

  Widget _buildSocialButton(IconData icon, Color color, String url, double screenWidth) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(screenWidth * 0.06),
      child: Container(
        width: screenWidth * 0.12,
        height: screenWidth * 0.12,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.06),
        ),
        child: Icon(
          icon,
          color: color,
          size: screenWidth * 0.06,
        ),
      ),
    );
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}