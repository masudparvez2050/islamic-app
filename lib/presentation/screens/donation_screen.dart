import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import for Clipboard

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'দান করুন',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, 
            vertical: screenHeight * 0.025
          ),
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00D0B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'আমাদের কাজে সহায়তা করুন',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'আপনার দান আমাদের ইসলামি শিক্ষা ও ইসলামি সংস্কৃতি প্রচার-প্রসার চালিয়ে যেতে সাহায্য করে। সেজন্য আপনার দান আমরা  কৃতজ্ঞতার সাথে গ্রহণ করছি।',
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(
              'দানের ধরন',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildDonationOption(context, 'যাকাত ও ফিতরা দান করুন', Icons.favorite_border_rounded, 'zakat', screenWidth, screenHeight),
            _buildDonationOption(context, 'নফল সাদাকাহ দান করুন', Icons.volunteer_activism_outlined, 'sadaqah', screenWidth, screenHeight),
            _buildDonationOption(context, 'অ্যাপ উন্নয়নে দান করুন', Icons.smartphone_rounded, 'app', screenWidth, screenHeight),
            _buildDonationOption(context, 'আল হুদা একাডেমি\'র উন্নয়নে দান করুন', Icons.school_outlined, 'academy', screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: () {
                // Show general donation account info popup
                _showDonationAccountInfo(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BFA5),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'এখনই দান করুন',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show account information popup
  void _showDonationAccountInfo(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 24),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEDF9F7),
                    ),
                    child: const Icon(
                      Icons.credit_card_rounded,
                      color: Color(0xFF00BFA5),
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'দান করার একাউন্টের তথ্য',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildAccountInfoCard(
                    context: context,
                    title: 'বিকাশ / নগদ একাউন্ট',
                    icon: Icons.phone_android_rounded,
                    details: '01601332914 (পার্সোনাল)',
                    copyText: '01601332914',
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 16),
                  _buildAccountInfoCard(
                    context: context,
                    title: 'ব্যাংক একাউন্ট',
                    icon: Icons.account_balance_rounded,
                    details: 'আতাউর রহমান\n20501450204712801\nমৌচাক শাখা, ইসলামী ব্যাংক বাংলাদেশ',
                    copyText: '20501450204712801',
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(screenWidth * 0.4, 48),
                      elevation: 0,
                    ),
                    child: const Text(
                      'বন্ধ করুন',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildAccountInfoCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String details,
    required String copyText,
    required double screenWidth,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEF0F2)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: const Color(0xFF00BFA5),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              // Copy to clipboard
              Clipboard.setData(ClipboardData(text: copyText)).then((_) {
                // Show toast or snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('ক্লিপবোর্ডে কপি করা হয়েছে'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF00BFA5),
                    duration: const Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      bottom: 10,
                    ),
                  ),
                );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    details,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      height: 1.5,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.content_copy_rounded,
                    size: 16,
                    color: Color(0xFF00BFA5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationOption(
    BuildContext context,
    String title,
    IconData icon,
    String type,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonationDetailScreen(donationType: type, title: title),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.04,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF00BFA5),
                    size: screenWidth * 0.06,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.043,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: screenWidth * 0.04,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DonationDetailScreen extends StatelessWidget {
  final String donationType;
  final String title;

  const DonationDetailScreen({
    Key? key,
    required this.donationType,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    // Get icon based on donation type
    IconData typeIcon = Icons.volunteer_activism_outlined;
    switch (donationType) {
      case 'zakat': typeIcon = Icons.favorite_border_rounded; break;
      case 'sadaqah': typeIcon = Icons.volunteer_activism_outlined; break;
      case 'app': typeIcon = Icons.smartphone_rounded; break;
      case 'academy': typeIcon = Icons.school_outlined; break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00BFA5).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      typeIcon,
                      color: const Color(0xFF00BFA5),
                      size: screenWidth * 0.1,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                Center(
                  child: Text(
                    _getDetailTitle(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    _getDetailDescription(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  onPressed: () {
                    // Show donation account info popup
                    _showDonationAccountInfo(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, screenHeight * 0.06),
                  ),
                  child: Text(
                    'এখনই দান করুন',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  // Show account information popup
  void _showDonationAccountInfo(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: 24),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEDF9F7),
                    ),
                    child: const Icon(
                      Icons.credit_card_rounded,
                      color: Color(0xFF00BFA5),
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'দান করার একাউন্টের তথ্য',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildAccountInfoCard(
                    context: context,
                    title: 'বিকাশ / নগদ একাউন্ট',
                    icon: Icons.phone_android_rounded,
                    details: '01601332914 (পার্সোনাল)',
                    copyText: '01601332914',
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 16),
                  _buildAccountInfoCard(
                    context: context,
                    title: 'ব্যাংক একাউন্ট',
                    icon: Icons.account_balance_rounded,
                    details: 'আতাউর রহমান\n20501450204712801\nমৌচাক শাখা, ইসলামী ব্যাংক বাংলাদেশ',
                    copyText: '20501450204712801',
                    screenWidth: screenWidth,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(screenWidth * 0.4, 48),
                      elevation: 0,
                    ),
                    child: const Text(
                      'বন্ধ করুন',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildAccountInfoCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String details,
    required String copyText,
    required double screenWidth,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEF0F2)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: const Color(0xFF00BFA5),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              // Copy to clipboard
              Clipboard.setData(ClipboardData(text: copyText)).then((_) {
                // Show toast or snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('ক্লিপবোর্ডে কপি করা হয়েছে'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF00BFA5),
                    duration: const Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      bottom: 10,
                    ),
                  ),
                );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    details,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      height: 1.5,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BFA5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.content_copy_rounded,
                    size: 16,
                    color: Color(0xFF00BFA5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDetailTitle() {
    switch (donationType) {
      case 'zakat':
        return 'যাকাত ও ফিতরা দান করুন';
      case 'sadaqah':
        return 'নফল সাদাকাহ দান করুন';
      case 'app':
        return 'অ্যাপ উন্নয়নে দান করুন';
      case 'academy':
        return 'আল হুদা একাডেমি\'র উন্নয়নে দান করুন';
      default:
        return 'দান সম্পর্কে বিবরণ';
    }
  }

  String _getDetailDescription() {
    switch (donationType) {
      case 'zakat':
        return 'যাকাত ও ফিতরাহ শরীয়াহ সম্মত প্রকৃত খাতে ব্যয় করা হয়। এই টাকা দ্বারা গরিব ও অসামর্থ্যবান শিক্ষার্থীদের সহায়তা করা হয়। আল কুরআনের শিক্ষাধারাকে এগিয়ে নিতে আপনার যাকাত ও ফিতরাহ থেকে কিছু অংশ দিয়ে আপনিও আমাদের এই মহতি কাজের সহযোগী হতে পারেন ।';
      case 'sadaqah':
        return 'নফল সাদাকাহ বাবদ প্রাপ্ত অনুদান প্রতিষ্ঠানের বিধি মোতাবেক শরীয়াহ সম্মত খাতে ব্যয় করা হয়। এই টাকা দ্বারা গরিব ও অসামর্থ্যবান শিক্ষার্থীদের সহায়তা করা হয় এবং প্রতিষ্ঠানের উন্নয়ন ও অগ্রগতির জন্য কল্যাণমূলক কাজে ব্যয় করা হয়। আল কুরআনের শিক্ষাধারাকে এগিয়ে নিতে আপনার সামর্থ্য অনুযায়ী কিছু নফল সাদাকাহ দান করার মাধ্যমে আপনি আমাদের এই মহতি কাজের সহযোগী হতে পারেন।';
      case 'academy':
        return 'আপনার বিশেষ ইচ্ছা ও মানতের টাকা এই প্রকল্পে দান করতে পারেন। এই প্রকল্প থেকে প্রাপ্ত টাকা কেবল আপনার নির্দেশিত খাতেই ব্যয় করা হবে। এই প্রকল্পকে এগিয়ে নিতে আপনি কিছু সংখ্যক এতিম, গরিব ও অসামর্থ্যবান শিক্ষার্থীর দায়িত্ব নিতে পারেন। আল কুরআনের শিক্ষাধারাকে এগিয়ে নিতে এককালীন অথবা নিয়মিত কিছু বিশেষ অনুদান দিয়ে আপনি আমাদের সহযোগী হতে পারেন।\n\n(আল হুদা একাডেমির স্থায়ী ক্যাম্পাসের জন্য ভূমি প্রয়োজন, ভবন নির্মাণ প্রয়োজন, শিক্ষক ও শিক্ষার্থীর জীবনযাত্রার মান উন্নয়নে কোয়াটার ও ছাত্রাবাস নির্মাণ প্রয়োজন, ক্যাম্পাসের কনস্ট্রাকশন ও অবকাঠামো গড়ে তুলতে বিপুল অর্থের প্রয়োজন।) আল হুদা একাডেমির কার্যক্রমকে এগিয়ে নিতে আপনার সামর্থ্য অনুযায়ী কিছু নফল সাদাকাহ দান করার মাধ্যমে আপনি আমাদের এই দ্বিনি মিশনের সহযোগী হতে পারেন।';
      case 'app':
        return 'আপনার অনুদান আমাদের অ্যাপ উন্নয়ন ও রক্ষণাবেক্ষণের জন্য একটি গুরুত্বপূর্ণ সহায়তা। এই অ্যাপের মাধ্যমে আরো বেশি মানুষের কাছে ইসলামিক জ্ঞান পৌঁছে দিতে আমরা সর্বদা কাজ করে যাচ্ছি। আপনার অবদান এই অ্যাপের নিরন্তর উন্নয়ন ও সম্প্রসারণে ব্যবহৃত হবে, যা আরো বেশি মানুষকে উপকৃত করবে।';
      default:
        return 'আপনার দান আমাদের কার্যক্রম চালিয়ে যেতে সাহায্য করে। ধন্যবাদ আপনার উদারতার জন্য।';
    }
  }
}