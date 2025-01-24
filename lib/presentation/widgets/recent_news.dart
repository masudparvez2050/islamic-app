import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/recent_news_screen.dart';
import 'package:religion/presentation/screens/news_details_screen.dart';

class RecentNews extends StatelessWidget {
  const RecentNews({Key? key}) : super(key: key);

  final List<Map<String, String>> news = const [
    {
      'title':
          'কিছু দুষ্টু লোক আমাদের সম্প্রীতিতে ফাটল ধরাতে চায়: মিজানুর রহমান আজহারী',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
    {
      'title':
          'কিছু দুষ্টু লোক আমাদের সম্প্রীতিতে ফাটল ধরাতে চায়: মিজানুর রহমান আজহারী',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
    {
      'title':
          'কিছু দুষ্টু লোক আমাদের সম্প্রীতিতে ফাটল ধরাতে চায়: মিজানুর রহমান আজহারী',
      'date': '2025-01-18',
      'image':
          'https://www.rtvonline.com/assets/news_photos/2025/01/18/image-309354-1737201295.jpg',
      'summary':
          'কিছু দুষ্টু লোক বাংলাদেশের ধর্মীয় সম্প্রীতিতে ফাটল ধরাতে চায় বলে মন্তব্য করেছেন জনপ্রিয় ইসলামী বক্তা ড. মিজানুর রহমান আজহারী।',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent News',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA5),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const RecentNewsScreen(),
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
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsItem = news[index];
              return GestureDetector(
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
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          newsItem['image']!,
                          height: 160,
                          width: 280,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
