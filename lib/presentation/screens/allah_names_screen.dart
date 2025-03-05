import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/common/headerAdzan.dart';
import 'package:religion/presentation/widgets/add_2.dart';

class AllahNamesScreen extends StatefulWidget {
  const AllahNamesScreen({Key? key}) : super(key: key);

  @override
  _AllahNamesScreenState createState() => _AllahNamesScreenState();
}

class _AllahNamesScreenState extends State<AllahNamesScreen> {
  final List<Map<String, String>> _allahNames = [
    {'arabic': 'الرحمن', 'bangla': 'আর-রাহমান', 'meaning': 'পরম দয়ালু'},
    {'arabic': 'الرحيم', 'bangla': 'আর-রাহীম', 'meaning': 'পরম করুণাময়'},
    {'arabic': 'الملك', 'bangla': 'আল-মালিক', 'meaning': 'বাদশাহ'},
    {'arabic': 'القدوس', 'bangla': 'আল-কুদ্দুস', 'meaning': 'মহাপবিত্র'},
    {'arabic': 'السلام', 'bangla': 'আস-সালাম', 'meaning': 'শান্তিদাতা'},
    {'arabic': 'المؤمن', 'bangla': 'আল-মু’মিন', 'meaning': 'নিরাপত্তাদাতা'},
    {'arabic': 'المهيمن', 'bangla': 'আল-মুহাইমিন', 'meaning': 'সংরক্ষক'},
    {'arabic': 'العزيز', 'bangla': 'আল-আজিজ', 'meaning': 'মহাপরাক্রমশালী'},
    {'arabic': 'الجبار', 'bangla': 'আল-জাব্বার', 'meaning': 'মহাশক্তিশালী'},
    {'arabic': 'المتكبر', 'bangla': 'আল-মু তাকাব্বির', 'meaning': 'অহংকারের অধিকারী'},
    {'arabic': 'الخالق', 'bangla': 'আল-খালিক', 'meaning': 'সৃষ্টিকর্তা'},
    {'arabic': 'البارئ', 'bangla': 'আল-বারী', 'meaning': 'উদ্ভাবনকারী'},
    {'arabic': 'المصور', 'bangla': 'আল-মুসাউইর', 'meaning': 'আকৃতিদানকারী'},
    {'arabic': 'الغفار', 'bangla': 'আল-গাফফার', 'meaning': 'মহাক্ষমাশীল'},
    {'arabic': 'القهار', 'bangla': 'আল-কাহহার', 'meaning': 'মহাপরাক্রান্ত'},
    {'arabic': 'الوهاب', 'bangla': 'আল-ওয়াহ্‌হাব', 'meaning': 'মহান দাতা'},
    {'arabic': 'الرزاق', 'bangla': 'আর-রাজ্জাক', 'meaning': 'রিযিকদাতা'},
    {'arabic': 'الفتاح', 'bangla': 'আল-ফাত্তাহ', 'meaning': 'বিজয়দানকারী'},
    {'arabic': 'العليم', 'bangla': 'আল-আলিম', 'meaning': 'মহাজ্ঞানী'},
    {'arabic': 'القابض', 'bangla': 'আল-কাবিদ', 'meaning': 'সংকোচনকারী'},
    {'arabic': 'الباسط', 'bangla': 'আল-বাসিত', 'meaning': 'সম্প্রসারণকারী'},
    {'arabic': 'الخافض', 'bangla': 'আল-খাফিদ', 'meaning': 'অবনতকারী'},
    {'arabic': 'الرافع', 'bangla': 'আর-রাফি', 'meaning': 'উন্নতকারী'},
    {'arabic': 'المعز', 'bangla': 'আল-মু’ইজ্জ', 'meaning': 'সম্মানদানকারী'},
    {'arabic': 'المذل', 'bangla': 'আল-মুজিল্ল', 'meaning': 'বেইজ্জতকারী'},
    {'arabic': 'السميع', 'bangla': 'আস-সামি', 'meaning': 'সর্বশ্রোতা'},
    {'arabic': 'البصير', 'bangla': 'আল-বাসির', 'meaning': 'সর্বদ্রষ্টা'},
    {'arabic': 'الحكم', 'bangla': 'আল-হাকাম', 'meaning': 'মীমাংসাকারী'},
    {'arabic': 'العدل', 'bangla': 'আল-আদল', 'meaning': 'ন্যাপরায়ণ'},
    {'arabic': 'اللطيف', 'bangla': 'আল-লাতীফ', 'meaning': 'সুক্ষ্মদর্শী'},
    {'arabic': 'الخبير', 'bangla': 'আল-খবীর', 'meaning': 'সর্বজ্ঞ'},
    {'arabic': 'الحليم', 'bangla': 'আল-হালীম', 'meaning': 'সহনশীল'},
    {'arabic': 'العظيم', 'bangla': 'আল-আজীম', 'meaning': 'মহাপরাক্রমশালী'},
    {'arabic': 'الغفور', 'bangla': 'আল-গফুর', 'meaning': 'ক্ষমাশীল'},
    {'arabic': 'الشكور', 'bangla': 'আশ-শাকুর', 'meaning': 'গুণগ্রাহী'},
    {'arabic': 'العلي', 'bangla': 'আল- আলী', 'meaning': 'সুউচ্চ'},
    {'arabic': 'الكبير', 'bangla': 'আল-কাবীর', 'meaning': 'মহৎ'},
    {'arabic': 'الحفيظ', 'bangla': 'আল-হাফীজ', 'meaning': 'সংরক্ষণকারী'},
    {'arabic': 'المقيت', 'bangla': 'আল-মুকীত', 'meaning': 'খাদ্যদানকারী'},
    {'arabic': 'الحسيب', 'bangla': 'আল-হাসীব', 'meaning': 'হিসাব গ্রহণকারী'},
    {'arabic': 'الجليل', 'bangla': 'আল-জালীল', 'meaning': 'মহিমান্বিত'},
    {'arabic': 'الكريم', 'bangla': 'আল-কারীম', 'meaning': 'দয়ালু'},
    {'arabic': 'الرقيب', 'bangla': 'আর-রাকীব', 'meaning': 'পর্যবেক্ষণকারী'},
    {'arabic': 'المجيب', 'bangla': 'আল-মুজীব', 'meaning': 'কবুলকারী'},
    {'arabic': 'الواسع', 'bangla': 'আল-ওয়াসি', 'meaning': 'মহাবিস্তৃত'},
    {'arabic': 'الحكيم', 'bangla': 'আল-হাকীম', 'meaning': 'প্রজ্ঞাময়'},
    {'arabic': 'الودود', 'bangla': 'আল-ওয়াদুদ', 'meaning': 'প্রেমময়'},
    {'arabic': 'المجيد', 'bangla': 'আল-মাজীদ', 'meaning': 'মহাগৌরবময়'},
    {'arabic': 'الباعث', 'bangla': 'আল-বাইস', 'meaning': 'পুনরুত্থানকারী'},
    {'arabic': 'الشهيد', 'bangla': 'আশ-শাহীদ', 'meaning': 'সাক্ষী'},
    {'arabic': 'الحق', 'bangla': 'আল-হাক্ক', 'meaning': 'সত্য'},
    {'arabic': 'الوكيل', 'bangla': 'আল-ওয়াকীল', 'meaning': 'অভিভাবক'},
    {'arabic': 'القوى', 'bangla': 'আল-ক্বউইয়্যু', 'meaning': 'মহাশক্তিধর'},
    {'arabic': 'المتين', 'bangla': 'আল-মাতীন', 'meaning': 'দৃঢ়'},
    {'arabic': 'الولى', 'bangla': 'আল-ওয়ালী', 'meaning': 'বন্ধু'},
    {'arabic': 'الحميد', 'bangla': 'আল-হামীদ', 'meaning': 'প্রশংসিত'},
    {'arabic': 'المحصى', 'bangla': 'আল-মুহ্‌সী', 'meaning': 'গণনাকারী'},
    {'arabic': 'المبدئ', 'bangla': 'আল-মুবদি', 'meaning': 'সূচনাকারী'},
    {'arabic': 'المعيد', 'bangla': 'আল-মুঈদ', 'meaning': 'পুনরায় আনয়নকারী'},
    {'arabic': 'المحيى', 'bangla': 'আল-মুহ্‌য়ী', 'meaning': 'জীবনদানকারী'},
    {'arabic': 'المميت', 'bangla': 'আল-মুমীত', 'meaning': 'মৃত্যুদানকারী'},
    {'arabic': 'الحي', 'bangla': 'আল-হাই', 'meaning': 'চিরঞ্জীব'},
    {'arabic': 'القيوم', 'bangla': 'আল-কাইয়্যুম', 'meaning': 'চিরস্থায়ী'},
    {'arabic': 'الواجد', 'bangla': 'আল-ওয়াজিদ', 'meaning': 'প্রাপ্ত'},
    {'arabic': 'الماجد', 'bangla': 'আল-মাজিদ', 'meaning': 'মহিমান্বিত'},
    {'arabic': 'الواحد', 'bangla': 'আল-ওয়াহিদ', 'meaning': 'একক'},
    {'arabic': 'الاحد', 'bangla': 'আল-আহাদ', 'meaning': 'অদ্বিতীয়'},
    {'arabic': 'الصمد', 'bangla': 'আস-সামাদ', 'meaning': 'অমুখাপেক্ষী'},
    {'arabic': 'القادر', 'bangla': 'আল-কাদির', 'meaning': 'ক্ষমতাবান'},
    {'arabic': 'المقتدر', 'bangla': 'আল-মুকতাদির', 'meaning': 'সর্বশক্তিমান'},
    {'arabic': 'المقدم', 'bangla': 'আল-মুকাদ্দিম', 'meaning': 'অগ্রবর্তী'},
    {'arabic': 'المؤخر', 'bangla': 'আল-মুয়াক্ষির', 'meaning': 'পশ্চাৎবর্তী'},
    {'arabic': 'الأول', 'bangla': 'আল-আউয়াল', 'meaning': 'প্রথম'},
    {'arabic': 'الأخر', 'bangla': 'আল-আখির', 'meaning': 'শেষ'},
    {'arabic': 'الظاهر', 'bangla': 'আজ-জাহির', 'meaning': 'প্রকাশিত'},
    {'arabic': 'الباطن', 'bangla': 'আল-বাতিন', 'meaning': 'গুপ্ত'},
    {'arabic': 'الوالي', 'bangla': 'আল-ওয়ালী', 'meaning': 'অভিভাবক'},
    {'arabic': 'المتعالي', 'bangla': 'আল-মুতা’আলী', 'meaning': 'উচ্চ'},
    {'arabic': 'البر', 'bangla': 'আল-বার', 'meaning': 'সদয়'},
    {'arabic': 'التواب', 'bangla': 'আত-তাওয়াব', 'meaning': 'তাওবা কবুলকারী'},
    {'arabic': 'المنتقم', 'bangla': 'আল-মুন্তাকিম', 'meaning': 'প্রতিশোধ গ্রহণকারী'},
    {'arabic': 'العفو', 'bangla': 'আল-আফু', 'meaning': 'মার্জনাকারী'},
    {'arabic': 'الرؤوف', 'bangla': 'আর-রউফ', 'meaning': 'স্নেহশীল'},
    {'arabic': 'مالك الملك', 'bangla': 'মালিকুল মুলক', 'meaning': 'সাম্রাজ্যের মালিক'},
    {'arabic': 'ذو الجلال والإكرام', 'bangla': 'যুল-জালালি ওয়াল-ইকরাম', 'meaning': 'মহিমা ও সম্মানের অধিকারী'},
    {'arabic': 'المقسط', 'bangla': 'আল-মুকসিত', 'meaning': 'ন্যায়পরায়ণ'},
    {'arabic': 'الجامع', 'bangla': 'আল-জামি', 'meaning': 'একত্রকারী'},
    {'arabic': 'الغنى', 'bangla': 'আল-গণী', 'meaning': 'অভাবমুক্ত'},
    {'arabic': 'المغنى', 'bangla': 'আল-মুগনী', 'meaning': 'অভাব মোচনকারী'},
    {'arabic': 'المانع', 'bangla': 'আল-মানি', 'meaning': 'নিবারণকারী'},
    {'arabic': 'الضار', 'bangla': 'আদ-দ্বার', 'meaning': 'ক্ষতিসাধনকারী'},
    {'arabic': 'النافع', 'bangla': 'আন-নাফি', 'meaning': 'উপকার সাধনকারী'},
    {'arabic': 'النور', 'bangla': 'আন-নূর', 'meaning': 'আলো'},
    {'arabic': 'الهادي', 'bangla': 'আল-হাদী', 'meaning': 'পথপ্রদর্শনকারী'},
    {'arabic': 'البديع', 'bangla': 'আল-বাদী', 'meaning': 'অনুপম'},
    {'arabic': 'الباقي', 'bangla': 'আল-বাকী', 'meaning': 'চিরস্থায়ী'},
    {'arabic': 'الوارث', 'bangla': 'আল-ওয়ারিস', 'meaning': 'উত্তরাধিকারী'},
    {'arabic': 'الرشيد', 'bangla': 'আর-রাশীদ', 'meaning': 'সুপথপ্রদর্শক'},
    {'arabic': 'الصبور', 'bangla': 'আস-সবুর', 'meaning': 'অসীম ধৈর্যশীল'}
  ];

