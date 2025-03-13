import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class MotivationDetailScreen extends StatelessWidget {
  final String title;
  final String type;
  final String content;

  const MotivationDetailScreen({
    Key? key,
    required this.title,
    required this.type,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isLargeScreen = screenWidth > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: screenWidth * 0.02,
                  offset: Offset(0, screenHeight * 0.0025),
                ),
              ],
            ),
            child: Icon(Icons.arrow_back_ios_rounded, size: screenWidth * 0.045),
          ),
          onPressed: () => Navigator.pop(context),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 500.ms)
            .slideX(begin: -0.2, end: 0),
        title: Text(
          title,
          style: GoogleFonts.tiroBangla(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.045,
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 500.ms),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + screenHeight * 0.0875,
                left: isLargeScreen ? constraints.maxWidth * 0.1 : screenWidth * 0.04,
                right: isLargeScreen ? constraints.maxWidth * 0.1 : screenWidth * 0.04,
                bottom: screenHeight * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderCard(context, isLargeScreen, screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),
                  _buildContentCard(context, isLargeScreen, screenWidth, screenHeight),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, bool isLargeScreen, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            spreadRadius: screenWidth * 0.0025,
            blurRadius: screenWidth * 0.05,
            offset: Offset(0, screenHeight * 0.0125),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.tiroBangla(
              fontSize: isLargeScreen ? screenWidth * 0.07 : screenWidth * 0.055,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            width: screenWidth * 0.1,
            height: screenHeight * 0.005,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.1, end: 0);
  }

  Widget _buildContentCard(BuildContext context, bool isLargeScreen, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: screenWidth * 0.005,
            blurRadius: screenWidth * 0.0375,
            offset: Offset(0, screenHeight * 0.00625),
          ),
        ],
      ),
      child: _buildContent(screenWidth, screenHeight),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildContent(double screenWidth, double screenHeight) {
    if (type == 'videos') {
      return _buildVideoContent(screenWidth, screenHeight);
    } else {
      return Text(
        content,
        style: GoogleFonts.tiroBangla(
          fontSize: screenWidth * 0.0425,
          height: 1.8,
          letterSpacing: screenWidth * 0.00075,
          wordSpacing: screenWidth * 0.003,
          color: const Color(0xFF353945),
        ),
        textAlign: TextAlign.justify,
      ).animate(delay: 400.ms).fadeIn(duration: 800.ms);
    }
  }

  Widget _buildVideoContent(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'মোটিভেশনাল ভিডিও সমূহ',
          style: GoogleFonts.tiroBangla(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF23262F),
          ),
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.1, end: 0),
        SizedBox(height: screenHeight * 0.03),
        Text(
          content,
          style: GoogleFonts.tiroBangla(
            fontSize: screenWidth * 0.04,
            height: 1.6,
            color: const Color(0xFF353945),
          ),
        ).animate(delay: 600.ms).fadeIn(duration: 600.ms),
        SizedBox(height: screenHeight * 0.04),
        _buildVideoList(screenWidth, screenHeight)
            .animate(delay: 800.ms)
            .fadeIn(duration: 800.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildVideoList(double screenWidth, double screenHeight) {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: screenWidth * 0.025,
                spreadRadius: 0,
                offset: Offset(0, screenHeight * 0.005),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.225,
                          width: double.infinity,
                          color: Colors.teal.withOpacity(0.1 + (index * 0.1)),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.teal.withOpacity(0.5),
                              size: screenWidth * 0.1,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: screenWidth * 0.025,
                                spreadRadius: 0,
                                offset: Offset(0, screenHeight * 0.0025),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.teal,
                            size: screenWidth * 0.08,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'মোটিভেশনাল ভিডিও ${index + 1}',
                            style: GoogleFonts.tiroBangla(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF23262F),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.0075),
                          Text(
                            'এই ভিডিওতে জীবনের সাফল্য সম্পর্কে আলোচনা করা হয়েছে',
                            style: GoogleFonts.tiroBangla(
                              fontSize: screenWidth * 0.035,
                              color: const Color(0xFF777E90),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).animate(delay: (800 + (index * 200)).ms).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
      ),
    );
  }
}