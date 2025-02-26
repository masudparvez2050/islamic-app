import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:religion/presentation/widgets/add_2.dart';
import 'package:religion/presentation/widgets/common/headerQuran.dart'; 
import 'package:religion/utils/quran_helper.dart'; 

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _bookmarkedVerses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'আল-কুরআন',
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   'আসসালামু আলাইকুম',
            //   style: TextStyle(
            //     fontSize: screenWidth * 0.035,
            //     color: Colors.black54,
            //   ),
            // ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              _showSearchDialog(context); // Call search dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFF1F6E5C),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF1F6E5C),
            labelStyle: TextStyle(fontSize: screenWidth * 0.04),
            tabs: [
              Tab(text: 'সূরা'),
              Tab(text: 'বুকমার্ক'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSurahList(),
                _buildBookmarkList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Search dialog method
  void _showSearchDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return StatefulBuilder(
          builder: (context, setState) {
            List<int> filteredSurahs = List.generate(114, (index) => index + 1)
                .where((surahNumber) =>
                    surahNumber.toString().contains(query) ||
                    getSurahNameBangla(surahNumber).toLowerCase().contains(query.toLowerCase()))
                .toList();

            return AlertDialog(
              title: Text('সূরা খুঁজুন'),
              content: SizedBox(
                width: screenWidth * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'সূরা নাম্বার বা নাম লিখুন',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredSurahs.length,
                        itemBuilder: (context, index) {
                          final surahNumber = filteredSurahs[index];
                          return ListTile(
                            title: Text(
                              '${surahNumber}. ${getSurahNameBangla(surahNumber)}',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                            onTap: () {
                              Navigator.pop(context); // Close dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahDetailScreen(
                                    surahNumber: surahNumber,
                                    onBookmark: _addBookmark,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('বন্ধ করুন'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSurahList() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: 114,
      itemBuilder: (context, index) {
        final surahNumber = index + 1;
        return ListTile(
          leading: Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              color: Color(0xFF1F6E5C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Center(
              child: Text(
                surahNumber.toString(),
                style: TextStyle(
                  color: Color(0xFF1F6E5C),
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                getSurahNameBangla(surahNumber),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Spacer(),
              Text(
                quran.getSurahNameArabic(surahNumber),
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Color(0xFF1F6E5C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Text(
            'আয়াত: ${quran.getVerseCount(surahNumber)}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: screenWidth * 0.03,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahDetailScreen(
                  surahNumber: surahNumber,
                  onBookmark: _addBookmark,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _addBookmark(int surahNumber, int verseNumber) {
    setState(() {
      _bookmarkedVerses.add({
        'surahNumber': surahNumber,
        'verseNumber': verseNumber,
      });
    });
  }

  Widget _buildBookmarkList() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: _bookmarkedVerses.length,
      itemBuilder: (context, index) {
        final bookmark = _bookmarkedVerses[index];
        final surahNumber = bookmark['surahNumber'];
        final verseNumber = bookmark['verseNumber'];
        return ListTile(
          title: Text(
            '${getSurahNameBangla(surahNumber)} - আয়াত $verseNumber',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          subtitle: Text(
            quran.getVerse(surahNumber, verseNumber),
            style: TextStyle(
              color: Colors.grey,
              fontSize: screenWidth * 0.03,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahDetailScreen(
                  surahNumber: surahNumber,
                  verseNumber: verseNumber,
                  onBookmark: _addBookmark,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final int surahNumber;
  final int? verseNumber;
  final Function(int, int) onBookmark;

  const SurahDetailScreen({
    Key? key,
    required this.surahNumber,
    this.verseNumber,
    required this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (verseNumber != null) {
        _scrollController.animateTo(
          (verseNumber! - 1) * screenHeight * 0.15,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          getSurahNameBangla(surahNumber),
          style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.045),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              _showSearchDialog(context); // Reuse the same search dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSurahHeader(screenWidth, screenHeight),
          Expanded(
            child: _buildVersesList(_scrollController, screenWidth),
          ),
        ],
      ),
    );
  }

  // Search dialog for SurahDetailScreen
  void _showSearchDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        String query = '';
        return StatefulBuilder(
          builder: (context, setState) {
            List<int> filteredSurahs = List.generate(114, (index) => index + 1)
                .where((surahNumber) =>
                    surahNumber.toString().contains(query) ||
                    getSurahNameBangla(surahNumber).toLowerCase().contains(query.toLowerCase()))
                .toList();

            return AlertDialog(
              title: Text('সূরা খুঁজুন'),
              content: SizedBox(
                width: screenWidth * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'সূরা নাম্বার বা নাম লিখুন',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3, // Limit height
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredSurahs.length,
                        itemBuilder: (context, index) {
                          final surahNumber = filteredSurahs[index];
                          return ListTile(
                            title: Text(
                              '${surahNumber}. ${getSurahNameBangla(surahNumber)}',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                            onTap: () {
                              Navigator.pop(context); // Close dialog
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahDetailScreen(
                                    surahNumber: surahNumber,
                                    onBookmark: onBookmark,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('বন্ধ করুন'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSurahHeader(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Column(
        children: [
          Text(
            quran.getSurahNameArabic(surahNumber),
            style: TextStyle(
              fontSize: screenWidth * 0.08,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            getSurahNameBangla(surahNumber),
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.06,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            '${quran.getPlaceOfRevelation(surahNumber)} • ${quran.getVerseCount(surahNumber)} আয়াত',
            style: TextStyle(
              color: Colors.white70,
              fontSize: screenWidth * 0.035),
          ),
        ],
      ),
    );
  }

  Widget _buildVersesList(ScrollController scrollController, double screenWidth) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(screenWidth * 0.04),
      itemCount: quran.getVerseCount(surahNumber),
      itemBuilder: (context, index) {
        final verseNumber = index + 1;
        return Card(
          margin: EdgeInsets.only(bottom: screenWidth * 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.0375),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.075,
                      height: screenWidth * 0.075,
                      decoration: BoxDecoration(
                        color: Color(0xFF1F6E5C).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          verseNumber.toString(),
                          style: TextStyle(
                            color: Color(0xFF1F6E5C),
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {},
                      color: Color(0xFF1F6E5C),
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark_border),
                      onPressed: () {
                        onBookmark(surahNumber, verseNumber);
                      },
                      color: Color(0xFF1F6E5C),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  quran.getVerse(surahNumber, verseNumber, verseEndSymbol: true),
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  quran.getVerseTranslation(surahNumber, verseNumber, translation: quran.Translation.bengali),
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.5,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}