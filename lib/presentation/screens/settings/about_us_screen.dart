import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  Widget _buildCard(BuildContext context, Widget child) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text('আমাদের সম্পর্কে'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'আলহুদা একাডেমি',
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'আমরা আলহুদা একাডেমির একদল সদস্য এই অ্যাপটি তৈরি করেছি। আমাদের লক্ষ্য হল ইসলামিক দৈনন্দিন জীবনের বিভিন্ন বিষয়কে একটি আধুনিক এবং আকর্ষণীয় উপায়ে উপস্থাপন করা।',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              _buildCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'আমাদের উদ্দেশ্য',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'ইসলামের সঠিক শিক্ষা এবং সংস্কৃতি মানুষের মাঝে ছড়িয়ে দেওয়া।',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'দৈনন্দিন জীবনে প্রয়োজনীয় ইসলামিক বিষয়গুলি সহজে উপলব্ধ করা।',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'একটি আধুনিক এবং ব্যবহারকারী-বান্ধব প্ল্যাটফর্মের মাধ্যমে ইসলামিক জ্ঞান বিতরণ করা।',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
