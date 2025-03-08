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
  {'arabic': 'الرَّحْمَن', 'bangla': 'আর-রাহমান', 'meaning': 'পরম দয়ালু', 'english': 'Ar-Rahman', 'english_meaning': 'The Most Merciful'},
  {'arabic': 'الرَّحِيم', 'bangla': 'আর-রাহীম', 'meaning': 'পরম করুণাময়', 'english': 'Ar-Rahim', 'english_meaning': 'The Most Compassionate'},
  {'arabic': 'الْمَلِك', 'bangla': 'আল-মালিক', 'meaning': 'বাদশাহ', 'english': 'Al-Malik', 'english_meaning': 'The King'},
  {'arabic': 'الْقُدُّوس', 'bangla': 'আল-কুদ্দুস', 'meaning': 'মহাপবিত্র', 'english': 'Al-Quddus', 'english_meaning': 'The Most Holy'},
  {'arabic': 'السَّلَام', 'bangla': 'আস-সালাম', 'meaning': 'শান্তিদাতা', 'english': 'As-Salam', 'english_meaning': 'The Source of Peace'},
  {'arabic': 'الْمُؤْمِن', 'bangla': 'আল-মু’মিন', 'meaning': 'নিরাপত্তাদাতা', 'english': 'Al-Mu\'min', 'english_meaning': 'The Granter of Security'},
  {'arabic': 'الْمُهَيْمِن', 'bangla': 'আল-মুহাইমিন', 'meaning': 'সংরক্ষক', 'english': 'Al-Muhaymin', 'english_meaning': 'The Protector'},
  {'arabic': 'الْعَزِيز', 'bangla': 'আল-আজিজ', 'meaning': 'মহাপরাক্রমশালী', 'english': 'Al-Aziz', 'english_meaning': 'The Mighty'},
  {'arabic': 'الْجَبَّار', 'bangla': 'আল-জাব্বার', 'meaning': 'মহাশক্তিশালী', 'english': 'Al-Jabbar', 'english_meaning': 'The Compeller'},
  {'arabic': 'الْمُتَكَبِّر', 'bangla': 'আল-মুতাকাব্বির', 'meaning': 'অহংকারের অধিকারী', 'english': 'Al-Mutakabbir', 'english_meaning': 'The Supreme'},
  {'arabic': 'الْخَالِق', 'bangla': 'আল-খালিক', 'meaning': 'সৃষ্টিকর্তা', 'english': 'Al-Khaliq', 'english_meaning': 'The Creator'},
  {'arabic': 'الْبَارِئ', 'bangla': 'আল-বারী', 'meaning': 'উদ্ভাবনকারী', 'english': 'Al-Bari', 'english_meaning': 'The Originator'},
  {'arabic': 'الْمُصَوِّر', 'bangla': 'আল-মুসাউইর', 'meaning': 'আকৃতিদানকারী', 'english': 'Al-Musawwir', 'english_meaning': 'The Fashioner'},
  {'arabic': 'الْغَفَّار', 'bangla': 'আল-গাফফার', 'meaning': 'মহাক্ষমাশীল', 'english': 'Al-Ghaffar', 'english_meaning': 'The Forgiving'},
  {'arabic': 'الْقَهَّار', 'bangla': 'আল-কাহহার', 'meaning': 'মহাপরাক্রান্ত', 'english': 'Al-Qahhar', 'english_meaning': 'The Subduer'},
  {'arabic': 'الْوَهَّاب', 'bangla': 'আল-ওয়াহ্‌হাব', 'meaning': 'মহান দাতা', 'english': 'Al-Wahhab', 'english_meaning': 'The Bestower'},
  {'arabic': 'الرَّزَّاق', 'bangla': 'আর-রাজ্জাক', 'meaning': 'রিযিকদাতা', 'english': 'Ar-Razzaq', 'english_meaning': 'The Provider'},
  {'arabic': 'الْفَتَّاح', 'bangla': 'আল-ফাত্তাহ', 'meaning': 'বিজয়দানকারী', 'english': 'Al-Fattah', 'english_meaning': 'The Opener'},
  {'arabic': 'الْعَلِيم', 'bangla': 'আল-আলিম', 'meaning': 'মহাজ্ঞানী', 'english': 'Al-Alim', 'english_meaning': 'The All-Knowing'},
  {'arabic': 'الْقَابِض', 'bangla': 'আল-কাবিদ', 'meaning': 'সংকোচনকারী', 'english': 'Al-Qabid', 'english_meaning': 'The Constrictor'},
  {'arabic': 'الْبَاسِط', 'bangla': 'আল-বাসিত', 'meaning': 'সম্প্রসারণকারী', 'english': 'Al-Basit', 'english_meaning': 'The Expander'},
  {'arabic': 'الْخَافِض', 'bangla': 'আল-খাফিদ', 'meaning': 'অবনতকারী', 'english': 'Al-Khafid', 'english_meaning': 'The Abaser'},
  {'arabic': 'الرَّافِع', 'bangla': 'আর-রাফি', 'meaning': 'উন্নতকারী', 'english': 'Ar-Rafi', 'english_meaning': 'The Exalter'},
  {'arabic': 'الْمُعِزّ', 'bangla': 'আল-মু’ইজ্জ', 'meaning': 'সম্মানদানকারী', 'english': 'Al-Mu\'izz', 'english_meaning': 'The Honorer'},
  {'arabic': 'الْمُذِلّ', 'bangla': 'আল-মুজিল্ল', 'meaning': 'বেইজ্জতকারী', 'english': 'Al-Muzill', 'english_meaning': 'The Humiliator'},
  {'arabic': 'السَّمِيع', 'bangla': 'আস-সামি', 'meaning': 'সর্বশ্রোতা', 'english': 'As-Sami', 'english_meaning': 'The All-Hearing'},
  {'arabic': 'الْبَصِير', 'bangla': 'আল-বাসির', 'meaning': 'সর্বদ্রষ্টা', 'english': 'Al-Basir', 'english_meaning': 'The All-Seeing'},
  {'arabic': 'الْحَكَم', 'bangla': 'আল-হাকাম', 'meaning': 'মীমাংসাকারী', 'english': 'Al-Hakam', 'english_meaning': 'The Judge'},
  {'arabic': 'الْعَدْل', 'bangla': 'আল-আদল', 'meaning': 'ন্যায়পরায়ণ', 'english': 'Al-Adl', 'english_meaning': 'The Just'},
  {'arabic': 'اللَّطِيف', 'bangla': 'আল-লাতীফ', 'meaning': 'সূক্ষ্মদর্শী', 'english': 'Al-Latif', 'english_meaning': 'The Subtle'},
  {'arabic': 'الْخَبِير', 'bangla': 'আল-খবীর', 'meaning': 'সর্বজ্ঞ', 'english': 'Al-Khabir', 'english_meaning': 'The All-Aware'},
  {'arabic': 'الْحَلِيم', 'bangla': 'আল-হালীম', 'meaning': 'সহনশীল', 'english': 'Al-Halim', 'english_meaning': 'The Forbearing'},
  {'arabic': 'الْعَظِيم', 'bangla': 'আল-আজীম', 'meaning': 'মহাপরাক্রমশালী', 'english': 'Al-Azim', 'english_meaning': 'The Magnificent'},
  {'arabic': 'الْغَفُور', 'bangla': 'আল-গফুর', 'meaning': 'ক্ষমাশীল', 'english': 'Al-Ghafur', 'english_meaning': 'The All-Forgiving'},
  {'arabic': 'الشَّكُور', 'bangla': 'আশ-শাকুর', 'meaning': 'গুণগ্রাহী', 'english': 'Ash-Shakur', 'english_meaning': 'The Appreciative'},
  {'arabic': 'الْعَلِيّ', 'bangla': 'আল-আলী', 'meaning': 'সুউচ্চ', 'english': 'Al-Ali', 'english_meaning': 'The Most High'},
  {'arabic': 'الْكَبِير', 'bangla': 'আল-কাবীর', 'meaning': 'মহৎ', 'english': 'Al-Kabir', 'english_meaning': 'The Most Great'},
  {'arabic': 'الْحَفِيظ', 'bangla': 'আল-হাফীজ', 'meaning': 'সংরক্ষণকারী', 'english': 'Al-Hafiz', 'english_meaning': 'The Preserver'},
  {'arabic': 'الْمُقِيت', 'bangla': 'আল-মুকীত', 'meaning': 'খাদ্যদানকারী', 'english': 'Al-Muqit', 'english_meaning': 'The Sustainer'},
  {'arabic': 'الْحَسِيب', 'bangla': 'আল-হাসীব', 'meaning': 'হিসাব গ্রহণকারী', 'english': 'Al-Hasib', 'english_meaning': 'The Reckoner'},
  {'arabic': 'الْجَلِيل', 'bangla': 'আল-জালীল', 'meaning': 'মহিমান্বিত', 'english': 'Al-Jalil', 'english_meaning': 'The Majestic'},
  {'arabic': 'الْكَرِيم', 'bangla': 'আল-কারীম', 'meaning': 'দয়ালু', 'english': 'Al-Karim', 'english_meaning': 'The Generous'},
  {'arabic': 'الرَّقِيب', 'bangla': 'আর-রাকীব', 'meaning': 'পর্যবেক্ষণকারী', 'english': 'Ar-Raqib', 'english_meaning': 'The Watchful'},
  {'arabic': 'الْمُجِيب', 'bangla': 'আল-মুজীব', 'meaning': 'কবুলকারী', 'english': 'Al-Mujib', 'english_meaning': 'The Responsive'},
  {'arabic': 'الْوَاسِع', 'bangla': 'আল-ওয়াসি', 'meaning': 'মহাবিস্তৃত', 'english': 'Al-Wasi', 'english_meaning': 'The All-Encompassing'},
  {'arabic': 'الْحَكِيم', 'bangla': 'আল-হাকীম', 'meaning': 'প্রজ্ঞাময়', 'english': 'Al-Hakim', 'english_meaning': 'The Wise'},
  {'arabic': 'الْوَدُود', 'bangla': 'আল-ওয়াদুদ', 'meaning': 'প্রেমময়', 'english': 'Al-Wadud', 'english_meaning': 'The Loving'},
  {'arabic': 'الْمَجِيد', 'bangla': 'আল-মাজীদ', 'meaning': 'মহাগৌরবময়', 'english': 'Al-Majid', 'english_meaning': 'The Glorious'},
  {'arabic': 'الْبَاعِث', 'bangla': 'আল-বাইস', 'meaning': 'পুনরুত্থানকারী', 'english': 'Al-Ba\'ith', 'english_meaning': 'The Resurrector'},
  {'arabic': 'الشَّهِيد', 'bangla': 'আশ-শাহীদ', 'meaning': 'সাক্ষী', 'english': 'Ash-Shahid', 'english_meaning': 'The Witness'},
  {'arabic': 'الْحَقّ', 'bangla': 'আল-হাক্ক', 'meaning': 'সত্য', 'english': 'Al-Haqq', 'english_meaning': 'The Truth'},
  {'arabic': 'الْوَكِيل', 'bangla': 'আল-ওয়াকীল', 'meaning': 'অভিভাবক', 'english': 'Al-Wakil', 'english_meaning': 'The Trustee'},
  {'arabic': 'الْقَوِيّ', 'bangla': 'আল-ক্বউইয়্যু', 'meaning': 'মহাশক্তিধর', 'english': 'Al-Qawiyy', 'english_meaning': 'The Strong'},
  {'arabic': 'الْمَتِين', 'bangla': 'আল-মাতীন', 'meaning': 'দৃঢ়', 'english': 'Al-Matin', 'english_meaning': 'The Firm'},
  {'arabic': 'الْوَلِيّ', 'bangla': 'আল-ওয়ালী', 'meaning': 'বন্ধু', 'english': 'Al-Wali', 'english_meaning': 'The Friend'},
  {'arabic': 'الْحَمِيد', 'bangla': 'আল-হামীদ', 'meaning': 'প্রশংসিত', 'english': 'Al-Hamid', 'english_meaning': 'The Praiseworthy'},
  {'arabic': 'الْمُحْصِي', 'bangla': 'আল-মুহ্‌সী', 'meaning': 'গণনাকারী', 'english': 'Al-Muhsi', 'english_meaning': 'The Counter'},
  {'arabic': 'الْمُبْدِئ', 'bangla': 'আল-মুবদি', 'meaning': 'সূচনাকারী', 'english': 'Al-Mubdi', 'english_meaning': 'The Initiator'},
  {'arabic': 'الْمُعِيد', 'bangla': 'আল-মুঈদ', 'meaning': 'পুনরায় আনয়নকারী', 'english': 'Al-Mu\'id', 'english_meaning': 'The Restorer'},
  {'arabic': 'الْمُحْيِي', 'bangla': 'আল-মুহ্‌য়ী', 'meaning': 'জীবনদানকারী', 'english': 'Al-Muhyi', 'english_meaning': 'The Giver of Life'},
  {'arabic': 'الْمُمِيت', 'bangla': 'আল-মুমীত', 'meaning': 'মৃত্যুদানকারী', 'english': 'Al-Mumit', 'english_meaning': 'The Bringer of Death'},
  {'arabic': 'الْحَيّ', 'bangla': 'আল-হাই', 'meaning': 'চিরঞ্জীব', 'english': 'Al-Hayy', 'english_meaning': 'The Ever-Living'},
  {'arabic': 'الْقَيُّوم', 'bangla': 'আল-কাইয়্যুম', 'meaning': 'চিরস্থায়ী', 'english': 'Al-Qayyum', 'english_meaning': 'The Self-Subsisting'},
  {'arabic': 'الْوَاجِد', 'bangla': 'আল-ওয়াজিদ', 'meaning': 'প্রাপ্ত', 'english': 'Al-Wajid', 'english_meaning': 'The Finder'},
  {'arabic': 'الْمَاجِد', 'bangla': 'আল-মাজিদ', 'meaning': 'মহিমান্বিত', 'english': 'Al-Majid', 'english_meaning': 'The Noble'},
  {'arabic': 'الْوَاحِد', 'bangla': 'আল-ওয়াহিদ', 'meaning': 'একক', 'english': 'Al-Wahid', 'english_meaning': 'The One'},
  {'arabic': 'الْأَحَد', 'bangla': 'আল-আহাদ', 'meaning': 'অদ্বিতীয়', 'english': 'Al-Ahad', 'english_meaning': 'The Unique'},
  {'arabic': 'الصَّمَد', 'bangla': 'আস-সামাদ', 'meaning': 'অমুখাপেক্ষী', 'english': 'As-Samad', 'english_meaning': 'The Eternal'},
  {'arabic': 'الْقَادِر', 'bangla': 'আল-কাদির', 'meaning': 'ক্ষমতাবান', 'english': 'Al-Qadir', 'english_meaning': 'The Capable'},
  {'arabic': 'الْمُقْتَدِر', 'bangla': 'আল-মুকতাদির', 'meaning': 'সর্বশক্তিমান', 'english': 'Al-Muqtadir', 'english_meaning': 'The All-Powerful'},
  {'arabic': 'الْمُقَدِّم', 'bangla': 'আল-মুকাদ্দিম', 'meaning': 'অগ্রবর্তী', 'english': 'Al-Muqaddim', 'english_meaning': 'The Advancer'},
  {'arabic': 'الْمُؤَخِّر', 'bangla': 'আল-মুয়াক্ষির', 'meaning': 'পশ্চাৎবর্তী', 'english': 'Al-Mu\'akhkhir', 'english_meaning': 'The Delayer'},
  {'arabic': 'الْأَوَّل', 'bangla': 'আল-আউয়াল', 'meaning': 'প্রথম', 'english': 'Al-Awwal', 'english_meaning': 'The First'},
  {'arabic': 'الْآخِر', 'bangla': 'আল-আখির', 'meaning': 'শেষ', 'english': 'Al-Akhir', 'english_meaning': 'The Last'},
  {'arabic': 'الظَّاهِر', 'bangla': 'আজ-জাহির', 'meaning': 'প্রকাশিত', 'english': 'Az-Zahir', 'english_meaning': 'The Manifest'},
  {'arabic': 'الْبَاطِن', 'bangla': 'আল-বাতিন', 'meaning': 'গুপ্ত', 'english': 'Al-Batin', 'english_meaning': 'The Hidden'},
  {'arabic': 'الْوَالِي', 'bangla': 'আল-ওয়ালী', 'meaning': 'অভিভাবক', 'english': 'Al-Wali', 'english_meaning': 'The Governor'},
  {'arabic': 'الْمُتَعَالِي', 'bangla': 'আল-মুতা’আলী', 'meaning': 'উচ্চ', 'english': 'Al-Muta\'ali', 'english_meaning': 'The Exalted'},
  {'arabic': 'الْبَرّ', 'bangla': 'আল-বার', 'meaning': 'সদয়', 'english': 'Al-Barr', 'english_meaning': 'The Source of Goodness'},
  {'arabic': 'التَّوَّاب', 'bangla': 'আত-তাওয়াব', 'meaning': 'তাওবা কবুলকারী', 'english': 'At-Tawwab', 'english_meaning': 'The Acceptor of Repentance'},
  {'arabic': 'الْمُنْتَقِم', 'bangla': 'আল-মুন্তাকিম', 'meaning': 'প্রতিশোধ গ্রহণকারী', 'english': 'Al-Muntaqim', 'english_meaning': 'The Avenger'},
  {'arabic': 'الْعَفُوّ', 'bangla': 'আল-আফু', 'meaning': 'মার্জনাকারী', 'english': 'Al-Afu', 'english_meaning': 'The Pardoner'},
  {'arabic': 'الرَّءُوف', 'bangla': 'আর-রউফ', 'meaning': 'স্নেহশীল', 'english': 'Ar-Ra\'uf', 'english_meaning': 'The Kind'},
  {'arabic': 'مَالِكِ الْمُلْك', 'bangla': 'মালিকুল মুলক', 'meaning': 'সাম্রাজ্যের মালিক', 'english': 'Malik-ul-Mulk', 'english_meaning': 'The Owner of Sovereignty'},
  {'arabic': 'ذُو الْجَلَالِ وَالْإِكْرَام', 'bangla': 'যুল-জালালি ওয়াল-ইকরাম', 'meaning': 'মহিমা ও সম্মানের অধিকারী', 'english': 'Zul-Jalali wal-Ikram', 'english_meaning': 'The Possessor of Majesty and Honor'},
  {'arabic': 'الْمُقْسِط', 'bangla': 'আল-মুকসিত', 'meaning': 'ন্যায়পরায়ণ', 'english': 'Al-Muqsit', 'english_meaning': 'The Equitable'},
  {'arabic': 'الْجَامِع', 'bangla': 'আল-জামি', 'meaning': 'একত্রকারী', 'english': 'Al-Jami', 'english_meaning': 'The Gatherer'},
  {'arabic': 'الْغَنِيّ', 'bangla': 'আল-গণী', 'meaning': 'অভাবমুক্ত', 'english': 'Al-Ghani', 'english_meaning': 'The Self-Sufficient'},
  {'arabic': 'الْمُغْنِي', 'bangla': 'আল-মুগনী', 'meaning': 'অভাব মোচনকারী', 'english': 'Al-Mughni', 'english_meaning': 'The Enricher'},
  {'arabic': 'الْمَانِع', 'bangla': 'আল-মানি', 'meaning': 'নিবারণকারী', 'english': 'Al-Mani', 'english_meaning': 'The Preventer'},
  {'arabic': 'الضَّارّ', 'bangla': 'আদ-দ্বার', 'meaning': 'ক্ষতিসাধনকারী', 'english': 'Ad-Darr', 'english_meaning': 'The Distresser'},
  {'arabic': 'النَّافِع', 'bangla': 'আন-নাফি', 'meaning': 'উপকার সাধনকারী', 'english': 'An-Nafi', 'english_meaning': 'The Benefactor'},
  {'arabic': 'النُّور', 'bangla': 'আন-নূর', 'meaning': 'আলো', 'english': 'An-Nur', 'english_meaning': 'The Light'},
  {'arabic': 'الْهَادِي', 'bangla': 'আল-হাদী', 'meaning': 'পথপ্রদর্শনকারী', 'english': 'Al-Hadi', 'english_meaning': 'The Guide'},
  {'arabic': 'الْبَدِيع', 'bangla': 'আল-বাদী', 'meaning': 'অনুপম', 'english': 'Al-Badi', 'english_meaning': 'The Incomparable'},
  {'arabic': 'الْبَاقِي', 'bangla': 'আল-বাকী', 'meaning': 'চিরস্থায়ী', 'english': 'Al-Baqi', 'english_meaning': 'The Everlasting'},
  {'arabic': 'الْوَارِث', 'bangla': 'আল-ওয়ারিস', 'meaning': 'উত্তরাধিকারী', 'english': 'Al-Warith', 'english_meaning': 'The Heir'},
  {'arabic': 'الرَّشِيد', 'bangla': 'আর-রাশীদ', 'meaning': 'সুপথপ্রদর্শক', 'english': 'Ar-Rashid', 'english_meaning': 'The Righteous Guide'},
  {'arabic': 'الصَّبُور', 'bangla': 'আস-সবুর', 'meaning': 'অসীম ধৈর্যশীল', 'english': 'As-Sabur', 'english_meaning': 'The Patient'},
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
                  _filteredNames[index]['english']!,
                  _filteredNames[index]['english_meaning']!,
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

  Widget _buildNameCard(int number, String arabicName, String banglaName, String meaning, String englishName, String englishMeaning, double screenWidth, double screenHeight) {
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
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                meaning,
                style: TextStyle(fontSize: screenWidth * 0.035,  color: const Color(0xFF00BFA5),),
                textAlign: TextAlign.center, 
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                englishMeaning,
                style: TextStyle(fontSize: screenWidth * 0.035,  color: const Color(0xFF00BFA5),),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}