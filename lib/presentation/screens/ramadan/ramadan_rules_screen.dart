import 'package:flutter/material.dart';
import '../../../presentation/widgets/responsive_header.dart';
import '../../../presentation/widgets/responsive_container.dart';

class RamadanRulesScreen extends StatelessWidget {
  const RamadanRulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double titleFontSize = size.width * 0.055; // Slightly smaller
    final double contentFontSize = size.width * 0.04; // Slightly smaller
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Lighter background for modern look
      appBar: ResponsiveHeader(
        title: 'রমজান মাসের বিধি-নিষেধ',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02
          ), // More refined padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF26A69A), Color(0xFF00BFA5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'রমজান মাসের বিধি-নিষেধ',
                  style: TextStyle(
                    fontSize: titleFontSize > 26 ? 26 : titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.025),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildRuleItem(
                      '১. সকল মুসলিম নর-নারীর জন্য রোজা রাখা ফরজ।', 
                      contentFontSize,
                      size,
                      1
                    ),
                    _buildRuleItem(
                      '২. রোজাকালীন সময়ে মিথ্যা বলা, গীবত করা ও খারাপ কাজ থেকে নিজেকে বাঁচিয়ে রাখা আবশ্যক।', 
                      contentFontSize,
                      size,
                      2
                    ),
                    _buildRuleItem(
                      '৩. রোজার সময় খাদ্য ও পানীয় গ্রহণ থেকে বিরত থাকতে হবে।', 
                      contentFontSize,
                      size,
                      3
                    ),
                    _buildRuleItem(
                      '৪. তারাবীহ নামাজ পড়া সুন্নত।', 
                      contentFontSize,
                      size,
                      4
                    ),
                    _buildRuleItem(
                      '৫. ইফতারের আগে দোয়া করা উত্তম।', 
                      contentFontSize,
                      size,
                      5
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem(String text, double fontSize, Size size, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.025),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${index.toString()}',
              style: TextStyle(
                fontSize: fontSize - 2,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00897B),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize > 20 ? 20 : (fontSize < 15 ? 15 : fontSize),
                  height: 1.6,
                  color: const Color(0xFF455A64),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
