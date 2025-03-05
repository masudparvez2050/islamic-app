import 'package:flutter/material.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'দান করুন',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.06,  // 5% of screen width
            
          ),
        ),
        backgroundColor: const Color(0xFF00BFA5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
        children: [
          Text(
            'আমাদের কাজে সহায়তা করুন',
            style: TextStyle(
              fontSize: screenWidth * 0.06, // 6% of screen width
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // 2% of screen height
          Text(
            'আপনার দান আমাদের ইসলামিক জ্ঞান প্রচার এবং সম্প্রদায়কে সমর্থন করার মিশন চালিয়ে যেতে সাহায্য করে।',
            style: TextStyle(fontSize: screenWidth * 0.04), // 4% of screen width
          ),
          SizedBox(height: screenHeight * 0.03), // 3% of screen height
          _buildDonationOption(context, 'একবার দান', Icons.attach_money, 'one_time', screenWidth, screenHeight),
          _buildDonationOption(context, 'মাসিক দান', Icons.repeat, 'monthly', screenWidth, screenHeight),
          _buildDonationOption(context, 'যাকাত', Icons.favorite, 'zakat', screenWidth, screenHeight),
          _buildDonationOption(context, 'সাদাকাহ', Icons.volunteer_activism, 'sadaqah', screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.03), // 3% of screen height
          ElevatedButton(
            onPressed: () {
              // Handle general donation process
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 2% of screen height
            ),
            child: Text(
              'এখনই দান করুন',
              style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
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
    return Card(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02), // 2% of screen height
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF00BFA5),
          size: screenWidth * 0.07, // 7% of screen width
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: screenWidth * 0.05, // 5% of screen width
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonationDetailScreen(donationType: type, title: title),
            ),
          );
        },
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.05, // 5% of screen width
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getDetailTitle(),
              style: TextStyle(
                fontSize: screenWidth * 0.06, // 6% of screen width
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            Text(
              _getDetailDescription(),
              style: TextStyle(fontSize: screenWidth * 0.04), // 4% of screen width
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            ElevatedButton(
              onPressed: () {
                // Handle donation process for this type
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BFA5),
                minimumSize: Size.fromHeight(screenHeight * 0.06), // 6% of screen height
              ),
              child: Text(
                'এখনই দান করুন',
                style: TextStyle(fontSize: screenWidth * 0.045), // 4.5% of screen width
              ),
            ),
          ],
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