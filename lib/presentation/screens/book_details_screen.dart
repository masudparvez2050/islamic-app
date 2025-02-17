import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:religion/presentation/widgets/add_2.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _loadImage(), // Simulate image loading
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: screenHeight * 0.4, // 40% of screen height
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Container(
                    height: screenHeight * 0.4, // 40% of screen height
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      ),
                    ),
                  );
                } else {
                  return Image.network(
                    'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg',
                    height: screenHeight * 0.4, // 40% of screen height
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'বইয়ের শিরোনাম',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // 6% of screen width
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // 1% of screen height
                  Text(
                    'লেখকের নাম',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% of screen width
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // 2% of screen height
                  Text(
                    'বর্ণনা',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // 5% of screen width
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // 1% of screen height
                  Text(
                    'লোরেম ইপসাম ডলর সিট আমেট, কনসেকটেটুর অ্যাডিপিসিং এলিট. সেড ডো ইইউসমড টেম্পর ইনসিডিডুন্ট উট ল্যাবোর এট ডোলোরে ম্যাগনা এলিকুয়া. উট এনিম অ্যাড মিনিম ভেনিয়াম, কুইস নস্ট্রাড এক্সারসিটেশন উল্লামকো ল্যাবোরিস নিসি উট এলিকুইপ এক্স ইয়া কম্মোডো কনসেকুয়াট.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // 4% of screen width
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // 3% of screen height
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle buy book action
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


            SizedBox(
            height: screenHeight * 0.065, // Adjust the height as needed
            child: Advertisement2(),
          ), // Add the Advertisement2 widget here
          ],
        ),
      ),
    );
  }

  Future<bool> _loadImage() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    return true; // Return true if image is loaded successfully, false otherwise
  }
}