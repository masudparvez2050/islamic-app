import 'package:flutter/material.dart';
import 'package:dharma/presentation/screens/motivation_detail_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:ui';

class MotivationScreen extends StatelessWidget {
  const MotivationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context, screenWidth, screenHeight),
          SliverPadding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            sliver: SliverToBoxAdapter(
              child: _buildIntroduction(context, screenWidth, screenHeight),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            sliver: _buildCategoryListSliver(context, screenWidth, screenHeight),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom + screenHeight * 0.02),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, double screenWidth, double screenHeight) {
    return SliverAppBar(
      expandedHeight: screenHeight * 0.25,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: screenWidth * 0.04, bottom: screenHeight * 0.02),
        title: Text(
          'মোটিভেশন',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: screenWidth * 0.055,
            shadows: [
              Shadow(
                blurRadius: screenWidth * 0.025,
                color: Colors.black38,
                offset: Offset(screenWidth * 0.0025, screenHeight * 0.00125),
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  child: Center(
                    child: Icon(Icons.landscape, size: screenWidth * 0.125, color: Colors.white70),
                  ),
                );
              },
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction(BuildContext context, double screenWidth, double screenHeight) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: screenHeight * 0.0625,
        child: FadeInAnimation(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.06),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: screenWidth * 0.05,
                  offset: Offset(0, screenHeight * 0.005),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Theme.of(context).primaryColor,
                        size: screenWidth * 0.06,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'মোটিভেশন',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'মোটিভেশন (Motivation) শব্দের অর্থ- অনুপ্রেরণা। মোটিভেশন হলো মানুষের জীবনের অভ্যন্তরীণ একটি অবস্থা। এ অবস্থা সৃষ্টি হওয়ার মাধ্যমে মানুষ কর্মে মনোযোগ ফিরে পায়।',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => _buildFullIntroductionSheet(context, screenWidth, screenHeight),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'আরও পড়ুন',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Icon(
                        Icons.arrow_forward,
                        size: screenWidth * 0.04,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullIntroductionSheet(BuildContext context, double screenWidth, double screenHeight) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.06)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.015, bottom: screenHeight * 0.02),
                width: screenWidth * 0.1,
                height: screenHeight * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(screenWidth * 0.005),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  children: [
                    Text(
                      'মোটিভেশন',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      'মোটিভেশন (Motivation) শব্দের অর্থ- অনুপ্রেরণা। মোটিভেশন হলো মানুষের জীবনের অভ্যন্তরীণ একটি অবস্থা। এ অবস্থা সৃষ্টি হওয়ার মাধ্যমে মানুষ কর্মে মনোযোগ ফিরে পায়। মোটিভেশনাল কথা বা আলোচনা শুনলে মনের হতাশা কেটে যায়। ফলে মানুষ নতুন উদ্দীপনায় কাজ শুরু করে। Motivational Lecture বা অনুপ্রেরণাদায়ক বক্তব্য মানুষের মাঝে অতুলনীয় শক্তি ও সাহস জোগায়। ফলে জটিল থেকে জটিল কাজ মানুষ সহজভাবে সম্পন্ন করতে পারে। এমনকি দীর্ঘ ও বড় কাজও অল্প সময়ে সফলভাবে শেষ করতে পারে। কোনো কোনো মোটিভেশনাল বাক্য মানুষের জীবনের মোড় ঘুরিয়ে দিতে সক্ষম। নিজেকে পরিবর্তন করতে চাইলে আপনিও মোটিভেশনাল আলোচনা শুনতে পারেন এবং মোটিভেশনাল বাক্য বারবার পড়তে পারেন। আপনার জীবনকে অনন্য উচ্চতায় নিয়ে যেতে মোটিভেশনাল বাক্য আপনার সহায়ক হতে পারে।\n\nমহান আল্লাহ পৃথিবীর সবচেয়ে উত্তম মোটিভেশনাল স্পিকার। এরপর সবচেয়ে অনুপ্রেরণাদায়ক কথা যিনি বলেছেন, তিনি হলেন আমাদের প্রিয়নবী হযরত মুহাম্মাদ সা.। বিশ্ব বিখ্যাত মনীষী ও ইসলামি ব্যক্তিত্বগণ মানুষকে অনুপ্রেরণা দেওয়ার জন্য হাজারও মোটিভেশনাল উক্তি করেছেন। আমরা আশা করি, তাদের সেই মোটিভেশনাল কথা ও বাণী আপনার জীবনে আলো ছড়াবে, ইন শা-আল্লাহ।',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryListSliver(BuildContext context, double screenWidth, double screenHeight) {
    final categories = [
      {
        'title': 'মহান আল্লাহর মোটিভেশন',
        'type': 'allah',
        'content': _getAllahMotivation(),
        'icon': Icons.star,
        'color': Colors.amber,
      },
      {
        'title': 'বিশ্বনবীর মোটিভেশন',
        'type': 'prophet',
        'content': _getProphetMotivation(),
        'icon': Icons.album,
        'color': Colors.green,
      },
      {
        'title': 'সাহাবিদের মোটিভেশন',
        'type': 'sahaba',
        'content': _getSahabaMotivation(),
        'icon': Icons.groups,
        'color': Colors.blue,
      },
      {
        'title': 'মনীষীদের মোটিভেশন',
        'type': 'scholars',
        'content': _getScholarsMotivation(),
        'icon': Icons.school,
        'color': Colors.purple,
      },
      {
        'title': 'সেরা ১০০ মোটিভেশনাল উক্তি',
        'type': 'top100',
        'content': '(শিগ্রহি আপডেট হবে)',
        'icon': Icons.format_list_numbered,
        'color': Colors.orange,
      },
      {
        'title': 'মোটিভেশনাল আলোচনা - ভিডিও',
        'type': 'videos',
        'content': '(শিগ্রহি আপডেট হবে)',
        'icon': Icons.video_library,
        'color': Colors.red,
      },
    ];

    return SliverAnimatedList(
      initialItemCount: categories.length,
      itemBuilder: (context, index, animation) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 450),
          child: SlideAnimation(
            horizontalOffset: screenWidth * 0.125,
            child: FadeInAnimation(
              child: _buildCategoryItem(context, categories[index], animation, screenWidth, screenHeight),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, Map<String, dynamic> category, Animation<double> animation,
      double screenWidth, double screenHeight) {
    final isTablet = screenWidth > 600;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: GestureDetector(
        onTap: () {
          _navigateToDetailScreen(context, category);
        },
        child: Container(
          height: screenHeight * 0.125,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: screenWidth * 0.025,
                offset: Offset(0, screenHeight * 0.0025),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: (category['color'] as Color).withOpacity(0.2),
                highlightColor: (category['color'] as Color).withOpacity(0.1),
                onTap: () {
                  _navigateToDetailScreen(context, category);
                },
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.04,
                      color: category['color'] as Color,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isTablet ? screenWidth * 0.06 : screenWidth * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: (category['color'] as Color).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      category['icon'] as IconData,
                                      color: category['color'] as Color,
                                      size: screenWidth * 0.06,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.04),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category['title'] as String,
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: screenHeight * 0.005),
                                        Text(
                                          'সর্বশেষ হালনাগাদ: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: screenWidth * 0.04,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetailScreen(BuildContext context, Map<String, dynamic> category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MotivationDetailScreen(
          title: category['title'].toString(),
          type: category['type'],
          content: category['content'],
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  // Content generation methods remain unchanged
  String _getAllahMotivation() {
    return '''মহান আল্লাহর মোটিভেশন

১।  
মহান আল্লাহ বলেন-  
وَلَا تَهِنُوا۟ وَلَا تَحۡزَنُوا۟ وَأَنتُمُ ٱلۡأَعۡلَوۡنَ إِن كُنتُم مُّؤۡمِنِینَ।  

অর্থ- তোমরা হীনবল হয়ো না এবং চিন্তিত হয়ো না; পরিশেষে তোমরাই বিজয়ী হবে, যদি তোমরা মুমিন হও।  
(সুরা : আলে ইমরান, আয়াত : ১৩৯)  

২।  
মহান আল্লাহ বলেন-  
إِلَّا تَنصُرُوهُ فَقَدۡ نَصَرَهُ ٱللَّهُ إِذۡ أَخۡرَجَهُ ٱلَّذِینَ كَفَرُوا۟ ثَانِیَ ٱثۡنَیۡنِ إِذۡ هُمَا فِی ٱلۡغَارِ إِذۡ یَقُولُ لِصَـٰحِبِهِۦ لَا تَحۡزَنۡ إِنَّ ٱللَّهَ مَعَنَاۖ فَأَنزَلَ ٱللَّهُ سَكِینَتَهُۥ عَلَیۡهِ وَأَیَّدَهُۥ بِجُنُودࣲ لَّمۡ تَرَوۡهَا وَجَعَلَ كَلِمَةَ ٱلَّذِینَ كَفَرُوا۟ ٱلسُّفۡلَىٰۗ وَكَلِمَةُ ٱللَّهِ هِیَ ٱلۡعُلۡیَاۗ وَٱللَّهُ عَزِیزٌ حَكِیم।  

অর্থ- যদি তোমরা তাঁকে সাহায্য না কর, তবে আল্লাহ তো তাঁকে সাহায্য করেছিলেন যখন কাফেরেরা তাঁকে বহিষ্কার করেছিল এবং তিনি ছিলেন দুজনের দ্বিতীয়জন, যখন তারা উভয়ে গুহায় ছিলেন; তিনি তখন তাঁর সঙ্গীকে বলেছিলেন, ‘বিষণ্ন হয়ো না, আল্লাহ তো আমাদের সাথে আছেন।’ অতঃপর আল্লাহ তাঁর উপর তাঁর প্রশান্তি নাজিল করেন এবং তাঁকে শক্তিশালী করেন এমন এক সৈন্যবাহিনী দ্বারা যা তোমরা দেখনি এবং তিনি কাফেরদের কথা হেয় করেন। আর আল্লাহর কথাই সমুন্নত এবং আল্লাহ পরাক্রমশালী, প্রজ্ঞাময়।  
(সুরা : আত-তাওবা, আয়াত : ৪০)  

৩।  
মহান আল্লাহ বলেন-  
لَا تَمُدَّنَّ عَیۡنَیۡكَ إِلَىٰ مَا مَتَّعۡنَا بِهِۦۤ أَزۡوَٰ⁠جࣰا مِّنۡهُمۡ وَلَا تَحۡزَنۡ عَلَیۡهِمۡ وَٱخۡفِضۡ جَنَاحَكَ لِلۡمُؤۡمِنِینَ।  

অর্থ- আমি তাদের বিভিন্ন শ্রেণীকে ভোগ-বিলাসের যে উপকরণ দিয়েছি তার প্রতি আপনি কখনো আপনার দুচোখ প্রসারিত করবেন না। তাদের জন্য আপনি দুঃখ করবেন না; আপনি মুমিনদের জন্য আপনার বাহু নত করুন।  
(সুরা : আল-হিজর, আয়াত : ৮৮)  

৪।  
মহান আল্লাহ বলেন-  
وَٱصۡبِرۡ وَمَا صَبۡرُكَ إِلَّا بِٱللَّهِۚ وَلَا تَحۡزَنۡ عَلَیۡهِمۡ وَلَا تَكُ فِی ضَیۡقࣲ مِّمَّا یَمۡكُرُونَ  

অর্থ- আর আপনি ধৈর্য ধারণ করুন, আপনার ধৈর্য তো আল্লাহরই সাহায্যে। আর আপনি তাদের জন্য দুঃখ করবেন না এবং তাদের ষড়যন্ত্রে আপনি মনঃক্ষুন্নও হবেন না।  
(সুরা : আন-নাহল, আয়াত : ১২৭)  

৫।  
মহান আল্লাহ বলেন-  
إِنَّ ٱللَّهَ مَعَ ٱلَّذِینَ ٱتَّقَوا۟ وَّٱلَّذِینَ هُم مُّحۡسِنُونَ  

অর্থ- নিশ্চয় আল্লাহ তাদের সঙ্গে আছেন যারা তাকওয়া অবলম্বন করে এবং যারা মুহসিন।  
(সুরা : আন-নাহল, আয়াত : ১২৮)''';
  }

  String _getProphetMotivation() {
    return '''বিশ্ব নবীর মোটিভেশন

১।  
বিশ্বনবী হযরত মুহাম্মাদ সা. বলেন-  
كَلِمَتَانِ خَفِيفَتَانِ عَلَى اللِّسَانِ، ثَقِيلَتَانِ فِي الْمِيزَانِ، حَبِيبَتَانِ إِلَى الرَّحْمَنِ : سُبْحَانَ اللهِ وَبِحَمْدِهِ، سُبْحانَ اللهِ الْعَظِيمِ  

অর্থ- দুটি শব্দ যা জিহ্বায় হালকা, পাল্লায় ভারী এবং পরম করুণাময়ের কাছে অতীব প্রিয়। শব্দ দুটি হলো— ১. সুবহানাল্লাহি ওয়া বিহামদিহী ২. সুবহানাল্লাহিল আযীম।  

২।  
বিশ্বনবী হযরত মুহাম্মাদ সা. বলেন-  
إِيَّاكُمْ وَالظَّنَّ, فَإِنَّ اَلظَّنَّ أَكْذَبُ اَلْحَدِيثِ  

অর্থ- সন্দেহ থেকে সাবধান, কেননা সন্দেহ হলো কথাবার্তার মধ্যে সবচেয়ে বড় মিথ্যা।  

৩।  
বিশ্বনবী হযরত মুহাম্মাদ সা. বলেন-  
مَا يُصِيبُ الْمُسْلِمَ مِنْ نَصَبٍ وَلاَ وَصَبٍ وَلاَ هَمٍّ وَلاَ حُزْنٍ وَلاَ أَذًى وَلاَ غَمٍّ حَتَّى الشَّوْكَةِ يُشَاكُهَا، إِلاَّ كَفَّرَ اللَّهُ بِهَا مِنْ خَطَايَاهُ  

অর্থ- কোনো মুসলমানের যখন কোনো ক্লান্তি, অসুস্থতা, দুশ্চিন্তা, দুঃখ, ব্যথা বা শোক আসে, এমনকি যদি তার শরীরে একটি কাঁটার আঁচড়ও লাগে, তখন মহান আল্লাহ এর বিনিময়ে কাফফারা স্বরূপ তার কোনো না কোনো পাপ ক্ষমা করে দেন।  

৪।  
বিশ্বনবী হযরত মুহাম্মাদ সা. বলেন-  
حَقُّ الْمُسْلِمِ عَلَى الْمُسْلِمِ خَمْسٌ: رَدُّ السَّلَامِ وَعِيَادَةُ الْمَرِيضِ وَاتِّبَاعُ الْجَنَائِزِ وَإِجَابَةُ الدعْوَة و تَشْمِيتُ الْعَاطِس  

অর্থ- একজন মুসলমানের উপর অন্য মুসলমানের হক পাঁচটি। যথা— ১. সালাম দেওয়া, ২. অসুস্থ ব্যক্তিকে দেখতে যাওয়া, ৩. জানাজায় অংশগ্রহণ করা, ৪. দাওয়াত কবুল করা এবং ৫. হাঁচির উত্তর দেওয়া।  

৫।  
(বিশ্বনবী হযরত মুহাম্মাদ সা. বলেন-)  
مَا عَابَ النَّبِيُّ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ طَعَامًا قَطُّ إِنِ اشْتَهَاهُ أَكَلَهُ وَإِنْ كَرِهَهُ تَرَكَهُ  

অর্থ- রাসূল সা. কখনো খাবারের দোষ ধরেননি, যদি তিনি ঐ খাবার পছন্দ করতেন তবে তিনি তা খেতেন, আর যদি তিনি ঐ খাবার পছন্দ না করতেন তবে তিনি তা খেতেন না।''';
  }

  String _getSahabaMotivation() {
    return '''সাহাবিদের মোটিভেশন
১।  
প্রত্যেক সৎকর্মের প্রতিদান সম্পর্কে অনুমান করা যায়, কিন্তু সবরের প্রতিদান এত বেশি যে, এ সম্পর্কে কোনো অনুমান করা যায় না।  
(হযরত আবু বকর রা.)  

২।  
ইসলাম যে সম্মান দান করেছে, তাতে তৃপ্ত না হয়ে যদি অন্য কোথাও থেকে সম্মান অর্জন করতে চেষ্টা কর, তাহলে আল্লাহ অবশ্যই তোমাকে লজ্জিত করে ছাড়বেন।  
(হযরত উমর রা.)  

৩।  
এমন এক সময় আসবে যখন শাসকেরা শুধু রাজস্ব আদায়কারীর ভূমিকা পালনেই ব্যস্ত থাকবে, এমতাবস্থায় লজ্জা, বিশ্বাস ও দায়িত্ববোধ দুষ্প্রাপ্য হয়ে যাবে।  
(হযরত উসমান রা.)  

৪।  
অযাচিত দান করাই হচ্ছে দান। আমরা অনেক সময় চক্ষু লজ্জায় দান করে থাকি, সেটা আসলে দান নয়।  
(হযরত আলী রা.)  

৫।  
যে ব্যক্তি নিজে সতর্ক না হয়, তার জন্য যতই দেহরক্ষী থাকুক তাকে বাঁচাতে পারবে না।  
(হযরত আলী রা.)''';
  }

  String _getScholarsMotivation() {
    return '''মনীষীদের মোটিভেশন

১।  
আমি আল্লাহকে সবচেয়ে বেশি ভয় পাই, তারপর বেশি ভয় পাই সেই মানুষকে যে মোটেই আল্লাহকে ভয় পায় না।  
(শেখ সাদী র.)  

২।  
যে ব্যক্তি সৎকাজে হারাম মাল ব্যয় করে, সে যেন প্রস্রাব দ্বারা কাপড় পবিত্র করার চেষ্টা করে।  
(সুফিয়ান সাওরি র.)  

৩।  
পার্থিব ধন-সম্পদ রোজগার করার জন্য মাত্রাতিরিক্ত শ্রম নিয়োগও আল্লাহর পক্ষ থেকে একটি শাস্তিবিশেষ।  
(ইমাম শাফেয়ী র.)  

৪।  
কোনো মানুষের উপর ভরসা করা গোপন শিরকবিশেষ।  
(মারুফ কারখি র.)  

৫।  
আপনার দুর্বলতাকে শক্তিতে পরিণত করার ক্ষমতা একমাত্র আল্লাহ রাব্বুল আলামিনই রাখেন, সেজন্য আপনি তার কাছেই পানাহ চান প্রার্থনা করুন।  
(ড. বিলাল ফিলিপ্স)''';
  }
}