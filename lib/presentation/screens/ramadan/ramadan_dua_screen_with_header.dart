import 'package:flutter/material.dart';
import 'package:dharma/utils/responsive_utils.dart';
import 'package:dharma/widgets/header.dart';
import 'package:dharma/widgets/responsive_builder.dart';

class RamadanDuaScreenWithHeader extends StatelessWidget {
  const RamadanDuaScreenWithHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, _) {
        return ResponsiveScaffold(
          title: 'রমজানের দোয়া',
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: ResponsiveUtils.padding(
              horizontal: 4,
              bottom: 4,
            ),
            child: ListView(
              padding: ResponsiveUtils.padding(top: 2),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildHeader(context),
                SizedBox(height: ResponsiveUtils.hp(2.5)),
                _buildDuaCategoryList(context),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'রমজান মাসের প্রয়োজনীয় দোয়া',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'নিচে দোয়াগুলো দেখতে ট্যাপ করুন',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDuaCategoryList(BuildContext context) {
    final duaCategories = [
      {'title': 'রোজার নিয়ত করার দোয়া', 'content': _rojarNiotDuaContent, 'icon': Icons.nights_stay},
      {'title': 'ইফতারের দোয়া', 'content': _ifterDuaContent, 'icon': Icons.dinner_dining},
      {'title': 'প্রথম রোজার দোয়া', 'content': _firstRojarDuaContent, 'icon': Icons.first_page},
      {'title': 'শেষ রোজার দোয়া', 'content': _sesRojarDuaContent, 'icon': Icons.last_page},
      {'title': 'সেহরীর দোয়া', 'content': _sehriDuaContent, 'icon': Icons.nightlight_round},
      {'title': 'তারাবীহ এর দোয়া', 'content': _tarabihDuaContent, 'icon': Icons.auto_stories},
      {'title': 'লাইলাতুল কদরের দোয়া', 'content': _laylatulQadrDuaContent, 'icon': Icons.star_rounded},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: duaCategories.length,
      itemBuilder: (context, index) {
        final category = duaCategories[index];
        return _buildCategoryCard(
          context, 
          category['title'] as String,
          category['icon'] as IconData, 
          () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => DuaDetailsScreenWithHeader(
                  title: category['title'] as String,
                  content: category['content'] as String,
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;
                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Hero(
      tag: 'dua_$title',
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.8),
                          Theme.of(context).primaryColor.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DuaDetailsScreenWithHeader extends StatelessWidget {
  final String title;
  final String content;

  const DuaDetailsScreenWithHeader({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, _) {
        return ResponsiveScaffold(
          title: title,
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: ResponsiveUtils.padding(
              horizontal: 4,
              bottom: 4,
              top: 2,
            ),
            child: Hero(
              tag: 'dua_$title',
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: ResponsiveUtils.borderRadius(4),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: ResponsiveUtils.padding(all: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildFormattedContent(context, content),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  List<Widget> _buildFormattedContent(BuildContext context, String content) {
    final List<Widget> widgets = [];
    final lines = content.split('\n');
    
    String? currentHeading;
    List<String> currentSection = [];
    
    for (final line in lines) {
      if (line.startsWith('**') && line.endsWith('**')) {
        // If we have content from a previous section, add it
        if (currentHeading != null && currentSection.isNotEmpty) {
          widgets.add(_buildContentSection(context, currentHeading, currentSection.join('\n')));
          currentSection = [];
        }
        // Set new heading
        currentHeading = line.replaceAll('**', '');
      } else if (line.trim().isNotEmpty) {
        currentSection.add(line);
      }
    }
    
    // Add the last section
    if (currentHeading != null && currentSection.isNotEmpty) {
      widgets.add(_buildContentSection(context, currentHeading, currentSection.join('\n')));
    }
    
    return widgets;
  }
  
  Widget _buildContentSection(BuildContext context, String heading, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

const String _laylatulQadrDuaContent = '''
**লাইলাতুল কদরের দোয়া**

**আরবি:**
اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي

**উচ্চারণ:**
আল্লাহুম্মা ইন্নাকা আফুউন তুহিব্বুল আফওয়া ফা'ফু আন্নি।

**অর্থ:**
হে আল্লাহ, নিশ্চয়ই আপনি ক্ষমাশীল, আপনি ক্ষমা করতে ভালোবাসেন। অতএব, আমাকে ক্ষমা করুন।
''';
const String _rojarNiotDuaContent = '''
**রোজার নিয়ত করার দোয়া**

**আরবি:**
نَوَيْتُ اَنْ اَصُوْمَ غَدًا لِلّٰهِ تَعَالٰى مِنْ فَرْضِ رَمَضَانَ هٰذِهِ السَّنَةِ ۖ اَللّٰهُمَّ تَقَبَّلْ مِنِّىْ اِنَّكَ اَنْتَ السَّمِيْعُ الْعَلِيْمُ

**উচ্চারণ:**
নাওয়াইতু আন আছুমা গাদান লিল্লাহি তায়ালা মিন ফারদ্বি রামাদ্বানা হাজিহিস সানাহ। আল্লাহুম্মা তাকাব্বাল মিন্নি ইন্নাকা আংতাস সামিউল আলিম।

**অর্থ:**
আমি আগামীকাল আল্লাহর জন্য এই রমজানের ফরজ রোজা রাখার নিয়ত করছি। হে আল্লাহ, আমার পক্ষ থেকে কবুল করুন। নিশ্চয়ই আপনি সর্বশ্রোতা, সর্বজ্ঞানী।
''';
const String _ifterDuaContent = '''
**ইফতারের দোয়া**

**আরবি:**
اَللّٰهُمَّ اِنِّىْ لَكَ صُمْتُ وَبِكَ اٰمَنْتُ وَعَلَيْكَ تَوَكَّلْتُ وَعَلٰى رِزْقِكَ اَفْطَرْتُ

**উচ্চারণ:**
আল্লাহুম্মা ইন্নি লাকা ছুমতু ওয়া বিকা আমান্তু ওয়া আলাইকা তাওয়াক্কালতু ওয়া আলা রিজক্বিকা আফতারতু।

**অর্থ:**
হে আল্লাহ, আমি তোমার জন্য রোজা রেখেছি, তোমার প্রতি ঈমান এনেছি, তোমার উপর ভরসা করেছি এবং তোমার দেওয়া রিজিক দ্বারা ইফতার করছি।
''';
const String _firstRojarDuaContent = '''
**প্রথম রোজার দোয়া**

**আরবি:**
سُبْحَانَ ذِي الْمُلْكِ وَالْمَلَكُوتِ سُبْحَانَ ذِي الْعِزَّةِ وَالْعَظَمَةِ وَالْهَيْبَةِ وَالْقُدْرَةِ وَالْكِبْرِيَاءِ وَالْجَبَرُوتِ سُبْحَانَ الْمَلِكِ الْحَيِّ الَّذِي لَا يَمُوتُ سُبُّوحٌ قُدُّوسٌ رَبُّنَا وَرَبُّ الْمَلَائِكَةِ وَالرُّوحِ

**উচ্চারণ:**
সুবহানা যিল মুলকি ওয়াল মালাকুতি সুবহানা যিল ইজ্জাতি ওয়াল আজমাতি ওয়াল হাইবাতি ওয়াল কুদরাতি ওয়াল কিবরিয়াই ওয়াল জাবারুতি সুবহানাল মালিকিল হাইয়িল্লাযি লা ইয়ামুতু। সুব্বুহুন কুদ্দুসুন রাব্বুনা ওয়া রাব্বুল মালাইকাতি ওয়ার রুহ।

**অর্থ:**
মহাপবিত্র তিনি, যিনি সাম্রাজ্য ও আধিপত্যের মালিক। মহাপবিত্র তিনি, যিনি সম্মান, মহত্ত্ব, ভয়, ক্ষমতা, শ্রেষ্ঠত্ব ও প্রতাপের মালিক। মহাপবিত্র তিনি, যিনি চিরঞ্জীব, কখনো মৃত্যু বরণ করেন না। তিনি পরম পবিত্র ও মহিমান্বিত, তিনি আমাদের রব এবং ফেরেশতা ও রুহের রব।
''';
const String _sesRojarDuaContent = '''
**শেষ রোজার দোয়া**

**আরবি:**
اللهم لا تجعل هذا آخر العهد من صيامنا، فإن جعلته فاجعلني مرحومًا ولا تجعلني محرومًا

**উচ্চারণ:**
আল্লাহুম্মা লা তাজআল হাজা আখিরুল আহদি মিন সিয়ামিনা, ফাইং জাআলতাহুফাজআলনি মারহুমাও ওয়ালা তাজআলনি মাহরুমা।

**অর্থ:**
হে আল্লাহ! আমাদের রোজার এই শেষ দিনটিকে আমাদের জীবনের শেষ রোজা হিসেবে নির্ধারণ করো না। যদি তুমি তা নির্ধারণ করেই থাকো, তবে আমাকে তোমার রহমতের অন্তর্ভুক্ত করো এবং বঞ্চিত করো না।
''';
const String _sehriDuaContent = '''
**সেহরীর দোয়া**

**আরবি:**
نَوَيْتُ اَنْ اَصُوْمَ غَدًا لِلّٰهِ تَعَالٰى مِنْ فَرْضِ رَمَضَانَ

**উচ্চারণ:**
নাওয়াইতু আন আছুমা গাদান লিল্লাহি তায়ালা মিন ফারদ্বি রামাদ্বান।

**অর্থ:**
আমি আগামীকাল আল্লাহর জন্য রমজান মাসের ফরজ রোজা রাখার নিয়ত করছি।
''';
const String _tarabihDuaContent = '''
**তারাবীহ এর দোয়া**

**আরবি:**
سُبْحَانَ ذِي الْمُلْكِ وَالْمَلَكُوتِ سُبْحَانَ ذِي الْعِزَّةِ وَالْعَظَمَةِ وَالْهَيْبَةِ وَالْقُدْرَةِ وَالْكِبْرِيَاءِ وَالْجَبَرُوتِ سُبْحَانَ الْمَلِكِ الْحَيِّ الَّذِي لَا يَمُوتُ سُبُّوحٌ قُدُّوسٌ رَبُّنَا وَرَبُّ الْمَلَائِكَةِ وَالرُّوحِ

**উচ্চারণ:**
সুবহানা যিল মুলকি ওয়াল মালাকুতি সুবহানা যিল ইজ্জাতি ওয়াল আজমাতি ওয়াল হাইবাতি ওয়াল কুদরাতি ওয়াল কিবরিয়াই ওয়াল জাবারুতি সুবহানাল মালিকিল হাইয়িল্লাযি লা ইয়ামুতু। সুব্বুহুন কুদ্দুসুন রাব্বুনা ওয়া রাব্বুল মালাইকাতি ওয়ার রুহ।

**অর্থ:**
মহাপবিত্র তিনি, যিনি সাম্রাজ্য ও আধিপত্যের মালিক। মহাপবিত্র তিনি, যিনি সম্মান, মহত্ত্ব, ভয়, ক্ষমতা, শ্রেষ্ঠত্ব ও প্রতাপের মালিক। মহাপবিত্র তিনি, যিনি চিরঞ্জীব, কখনো মৃত্যু বরণ করেন না। তিনি পরম পবিত্র ও মহিমান্বিত, তিনি আমাদের রব এবং ফেরেশতা ও রুহের রব।
''';