  List<Map<String, String>> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    _filteredNames = _allahNames;
  }

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = _allahNames;
      } else {
        _filteredNames = _allahNames
            .where((name) =>
                name['bangla']!.toLowerCase().contains(query.toLowerCase()) ||
                name['meaning']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveHeader(title: 'আল্লাহর ৯৯টি নাম'),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'নাম খুঁজুন...',
                hintStyle: TextStyle(fontSize: screenWidth * 0.04),
                prefixIcon: Icon(Icons.search, size: screenWidth * 0.06),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF00BFA5)),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              style: TextStyle(fontSize: screenWidth * 0.04),
              onChanged: _filterNames,
            ),
          ),
          // Grid of Names
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.04,
                screenWidth * 0.04,
                screenWidth * 0.04,
                screenHeight * 0.1, // Space for advertisement
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: screenWidth * 0.025,
                mainAxisSpacing: screenHeight * 0.015,
              ),
              itemCount: _filteredNames.length,
              itemBuilder: (context, index) {
                return _buildNameCard(
                  index + 1,
                  _filteredNames[index]['arabic']!,
                  _filteredNames[index]['bangla']!,
                  _filteredNames[index]['meaning']!,
                  screenWidth,
                  screenHeight,
                );
              },
            ),
          ),
          // Advertisement at the bottom
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.1, // 10% of screen height
            child: const Advertisement2(),
          ),
        ],
      ),
    );
  }

  Widget _buildNameCard(int number, String arabicName, String banglaName, String meaning, double screenWidth, double screenHeight) {
    final banglaNumbers = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    String banglaNumber = number.toString().split('').map((digit) => banglaNumbers[int.parse(digit)]).join('');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF5F6F5), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                banglaNumber,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00BFA5),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  arabicName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LalSalu',
                    color: const Color(0xFF00BFA5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                banglaName,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                meaning,
                style: TextStyle(fontSize: screenWidth * 0.035),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}