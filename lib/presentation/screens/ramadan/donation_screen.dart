import 'package:flutter/material.dart';
import 'package:dharma/utils/header.dart'; // Import the responsive utility

class DonationScreen extends StatefulWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final accentColor = theme.colorScheme.secondary;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _animation,
          child: ListView(
            padding: EdgeInsets.all(responsiveWidth(context, 24.0)),
            children: <Widget>[
              // Header section
              Text(
                'দান ও সাদাকাহ',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: responsiveFontSize(context, 24.0),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 6)),
              Text(
                'রমজান দান গাইড',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.black54,
                  fontSize: responsiveFontSize(context, 18.0),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 32)),
              
              // Main content
              _buildInfoCard(
                context,
                'রমজানে সাদাকাহর গুরুত্ব',
                'রমজানে, সাদাকাহ দেওয়ার গুরুত্ব অপরিমেয়। আল্লাহ কুরআনে দানের গুরুত্বের উপর জোর দিয়েছেন, যারা উদারভাবে দান করে তাদের জন্য বড় পুরস্কারের প্রতিশ্রুতি দিয়েছেন। নবী মুহাম্মদ (সাঃ) রমজানে সবচেয়ে বেশি দানশীল ছিলেন।',
                Icons.favorite,
                Colors.red.shade100,
                Colors.red.shade400,
              ),
              
              _buildInfoCard(
                context,
                'আল্লাহ কি বলেন',
                'কুরআনে দানের গুণাবলী সম্পর্কে বিভিন্ন আয়াতে উল্লেখ আছে, যেখানে আল্লাহ এই বরকতময় মাসে ভালো কাজের প্রতিদান বাড়িয়ে দেন।',
                Icons.menu_book,
                Colors.green.shade100,
                Colors.green.shade400,
              ),
              
              _buildInfoCard(
                context,
                'নবী কি বলেন',
                'নবী (সাঃ) বলেছেন, "শ্রেষ্ঠ দান হল রমজানে দেওয়া দান।" তিনি আরও জোর দিয়েছেন যে সাদাকাহ সম্পদকে পবিত্র করে এবং মানুষকে আল্লাহর কাছে নিয়ে যায়।',
                Icons.format_quote,
                Colors.amber.shade100,
                Colors.amber.shade700,
              ),
              
              SizedBox(height: responsiveHeight(context, 32)),
              Text(
                'সাদাকাহ দেওয়ার উপায়:',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: responsiveFontSize(context, 20.0),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 16)),
              
              // Donation options
              _buildDonationOption(
                context,
                'অভাবীদের জন্য ইফতারের ব্যবস্থা করুন',
                Icons.food_bank,
                primaryColor.withOpacity(0.1),
                primaryColor,
              ),
              
              _buildDonationOption(
                context,
                'স্বনামধন্য দাতব্য প্রতিষ্ঠানে দান করুন',
                Icons.monetization_on,
                primaryColor.withOpacity(0.1),
                primaryColor,
              ),
              
              _buildDonationOption(
                context,
                'সময় এবং প্রচেষ্টা দিয়ে সাহায্য করুন',
                Icons.volunteer_activism,
                primaryColor.withOpacity(0.1),
                primaryColor,
              ),
              
              _buildDonationOption(
                context,
                'যারা কষ্টে আছে তাদের সহায়তা করুন',
                Icons.support_agent,
                primaryColor.withOpacity(0.1),
                primaryColor,
              ),
              
              SizedBox(height: responsiveHeight(context, 32)),
              _buildDonateButton(context, accentColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String content, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      margin: EdgeInsets.only(bottom: responsiveHeight(context, 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, responsiveHeight(context, 4)),
            blurRadius: responsiveWidth(context, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              top: -responsiveHeight(context, 15),
              right: -responsiveWidth(context, 15),
              child: Container(
                width: responsiveWidth(context, 80),
                height: responsiveHeight(context, 80),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(responsiveWidth(context, 20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(responsiveWidth(context, 12)),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: iconColor),
                      ),
                      SizedBox(width: responsiveWidth(context, 16)),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: responsiveFontSize(context, 18.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsiveHeight(context, 16)),
                  Text(
                    content,
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.black87,
                      fontSize: responsiveFontSize(context, 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationOption(BuildContext context, String title, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      margin: EdgeInsets.only(bottom: responsiveHeight(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: Offset(0, responsiveHeight(context, 2)),
            blurRadius: responsiveWidth(context, 8),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 20), vertical: responsiveHeight(context, 8)),
        leading: Container(
          padding: EdgeInsets.all(responsiveWidth(context, 8)),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: responsiveFontSize(context, 16.0),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: responsiveFontSize(context, 18.0)),
        onTap: () {
          // Handle donation option selection
        },
      ),
    );
  }

  Widget _buildDonateButton(BuildContext context, Color accentColor) {
    return SizedBox(
      width: double.infinity,
      height: responsiveHeight(context, 56),
      child: ElevatedButton(
        onPressed: () {
          // Implement donation logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'এখন দান করুন',
          style: TextStyle(
            fontSize: responsiveFontSize(context, 16.0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
