import 'package:flutter/material.dart';
import 'package:religion/presentation/widgets/common/headerHadith.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({Key? key}) : super(key: key);

  // Sample Hadith data for each collection (5 per category)
  static const Map<String, List<Map<String, String>>> _hadithCollections = {
    'সহীহ আল-বুখারী': [
      {'text': 'যে ব্যক্তি আল্লাহর উপর ভরসা করে, তার জন্য আল্লাহই যথেষ্ট।', 'reference': 'বুখারী: ১৪৩২'},
      {'text': 'নামায হলো দ্বীনের স্তম্ভ।', 'reference': 'বুখারী: ৫২৭'},
      {'text': 'সত্যবাদিতা মুক্তির পথ দেখায়।', 'reference': 'বুখারী: ৬০৯৪'},
      {'text': 'পরোপকার হলো ঈমানের অংশ।', 'reference': 'বুখারী: ১২'},
      {'text': 'জান্নাত মায়ের পায়ের নিচে।', 'reference': 'বুখারী: ২৬২৯'},
      {'text': 'ঈমান খাঁটি না হওয়া পর্যন্ত তোমরা জান্নাতে প্রবেশ করতে পারবে না।', 'reference': 'বুখারী: ৪৮'},
      {'text': 'যে ব্যক্তি মানুষের প্রতি দয়া করে না, আল্লাহও তার প্রতি দয়া করেন না।', 'reference': 'বুখারী: ৭৩৭৬'},
      {'text': 'তোমাদের মধ্যে সেই ব্যক্তি উত্তম, যে কুরআন শিখে ও শেখায়।', 'reference': 'বুখারী: ৫০২৭'},
      {'text': 'আল্লাহর সন্তুষ্টি পিতার সন্তুষ্টির মধ্যে নিহিত।', 'reference': 'বুখারী: ৫৯৭৫'},
      {'text': 'প্রতিটি ভালো কাজ সদকা।', 'reference': 'বুখারী: ২৯৮৯'},
      {'text': 'জান্নাতে প্রবেশ না করা পর্যন্ত কোন বান্দা মুমিন হতে পারে না।', 'reference': 'বুখারী: ২৬'},
      {'text': 'যে ব্যক্তি আল্লাহ ও পরকালে বিশ্বাস রাখে, সে যেন তার প্রতিবেশীকে কষ্ট না দেয়।', 'reference': 'বুখারী: ৬০১৮'},
      {'text': 'আল্লাহ তায়ালা সৌন্দর্য পছন্দ করেন।', 'reference': 'মুসলিম: ৯১'},
      {'text': 'তোমরা বেশি বেশি করে আল্লাহর জিকির করো।', 'reference': 'তিরমিজি: ৩৩৭৫'},
      {'text': 'যে ব্যক্তি ধৈর্য ধারণ করে, সে সফল হয়।', 'reference': 'বুখারী: ৫৬৫৪'},
      {'text': 'আল্লাহর রাস্তায় একটি সকাল অথবা একটি সন্ধ্যা অতিবাহিত করা পুরো পৃথিবী এবং এর মধ্যে যা কিছু আছে তার চেয়েও উত্তম।', 'reference': 'বুখারী: ২৭৯২'},
      {'text': 'যে ব্যক্তি আল্লাহর জন্য ভালোবাসে, আল্লাহর জন্য ঘৃণা করে, আল্লাহর জন্য দান করে এবং আল্লাহর জন্য withholding করে, সে তার ঈমানকে পূর্ণ করে।', 'reference': 'আবু দাউদ: ৪৬৮২'},
      {'text': 'আল্লাহর জিকির হলো হৃদয়ের প্রশান্তি।', 'reference': 'বুখারী'},
      {'text': 'যে ব্যক্তি আল্লাহর পথে চলে, আল্লাহ তার পথ সহজ করে দেন।', 'reference': 'বুখারী'},
      {'text': 'আল্লাহর কাছে সবচেয়ে প্রিয় আমল হলো সময় মতো নামাজ আদায় করা।', 'reference': 'বুখারী'},
    ],
    'সহীহ মুসলিম': [
      {'text': 'যে ব্যক্তি রমজানে ঈমানের সাথে রোজা রাখে, তার পাপ মাফ হয়ে যায়।', 'reference': 'মুসলিম: ৭৬০'},
      {'text': 'পাঁচ ওয়াক্ত নামায পড়া ফরজ।', 'reference': 'মুসলিম: ৪'},
      {'text': 'দানশীলতা সম্পদ কমায় না।', 'reference': 'মুসলিম: ২৫৮৮'},
      {'text': 'মুমিনের জন্য দুনিয়া একটি কারাগার।', 'reference': 'মুসলিম: ২৯৫৬'},
      {'text': 'সৎকাজে তাড়াতাড়ি করো।', 'reference': 'মুসলিম: ১৩৭'},
      {'text': 'আল্লাহর বান্দাদের প্রতি দয়া করো, আল্লাহ তোমার প্রতি দয়া করবেন।', 'reference': 'মুসলিম: ৫১২৫'},
      {'text': 'যে ব্যক্তি জ্ঞান অর্জনের জন্য পথ চলে, আল্লাহ তার জন্য জান্নাতের পথ সহজ করে দেন।', 'reference': 'মুসলিম: ২৬৯৯'},
      {'text': 'তোমরা সালামের প্রচলন করো।', 'reference': 'মুসলিম: ৫৪'},
      {'text': 'যে ব্যক্তি আল্লাহর রাস্তায় একটি দিন পাহারা দেয়, তা তার জন্য হাজার দিনের চেয়ে উত্তম।', 'reference': 'মুসলিম: ১৯০৬'},
      {'text': 'আল্লাহর কাছে সবচেয়ে নিকৃষ্ট ব্যক্তি হলো ঝগড়াটে।', 'reference': 'মুসলিম: ২৬৬৮'},
      {'text': 'যে ব্যক্তি কোনো মুমিনের একটি কষ্ট দূর করে, আল্লাহ কিয়ামতের দিন তার একটি কষ্ট দূর করবেন।', 'reference': 'মুসলিম: ২৬৯৯'},
      {'text': 'তোমরা একে অপরের প্রতি হিংসা করো না।', 'reference': 'মুসলিম: ২৫৫৮'},
      {'text': 'যে ব্যক্তি আল্লাহর উপর বিশ্বাস রাখে, সে যেন ভালো কথা বলে অথবা চুপ থাকে।', 'reference': 'মুসলিম: ৪৭'},
      {'text': 'আল্লাহর রাস্তায় নিহত ব্যক্তি শহীদ।', 'reference': 'মুসলিম'},
      {'text': 'যে ব্যক্তি ঋণ পরিশোধ করার নিয়ত রাখে, আল্লাহ তার ঋণ পরিশোধ করে দেন।', 'reference': 'মুসলিম'},
      {'text': 'আল্লাহর সন্তুষ্টির জন্য দান করো, আল্লাহ তোমাকে পুরস্কৃত করবেন।', 'reference': 'মুসলিম'},
      {'text': 'যে ব্যক্তি আল্লাহর বিধান অনুযায়ী বিচার করে, সে ন্যায়বিচারক।', 'reference': 'মুসলিম'},
      {'text': 'আল্লাহর কাছে সবচেয়ে প্রিয় বান্দা হলো, যে মানুষের উপকার করে।', 'reference': 'মুসলিম'},
      {'text': 'যে ব্যক্তি আল্লাহর রাস্তায় মারা যায়, সে জীবিত।', 'reference': 'মুসলিম'},
      {'text': 'আল্লাহর জিকির সবচেয়ে বড় ইবাদত।', 'reference': 'মুসলিম'},
    ],
    'সুনান আবু দাউদ': [
      {'text': 'সর্বোত্তম জিহাদ হলো নিজের প্রবৃত্তির বিরুদ্ধে লড়াই।', 'reference': 'আবু দাউদ: ২৫২৬'},
      {'text': 'দোয়া হলো ইবাদতের মূল।', 'reference': 'আবু দাউদ: ১৪৭৯'},
      {'text': 'যে ব্যক্তি জুমআর নামায ত্যাগ করে, তার হৃদয় সীলমোহর করা হয়।', 'reference': 'আবু দাউদ: ১০৫২'},
      {'text': 'পড়তে থাকো, কারণ জ্ঞানই আলো।', 'reference': 'আবু দাউদ: ৩৬৪১'},
      {'text': 'মুসাফিরের দোয়া কবুল হয়।', 'reference': 'আবু দাউদ: ২৫৯৮'},
      {'text': 'যে ব্যক্তি মিথ্যা কথা বলে, সে অভিশপ্ত।', 'reference': 'আবু দাউদ: ৪৯৯০'},
      {'text': 'তোমরা হালাল উপার্জন করো।', 'reference': 'আবু দাউদ: ৩৫৩৬'},
      {'text': 'যে ব্যক্তি ওয়াদা করে তা পূরণ করে না, তার কোনো ধর্ম নেই।', 'reference': 'আবু দাউদ: ৩৪৭০'},
      {'text': 'তোমরা ঋণ থেকে বেঁচে থাকো।', 'reference': 'আবু দাউদ: ৩৩৪২'},
      {'text': 'যে ব্যক্তি পিতামাতার সাথে ভালো ব্যবহার করে, তার বয়স বাড়ে।', 'reference': 'আবু দাউদ: ৫১৪৪'},
      {'text': 'তোমরা প্রতিবেশীর সাথে ভালো ব্যবহার করো।', 'reference': 'আবু দাউদ: ৫১৫২'},
      {'text': 'যে ব্যক্তি জ্ঞান গোপন করে, সে কিয়ামতের দিন আগুনের লাগাম পরানো হবে।', 'reference': 'আবু দাউদ: ৩৬৬৩'},
      {'text': 'তোমরা বেশি বেশি করে দান করো।', 'reference': 'আবু দাউদ'},
      {'text': 'যে ব্যক্তি আল্লাহর রাস্তায় মারা যায়, তার কোনো হিসাব নেই।', 'reference': 'আবু দাউদ'},
      {'text': 'তোমরা আল্লাহর কাছে ক্ষমা চাও, তিনি ক্ষমাশীল।', 'reference': 'আবু দাউদ'},
      {'text': 'যে ব্যক্তি আল্লাহর আনুগত্য করে, সে সফল।', 'reference': 'আবু দাউদ'},
      {'text': 'তোমরা সত্য কথা বলো, যদিও তা তিক্ত হয়।', 'reference': 'আবু দাউদ'},
      {'text': 'যে ব্যক্তি আল্লাহর উপর ভরসা করে, আল্লাহ তার জন্য যথেষ্ট।', 'reference': 'আবু দাউদ'},
      {'text': 'তোমরা একে অপরের সাথে নম্র ব্যবহার করো।', 'reference': 'আবু দাউদ'},
           {'text': 'যে ব্যক্তি ধৈর্য ধারণ করে, সে সফল হয়।', 'reference': 'আবু দাউদ'},
    ],
    'জামি আত-তিরমিজি': [
      {'text': 'যে ব্যক্তি আল্লাহর জন্য বিনয়ী হয়, আল্লাহ তাকে উন্নত করেন।', 'reference': 'তিরমিজি: ২০২৯'},
      {'text': 'সর্বোত্তম দান হলো যা গোপনে দেওয়া হয়।', 'reference': 'তিরমিজি: ৬৭৮'},
      {'text': 'মুমিনের হৃদয় মসজিদের সাথে সংযুক্ত।', 'reference': 'তিরমিজি: ২৩৭'},
      {'text': 'শিশুদের প্রতি দয়া করো।', 'reference': 'তিরমিজি: ১৯১০'},
      {'text': 'ইলম অর্জন করা প্রত্যেক মুসলিমের উপর ফরজ।', 'reference': 'তিরমিজি: ২৬৪১'},
      {'text': 'যে ব্যক্তি মানুষের প্রতি দয়া করে, আল্লাহ তার প্রতি দয়া করেন।', 'reference': 'তিরমিজি: ১৯৯৪'},
      {'text': 'তোমরা একে অপরের সাথে সালাম বিনিময় করো।', 'reference': 'তিরমিজি: ২৬৮৯'},
      {'text': 'যে ব্যক্তি আল্লাহর রাস্তায় মারা যায়, সে শহীদ।', 'reference': 'তিরমিজি: ১৬১৭'},
      {'text': 'তোমরা বেশি বেশি করে আল্লাহর জিকির করো।', 'reference': 'তিরমিজি: ৩৩৭৫'},
      {'text': 'যে ব্যক্তি পিতামাতার সাথে ভালো ব্যবহার করে, তার জন্য জান্নাত।', 'reference': 'তিরমিজি: ১৯০৪'},
      {'text': 'তোমরা প্রতিবেশীর সাথে ভালো ব্যবহার করো।', 'reference': 'তিরমিজি: ১৯৬৩'},
      {'text': 'যে ব্যক্তি জ্ঞান অর্জন করে, সে আল্লাহর কাছে প্রিয়।', 'reference': 'তিরমিজি: ২৬৮২'},
      {'text': 'তোমরা হালাল উপার্জন করো।', 'reference': 'তিরমিজি'},
      {'text': 'যে ব্যক্তি আল্লাহর উপর ভরসা করে, আল্লাহ তার জন্য যথেষ্ট।', 'reference': 'তিরমিজি'},
      {'text': 'তোমরা একে অপরের সাথে নম্র ব্যবহার করো।', 'reference': 'তিরমিজি'},
      {'text': 'যে ব্যক্তি ধৈর্য ধারণ করে, সে সফল হয়।', 'reference': 'তিরমিজি'},
      {'text': 'তোমরা আল্লাহর কাছে ক্ষমা চাও, তিনি ক্ষমাশীল।', 'reference': 'তিরমিজি'},
      {'text': 'যে ব্যক্তি আল্লাহর আনুগত্য করে, সে সফল।', 'reference': 'তিরমিজি'},
      {'text': 'তোমরা সত্য কথা বলো, যদিও তা তিক্ত হয়।', 'reference': 'তিরমিজি'},
      {'text': 'যে ব্যক্তি আল্লাহর পথে চলে, আল্লাহ তার পথ সহজ করে দেন।', 'reference': 'তিরমিজি'},
    ],
    'সুনান আন-নাসাঈ': [
      {'text': 'যে ব্যক্তি কুরআন পড়ে, সে আল্লাহর সাথে কথা বলে।', 'reference': 'নাসাঈ: ১১৪৩'},
      {'text': 'সকাল-সন্ধ্যায় দোয়া পড়ো।', 'reference': 'নাসাঈ: ১৩০৪'},
      {'text': 'যে ব্যক্তি হজ্জ করে, তার পাপ মাফ হয়।', 'reference': 'নাসাঈ: ২৬২৬'},
      {'text': 'মিথ্যা থেকে দূরে থাকো।', 'reference': 'নাসাঈ: ৫০৩৩'},
      {'text': 'নেক আমলের প্রতিদান জান্নাত।', 'reference': 'নাসাঈ: ৩১৪০'},
      {'text': 'যে ব্যক্তি আল্লাহর উপর ভরসা করে, আল্লাহ তার জন্য যথেষ্ট।', 'reference': 'নাসাঈ: ৬৩৫০'},
      {'text': 'তোমরা একে অপরের সাথে নম্র ব্যবহার করো।', 'reference': 'নাসাঈ: ৯১৯৪'},
      {'text': 'যে ব্যক্তি ধৈর্য ধারণ করে, সে সফল হয়।', 'reference': 'নাসাঈ: ৭৬৭৬'},
      {'text': 'তোমরা আল্লাহর কাছে ক্ষমা চাও, তিনি ক্ষমাশীল।', 'reference': 'নাসাঈ: ১০৩৭২'},
      {'text': 'যে ব্যক্তি আল্লাহর আনুগত্য করে, সে সফল।', 'reference': 'নাসাঈ: ১১৫৯২'},
       {'text': 'তোমরা সত্য কথা বলো, যদিও তা তিক্ত হয়।', 'reference': 'নাসাঈ'},
      {'text': 'যে ব্যক্তি আল্লাহর পথে চলে, আল্লাহ তার পথ সহজ করে দেন।', 'reference': 'নাসাঈ'},
      {'text': 'তোমরা হালাল উপার্জন করো।', 'reference': 'নাসাঈ'},
      {'text': 'যে ব্যক্তি পিতামাতার সাথে ভালো ব্যবহার করে, তার জন্য জান্নাত।', 'reference': 'নাসাঈ'},
      {'text': 'তোমরা প্রতিবেশীর সাথে ভালো ব্যবহার করো।', 'reference': 'নাসাঈ'},
      {'text': 'যে ব্যক্তি জ্ঞান অর্জন করে, সে আল্লাহর কাছে প্রিয়।', 'reference': 'নাসাঈ'},
      {'text': 'তোমরা বেশি বেশি করে আল্লাহর জিকির করো।', 'reference': 'নাসাঈ'},
      {'text': 'যে ব্যক্তি মানুষের প্রতি দয়া করে, আল্লাহ তার প্রতি দয়া করেন।', 'reference': 'নাসাঈ'},
      {'text': 'তোমরা একে অপরের সাথে সালাম বিনিময় করো।', 'reference': 'নাসাঈ'},
      {'text': 'যে ব্যক্তি আল্লাহর রাস্তায় মারা যায়, সে শহীদ।', 'reference': 'নাসাঈ'},
    ],
    'সুনান ইবনে মাজাহ': [
      {'text': 'সর্বোত্তম মানুষ তারাই যারা মানুষের উপকার করে।', 'reference': 'ইবনে মাজাহ: ২৪১'},
      {'text': 'আল্লাহর কাছে ক্ষমা প্রার্থনা করো।', 'reference': 'ইবনে মাজাহ: ৩৮১৯'},
      {'text': 'মুমিনের সম্মান তার নামাযে।', 'reference': 'ইবনে মাজাহ: ১০৬২'},
      {'text': 'দান করলে বরকত বাড়ে।', 'reference': 'ইবনে মাজাহ: ১৮৪২'},
      {'text': 'সৎ সঙ্গ গ্রহণ করো।', 'reference': 'ইবনে মাজাহ: ৪০৩৫'},
      {'text': 'যে ব্যক্তি আল্লাহর উপর ভরসা করে, আল্লাহ তার জন্য যথেষ্ট।', 'reference': 'ইবনে মাজাহ: ৩৪৪৮'},
      {'text': 'তোমরা একে অপরের সাথে নম্র ব্যবহার করো।', 'reference': 'ইবনে মাজাহ: ৩৬৯২'},
      {'text': 'যে ব্যক্তি ধৈর্য ধারণ করে, সে সফল হয়।', 'reference': 'ইবনে মাজাহ: ৪০২৩'},
      {'text': 'তোমরা আল্লাহর কাছে ক্ষমা চাও, তিনি ক্ষমাশীল।', 'reference': 'ইবনে মাজাহ: ৩৮২৭'},
      {'text': 'যে ব্যক্তি আল্লাহর আনুগত্য করে, সে সফল।', 'reference': 'ইবনে মাজাহ: ৪০১৯'},
      {'text': 'তোমরা সত্য কথা বলো, যদিও তা তিক্ত হয়।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'যে ব্যক্তি আল্লাহর পথে চলে, আল্লাহ তার পথ সহজ করে দেন।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'তোমরা হালাল উপার্জন করো।', 'reference': 'ইবনে মাজাহ'},
       {'text': 'যে ব্যক্তি পিতামাতার সাথে ভালো ব্যবহার করে, তার জন্য জান্নাত।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'তোমরা প্রতিবেশীর সাথে ভালো ব্যবহার করো।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'যে ব্যক্তি জ্ঞান অর্জন করে, সে আল্লাহর কাছে প্রিয়।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'তোমরা বেশি বেশি করে আল্লাহর জিকির করো।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'যে ব্যক্তি মানুষের প্রতি দয়া করে, আল্লাহ তার প্রতি দয়া করেন।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'তোমরা একে অপরের সাথে সালাম বিনিময় করো।', 'reference': 'ইবনে মাজাহ'},
      {'text': 'যে ব্যক্তি আল্লাহর রাস্তায় মারা যায়, সে শহীদ।', 'reference': 'ইবনে মাজাহ'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ResponsiveHeader(title: 'হাদিস'), // Using responsive header
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
        children: [
          Text(
            'হাদিস সংকলন',
            style: TextStyle(
              fontSize: screenWidth * 0.06, // 6% of screen width
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // 2% of screen height
          ..._hadithCollections.keys.map((collection) {
            return _buildHadithCollectionCard(
              context,
              collection,
              '${_hadithCollections[collection]!.length}টি হাদিস',
              _hadithCollections[collection]!,
              screenWidth,
              screenHeight,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHadithCollectionCard(
    BuildContext context,
    String title,
    String count,
    List<Map<String, String>> hadiths,
    double screenWidth,
    double screenHeight,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02), // 2% of screen height
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          Icons.book,
          color: const Color(0xFF00BFA5),
          size: screenWidth * 0.07, // 7% of screen width
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.045, // 4.5% of screen width
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          count,
          style: TextStyle(fontSize: screenWidth * 0.035), // 3.5% of screen width
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: screenWidth * 0.05, // 5% of screen width
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HadithCategoryScreen(
                title: title,
                hadiths: hadiths,
              ),
            ),
          );
        },
      ),
    );
  }
}

class HadithCategoryScreen extends StatelessWidget {
  final String title;
  final List<Map<String, String>> hadiths;

  const HadithCategoryScreen({Key? key, required this.title, required this.hadiths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF00BFA5),
      iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final hadith = hadiths[index];
          return Container(
            margin: EdgeInsets.only(bottom: screenHeight * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hadith['text']!,
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'রেফারেন্স: ${hadith['reference']}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
