import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/recent_news_screen.dart';
import 'package:religion/presentation/screens/news_details_screen.dart';

class RecentNews extends StatelessWidget {
  const RecentNews({Key? key}) : super(key: key);

  final List<Map<String, String>> news = const [
    {
      'title':
          'প্রশান্তিময় ঘুমের জন্য মহানবির (সা.) শিক্ষা ',
      'date': '০৭ ফেব্রুয়ারি ২০২৫',
      'image':
          'https://www.khaborerkagoj.com/uploads/2025/02/06/sleeping-1738825118.jpg',
      'summary':
          'এই যুগে মানসিক ও শারীরিক রোগের পরিমাণ দিন দিন বাড়ছে। এর একটি প্রধান কারণ, সঠিক সময়ে এবং শান্তিপূর্ণ ঘুমের অভাব—যা ধীরে ধীরে শরীরে বিভিন্ন জটিল রোগের জন্ম দেয়। রাসুলুল্লাহ (সা.) প্রচুর কাজ করতেন এবং ঘুমাতেন খুব অল্প সময়। তবুও তিনি পৃথিবীর সবচেয়ে সক্রিয়, কর্মঠ এবং সুস্বাস্থ্যের অধিকারী ছিলেন। পৃথিবীর সব মানুষই শান্তির ঘুম চান। কীভাবে শান্তির ঘুম হতে পারে আমাদের, এখানে সে আলোচনা করা হলো—',
    },
    {
      'title':
          'ইসলামের দৃষ্টিতে একাধিক বিয়ের বিধি-নিষেধ',
      'date': '০৭ ফেব্রুয়ারি ২০২৫',
      'image':
          'https://www.khaborerkagoj.com/uploads/2025/02/06/ma-1738825441.jpg',
      'summary':
          'একাধিক বিয়ের ব্যাপারটি ইসলামপূর্ব যুগেও পৃথিবীর প্রায় সব ধর্মমতেই বৈধ বলে বিবেচিত হতো। আরব, ভারতীয় উপমহাদেশ, ইরান, মিসর, ব্যাবিলন প্রভৃতি সব দেশেই এটির প্রচলন ছিল। একাধিক বিয়ের প্রয়োজনীয়তার কথা বর্তমান যুগেও স্বীকৃত। ',
    },
    {
      'title':
          'সুরা ইউসুফের জীবনঘনিষ্ঠ পাঁচ শিক্ষা ',
      'date': '৩১ জানুয়ারি ২০২৫',
      'image':
          'https://www.khaborerkagoj.com/uploads/2025/01/30/masjid-1738213231.jpg',
      'summary':
          'পবিত্র কোরআনের ১২তম সুরা—সুরা ইউসুফ। মক্কায় অবতীর্ণ এ সুরার আয়াত সংখ্যা ১১১। এ সুরায় ধারাবাহিকভাবে ইউসুফ (আ.)–এর জীবনকথা বর্ণনা করা হয়েছে। আল্লাহ এ কাহিনিকে ‘আহসানুল কাসাস’ বা সর্বোত্তম কাহিনি হিসেবে অভিহিত করেছেন। (সুরা ইউসুফ, আয়াত: ৩)। সুরা ইউসুফের পাঁচটি শিক্ষা এখানে তুলে ধরা হলো—',
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
                'সাম্প্রতিক খবর',
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
                  'আরও দেখুন',
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
