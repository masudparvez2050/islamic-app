import 'package:flutter/material.dart';

class PoweredByScreen extends StatelessWidget {
  const PoweredByScreen({Key? key}) : super(key: key);

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
        title: const Text('পাওয়ার্ড বাই'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Gradient top section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF00BFA5),
                    const Color(0xFF00BFA5).withOpacity(0),
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/alhuda_logo.png', // Replace with your actual logo
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'আল হুদা একাডেমি',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Content section
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                children: [
                  _buildInfoSection(
                    title: 'উন্নয়ন',
                    content: 'এই অ্যাপটি উন্নয়ন করেছে আল হুদা একাডেমির প্রোগ্রামার টিম। সর্বাধিক আধুনিক প্রযুক্তি ব্যবহার করে এটি তৈরি করা হয়েছে।',
                    icon: Icons.code_rounded,
                    color: Colors.blue,
                    screenWidth: screenWidth,
                  ),
                  
                  SizedBox(height: screenHeight * 0.025),
                  
                  _buildInfoSection(
                    title: 'কন্টেন্ট',
                    content: 'অ্যাপের সকল ইসলামিক কন্টেন্ট প্রস্তুত করেছেন আল হুদা একাডেমির শিক্ষকমণ্ডলী। সমস্ত তথ্য বিশুদ্ধ উৎস থেকে সংগ্রহ করা হয়েছে।',
                    icon: Icons.menu_book_rounded,
                    color: Colors.amber[700]!,
                    screenWidth: screenWidth,
                  ),
                  
                  SizedBox(height: screenHeight * 0.025),
                  
                  _buildInfoSection(
                    title: 'ডিজাইন',
                    content: 'আপনি সহজেই অ্যাপটি ব্যবহার করতে পারেন এমনভাবে UI/UX ডিজাইন করা হয়েছে। মডার্ন এবং মিনিমালিস্টিক ডিজাইন দ্বারা ব্যবহারকারীর অভিজ্ঞতা উন্নত করা হয়েছে।',
                    icon: Icons.design_services_rounded,
                    color: Colors.purple,
                    screenWidth: screenWidth,
                  ),
                ],
              ),
            ),
            
            // Team section
            Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.04,
                horizontal: screenWidth * 0.06,
              ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'এক্সপার্ট টিম',
              //       style: TextStyle(
              //         fontSize: screenWidth * 0.055,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey[800],
              //       ),
              //     ),
              //     SizedBox(height: screenHeight * 0.02),
                  
              //     _buildTeamMember(
              //       name: 'কে এম হাসিবুল ইসলাম',
              //       title: 'প্রধান প্রোগ্রামার',
              //       imageAsset: 'assets/images/team/hasib.jpg',
              //       screenWidth: screenWidth,
              //     ),
                  
              //     SizedBox(height: screenHeight * 0.015),
                  
              //     _buildTeamMember(
              //       name: 'আব্দুল আলীম',
              //       title: 'UI/UX ডিজাইনার',
              //       imageAsset: 'assets/images/team/alim.jpg',
              //       screenWidth: screenWidth,
              //     ),
                  
              //     SizedBox(height: screenHeight * 0.015),
                  
              //     _buildTeamMember(
              //       name: 'মাহমুদুল হাসান',
              //       title: 'কন্টেন্ট রাইটার',
              //       imageAsset: 'assets/images/team/mahmud.jpg',
              //       screenWidth: screenWidth,
              //     ),
              //   ],
              // ),
            ),
            
            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.04,
                horizontal: screenWidth * 0.06,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey[100]!,
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '© ২০২৫ আল হুদা একাডেমি',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'সর্বস্বত্ব সংরক্ষিত',
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
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    required double screenWidth,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.025),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: screenWidth * 0.06),
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Text(
            content,
            style: TextStyle(
              fontSize: screenWidth * 0.038,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String title,
    required String imageAsset,
    required double screenWidth,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.03,
        horizontal: screenWidth * 0.04,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageAsset,
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: screenWidth * 0.12,
                height: screenWidth * 0.12,
                color: const Color(0xFF00BFA5).withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFF00BFA5),
                  size: screenWidth * 0.06,
                ),
              ),
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
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  title,
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
}