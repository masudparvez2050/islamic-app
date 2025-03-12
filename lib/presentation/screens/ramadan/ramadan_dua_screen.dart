import 'package:flutter/material.dart';

class RamadanDuaScreen extends StatelessWidget {
  const RamadanDuaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: const Text(
          'রমজানের দোয়া',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics:
              const BouncingScrollPhysics(), // Add bouncing scroll effect
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            _buildCategoryCard(context, 'রোজার নিয়ত করার দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'রোজার নিয়ত করার দোয়া',
                      content: _rojarNiotDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'ইফতারের দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'ইফতারের দোয়া', content: _ifterDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'শবে কদরের দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'শবে কদরের দোয়া',
                      content: _shabeQadarDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'প্রথম রোজার দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'প্রথম রোজার দোয়া',
                      content: _firstRojarDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'শেষ রোজার দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'শেষ রোজার দোয়া',
                      content: _sesRojarDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'সেহরীর দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'সেহরীর দোয়া', content: _sehriDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'তারাবীহ এর দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                      title: 'তারাবীহ এর দোয়া',
                      content: _tarabihDuaContent),
                ),
              );
            }),
            _buildCategoryCard(context, 'লাইলাতুল কদরের দোয়া', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DuaDetailsScreen(
                    title: 'লাইলাতুল কদরের দোয়া',
                    content: _laylatulQadrDuaContent,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.book, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}

class DuaDetailsScreen extends StatelessWidget {
  final String title;
  final String content;

  const DuaDetailsScreen({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        title: Text(title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
      ),
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
const String _shabeQadarDuaContent = '''
**শবে কদরের দোয়া**

**আরবি:**
اللَّهُمَّ إِنَّكَ عَفُوٌّ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي

**উচ্চারণ:**
আল্লাহুম্মা ইন্নাকা আফুউন তুহিব্বুল আফওয়া ফা'ফু আন্নি।

**অর্থ:**
হে আল্লাহ, নিশ্চয়ই আপনি ক্ষমাশীল, আপনি ক্ষমা করতে ভালোবাসেন। অতএব, আমাকে ক্ষমা করুন।
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