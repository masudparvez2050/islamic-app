import 'package:flutter/material.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Map<String, String> newsItem;

  const NewsDetailsScreen({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  title: const Text(
    'বিস্তারিত খবর',
    style: TextStyle(color: Colors.white), // Set text color to white
  ),
  backgroundColor: const Color(0xFF00BFA5), // AppBar background color
),

      body: SingleChildScrollView(
       
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              newsItem['image']!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    newsItem['date']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    newsItem['summary']!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
