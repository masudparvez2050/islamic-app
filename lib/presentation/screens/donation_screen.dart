import 'package:flutter/material.dart';

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
                    'আপনার দান আমাদের ইসলামিক জ্ঞান প্রচার এবং সম্প্রদায়কে সমর্থন করার মিশন চালিয়ে যেতে সাহায্য করে।',
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
              'দান করার উপায়',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildDonationOption(context, 'একবার দান', Icons.account_balance_wallet_outlined, 'one_time', screenWidth, screenHeight),
            _buildDonationOption(context, 'মাসিক দান', Icons.autorenew_rounded, 'monthly', screenWidth, screenHeight),
            _buildDonationOption(context, 'যাকাত', Icons.favorite_border_rounded, 'zakat', screenWidth, screenHeight),
            _buildDonationOption(context, 'সাদাকাহ', Icons.volunteer_activism_outlined, 'sadaqah', screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: () {
                // Handle general donation process
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
      case 'one_time': typeIcon = Icons.account_balance_wallet_outlined; break;
      case 'monthly': typeIcon = Icons.autorenew_rounded; break;
      case 'zakat': typeIcon = Icons.favorite_border_rounded; break;
      case 'sadaqah': typeIcon = Icons.volunteer_activism_outlined; break;
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
                    // Handle donation process for this type
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

  String _getDetailTitle() {
    switch (donationType) {
      case 'one_time':
        return 'একবার দানের বিবরণ';
      case 'monthly':
        return 'মাসিক দানের বিবরণ';
      case 'zakat':
        return 'যাকাত সম্পর্কে';
      case 'sadaqah':
        return 'সাদাকাহ সম্পর্কে';
      default:
        return 'দান সম্পর্কে বিবরণ';
    }
  }

  String _getDetailDescription() {
    switch (donationType) {
      case 'one_time':
        return 'এই একবার দান দিয়ে আপনি আমাদের মিশনে গুরুত্বপূর্ণ অবদান রাখতে পারবেন। আপনার দান সরাসরি আমাদের প্রকল্পে যাবে।';
      case 'monthly':
        return 'মাসিক দান আমাদের দীর্ঘকালীন পরিকল্পনায় সাহায্য করে। নিয়মিত দান আমাদের নিরন্তর কার্যক্রম চালিয়ে যেতে সহায়তা করে।';
      case 'zakat':
        return 'যাকাত হল ইসলামের পাঁচটি স্তম্ভের একটি। এটি আপনার সম্পদের একটি নির্দিষ্ট অংশ প্রতিবছর দান করা, যা পবিত্র করে এবং সমাজের দরিদ্রদের সাহায্য করে।';
      case 'sadaqah':
        return 'সাদাকাহ হল ঐচ্ছিক দান যা মুসলমানদের করতে উৎসাহিত করা হয়। এটি আল্লাহর সন্তুষ্টির জন্য প্রদান করা হয় এবং বিভিন্ন রূপে হতে পারে।';
      default:
        return 'আপনার দান আমাদের কার্যক্রম চালিয়ে যেতে সাহায্য করে। ধন্যবাদ আপনার উদারতার জন্য।';
    }
  }
}