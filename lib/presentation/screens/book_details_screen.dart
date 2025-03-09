import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dharma/presentation/widgets/add_2.dart';

class BookDetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String author;
  final String link;

  const BookDetailsScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'বইয়ের বিবরণ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    imageUrl,
                    height: screenHeight * 0.4, // 40% of screen height
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.06, // 6% of screen width
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01), // 1% of screen height
                        Text(
                          'লেখক: $author',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045, // 4.5% of screen width
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02), // 2% of screen height
                        SizedBox(height: screenHeight * 0.03), // 3% of screen height
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await canLaunch(link)) {
                                    await launch(link);
                                  } else {
                                    throw 'Could not launch $link';
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.02, // 2% of screen height
                                  ),
                                ),
                                child: Text(
                                  'বই কিনুন',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045, // 4.5% of screen width
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04), // 4% of screen width
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // Handle download book action
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  side: BorderSide(color: Colors.teal),
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.02, // 2% of screen height
                                  ),
                                ),
                                child: Text(
                                  'ডাউনলোড করুন',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045, // 4.5% of screen width
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.065, // Adjust the height as needed
            child: Advertisement2(),
          ), // Add the Advertisement2 widget here
        ],
      ),
    );
  }
}
