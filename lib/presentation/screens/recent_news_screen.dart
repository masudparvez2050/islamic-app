import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/news_details_screen.dart';

class RecentNewsScreen extends StatelessWidget {
  const RecentNewsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> news = const [
    {
      'title':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
    {
      'title':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।.',
    },
    {
      'title':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
    {
      'title':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
    {
      'title':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent News'),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          final newsItem = news[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        NewsDetailsScreen(newsItem: newsItem),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        newsItem['image']!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsItem['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              newsItem['date']!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              newsItem['summary']!,
                              style: const TextStyle(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
