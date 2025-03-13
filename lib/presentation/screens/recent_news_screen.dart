import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/news_details_screen.dart';

// Keep the original stateless widget to maintain compatibility
class RecentNewsScreen extends StatelessWidget {
  const RecentNewsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> news = const [
    {
      'title': 'প্রশান্তিময় ঘুমের জন্য মহানবির (সা.) শিক্ষা',
      'date': '০৭ ফেব্রুয়ারি ২০২৫',
      'image': 'https://www.khaborerkagoj.com/uploads/2025/02/06/sleeping-1738825118.jpg',
      'summary':
          'এই যুগে মানসিক ও শারীরিক রোগের পরিমাণ দিন দিন বাড়ছে। এর একটি প্রধান কারণ, সঠিক সময়ে এবং শান্তিপূর্ণ ঘুমের অভাব—যা ধীরে ধীরে শরীরে বিভিন্ন জটিল রোগের জন্ম দেয়। রাসুলুল্লাহ (সা.) প্রচুর কাজ করতেন এবং ঘুমাতেন খুব অল্প সময়। তবুও তিনি পৃথিবীর সবচেয়ে সক্রিয়, কর্মঠ এবং সুস্বাস্থ্যের অধিকারী ছিলেন। পৃথিবীর সব মানুষই শান্তির ঘুম চান। কীভাবে শান্তির ঘুম হতে পারে আমাদের, এখানে সে আলোচনা করা হলো—',
    },
    {
      'title': 'ইসলামের দৃষ্টিতে একাধিক বিয়ের বিধি-নিষেধ',
      'date': '০৭ ফেব্রুয়ারি ২০২৫',
      'image': 'https://www.khaborerkagoj.com/uploads/2025/02/06/ma-1738825441.jpg',
      'summary':
          'একাধিক বিয়ের ব্যাপারটি ইসলামপূর্ব যুগেও পৃথিবীর প্রায় সব ধর্মমতেই বৈধ বলে বিবেচিত হতো। আরব, ভারতীয় উপমহাদেশ, ইরান, মিসর, ব্যাবিলন প্রভৃতি সব দেশেই এটির প্রচলন ছিল। একাধিক বিয়ের প্রয়োজনীয়তার কথা বর্তমান যুগেও স্বীকৃত।',
    },
    {
      'title': 'সুরা ইউসুফের জীবনঘনিষ্ঠ পাঁচ শিক্ষা',
      'date': '৩১ জানুয়ারি ২০২৫',
      'image': 'https://www.khaborerkagoj.com/uploads/2025/01/30/masjid-1738213231.jpg',
      'summary':
          'পবিত্র কোরআনের ১২তম সুরা—সুরা ইউসুফ। মক্কায় অবতীর্ণ এ সুরার আয়াত সংখ্যা ১১১। এ সুরায় ধারাবাহিকভাবে ইউসুফ (আ.)–এর জীবনকথা বর্ণনা করা হয়েছে। আল্লাহ এ কাহিনিকে ‘আহসানুল কাসাস’ বা সর্বোত্তম কাহিনি হিসেবে অভিহিত করেছেন। (সুরা ইউসুফ, আয়াত: ৩)। সুরা ইউসুফের পাঁচটি শিক্ষা এখানে তুলে ধরা হলো—',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: const Color(0xFF00BFA5), size: screenWidth * 0.06),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'ইসলামি খবর',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: const Offset(0, 1),
                blurRadius: screenWidth * 0.0075,
                color: const Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF00BFA5), Colors.transparent],
            ),
          ),
        ),
      ),
      body: _AnimatedNewsListView(news: news, screenWidth: screenWidth, screenHeight: screenHeight),
    );
  }
}

// Create a separate stateful widget for the animation
class _AnimatedNewsListView extends StatefulWidget {
  final List<Map<String, String>> news;
  final double screenWidth;
  final double screenHeight;

  const _AnimatedNewsListView({
    Key? key,
    required this.news,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<_AnimatedNewsListView> createState() => _AnimatedNewsListViewState();
}

class _AnimatedNewsListViewState extends State<_AnimatedNewsListView> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: widget.screenHeight * 0.12, bottom: widget.screenHeight * 0.025),
          itemCount: widget.news.length,
          itemBuilder: (context, index) {
            final newsItem = widget.news[index];

            // Create staggered animation for each item
            final itemAnimation = CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                index * 0.1,
                1.0,
                curve: Curves.easeOut,
              ),
            );

            return FadeTransition(
              opacity: itemAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.3, 0),
                  end: Offset.zero,
                ).animate(itemAnimation),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: widget.screenHeight * 0.0125,
                    horizontal: widget.screenWidth * 0.05,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              NewsDetailsScreen(newsItem: newsItem),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(widget.screenWidth * 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: widget.screenWidth * 0.05,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(widget.screenWidth * 0.05),
                            ),
                            child: Hero(
                              tag: 'news_image_${newsItem['title']}',
                              child: Image.network(
                                newsItem['image']!,
                                height: widget.screenHeight * 0.225,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(widget.screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: widget.screenWidth * 0.025,
                                        vertical: widget.screenHeight * 0.006,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF00BFA5).withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(widget.screenWidth * 0.075),
                                      ),
                                      child: Text(
                                        newsItem['date']!,
                                        style: TextStyle(
                                          color: const Color(0xFF00BFA5),
                                          fontSize: widget.screenWidth * 0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: widget.screenHeight * 0.0125),
                                Text(
                                  newsItem['title']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.screenWidth * 0.045,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: widget.screenHeight * 0.0125),
                                Text(
                                  newsItem['summary']!,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: widget.screenWidth * 0.035,
                                    height: 1.5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: widget.screenHeight * 0.02),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: widget.screenWidth * 0.04,
                                      vertical: widget.screenHeight * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00BFA5),
                                      borderRadius:
                                          BorderRadius.circular(widget.screenWidth * 0.075),
                                    ),
                                    child: Text(
                                      'আরও পড়ুন',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: widget.screenWidth * 0.03,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}