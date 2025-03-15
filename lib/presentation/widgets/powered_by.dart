import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoweredBy extends StatefulWidget {
  const PoweredBy({Key? key}) : super(key: key);

  @override
  State<PoweredBy> createState() => _PoweredByState();
}

class _PoweredByState extends State<PoweredBy> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isHoveringPost = false;
  bool _isHoveringEmail = false;

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
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _controller.forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isSmallScreen = width < 360;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            width * 0.05, 
            height * 0.03, 
            width * 0.05, 
            height * 0.03
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withOpacity(0.25), // Increased opacity for better visibility
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.20), // Slightly increased shadow opacity
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.teal.shade50.withOpacity(0.3), // Lighter teal color with some opacity
                Colors.white.withOpacity(0.15),      // Slightly increased opacity
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Feedback text
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutQuint,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.015),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.teal.shade300,
                              Colors.teal.shade700,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'আমাদের App সম্পর্কে আপনার মূল্যবান অভিমত ও পরামর্শ জানাতে\nফেসবুক গ্রুপে পোস্ট করুন অথবা ই-মেইল করুন',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSmallScreen ? width * 0.034 : width * 0.036,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              SizedBox(height: height * 0.02),
              
              // Buttons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: width * 0.02, // Reduced spacing between buttons
                runSpacing: height * 0.015,
                children: [
                  // Facebook button
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHoveringPost = true),
                    onExit: (_) => setState(() => _isHoveringPost = false),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: Opacity(
                            opacity: value,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: _isHoveringPost
                                      ? [Colors.teal.shade600, Colors.teal.shade800]
                                      : [Colors.teal.shade500, Colors.teal.shade700],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: _isHoveringPost
                                    ? [
                                        BoxShadow(
                                          color: Colors.teal.withOpacity(0.3),
                                          blurRadius: 12,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 3),
                                        )
                                      ]
                                    : [],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _launchURL('https://www.facebook.com/groups/1469984167721446/?ref=share&mibextid=NSMWBT'),
                                  borderRadius: BorderRadius.circular(16),
                                  splashColor: Colors.white.withOpacity(0.1),
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03, // Reduced horizontal padding
                                      vertical: height * 0.015, // Slightly reduced vertical padding
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                          transform: Matrix4.translationValues(
                                            _isHoveringPost ? -2.0 : 0.0, // Reduced animation distance
                                            0.0, 
                                            0.0
                                          ),
                                          child: Icon(
                                            Icons.facebook,
                                            color: Colors.white,
                                            size: isSmallScreen ? width * 0.045 : width * 0.05, // Slightly smaller icon
                                          ),
                                        ),
                                        SizedBox(width: width * 0.01), // Reduced spacing
                                        Text(
                                          'পোস্ট করুন',
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? width * 0.032 : width * 0.035, // Smaller font size
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            letterSpacing: 0.3, // Reduced letter spacing
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          opacity: _isHoveringPost ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 300),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            transform: Matrix4.translationValues(
                                              _isHoveringPost ? 0.0 : -4.0, // Reduced animation distance
                                              0.0, 
                                              0.0
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width * 0.01), // Reduced padding
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: isSmallScreen ? width * 0.04 : width * 0.045, // Smaller icon
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Email button
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHoveringEmail = true),
                    onExit: (_) => setState(() => _isHoveringEmail = false),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: Opacity(
                            opacity: value,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: _isHoveringEmail
                                      ? [Colors.teal.shade600, Colors.teal.shade800]
                                      : [Colors.teal.shade500, Colors.teal.shade700],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: _isHoveringEmail
                                    ? [
                                        BoxShadow(
                                          color: Colors.teal.withOpacity(0.3),
                                          blurRadius: 12,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 3),
                                        )
                                      ]
                                    : [],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _launchEmail,
                                  borderRadius: BorderRadius.circular(16),
                                  splashColor: Colors.white.withOpacity(0.1),
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03, // Reduced horizontal padding
                                      vertical: height * 0.015, // Slightly reduced vertical padding
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                          transform: Matrix4.translationValues(
                                            _isHoveringEmail ? -2.0 : 0.0, // Reduced animation distance
                                            0.0, 
                                            0.0
                                          ),
                                          child: Icon(
                                            Icons.email_outlined,
                                            color: Colors.white,
                                            size: isSmallScreen ? width * 0.045 : width * 0.05, // Slightly smaller icon
                                          ),
                                        ),
                                        SizedBox(width: width * 0.01), // Reduced spacing
                                        Text(
                                          'ই-মেইল করুন',
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? width * 0.032 : width * 0.035, // Smaller font size
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            letterSpacing: 0.3, // Reduced letter spacing
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          opacity: _isHoveringEmail ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 300),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            transform: Matrix4.translationValues(
                                              _isHoveringEmail ? 0.0 : -4.0, // Reduced animation distance
                                              0.0, 
                                              0.0
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: width * 0.01), // Reduced padding
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: isSmallScreen ? width * 0.04 : width * 0.045, // Smaller icon
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
