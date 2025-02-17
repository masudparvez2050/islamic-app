import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoweredBy extends StatelessWidget {
  const PoweredBy({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(width * 0.04, height * 0.025, width * 0.04, height * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.02),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Powered by text
          Text(
            'পাওয়ার বাই Al Huda Academy',
            style: TextStyle(
              color: Colors.teal,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w800,
            ),
          ),
          // Separator line
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.1),
            child: Container(
              height: height * 0.001,
              color: Colors.teal.withOpacity(0.5),
            ),
          ),
          // Feedback text
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Text(
              'আমাদের App সম্পর্কে মূল্যবান অভিমত ও পরামর্শ জানাতে\nফেসবুক গ্রুপে পোস্ট করুন অথবা ই-মেইল করুন',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.teal,
                fontSize: width * 0.04,
                height: 1.5,
              ),
            ),
          ),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _launchURL('https://www.facebook.com/people/Al-Huda-Academy/100091305081988/?mibextid=ZbWKwL'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.125),
                  ),
                ),
                child: Text(
                  'পোস্ট করুন',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: width * 0.03),
              ElevatedButton(
                onPressed: _launchEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.125),
                  ),
                ),
                child: Text(
                  'ই-মেইল করুন',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
