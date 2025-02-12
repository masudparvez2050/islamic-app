import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:religion/presentation/widgets/add_2.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  List<Map<String, dynamic>> _bookmarkedVerses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'رحمن',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'AssalamuAlaikum',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
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
            tabs: [
              Tab(text: 'Surah'),
              Tab(text: 'Para'),
              Tab(text: 'Bookmark'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSurahList(),
                Center(child: Text('Para View')),
                _buildBookmarkList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahList() {
    return ListView.builder(
      itemCount: 114,
      itemBuilder: (context, index) {
        final surahNumber = index + 1;
        return ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF1F6E5C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                surahNumber.toString(),
                style: TextStyle(
                  color: Color(0xFF1F6E5C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                quran.getSurahNameEnglish(surahNumber),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                quran.getSurahNameArabic(surahNumber),
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1F6E5C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Text(
            'Verses: ${quran.getVerseCount(surahNumber)}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
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
    return ListView.builder(
      itemCount: _bookmarkedVerses.length,
      itemBuilder: (context, index) {
        final bookmark = _bookmarkedVerses[index];
        final surahNumber = bookmark['surahNumber'];
        final verseNumber = bookmark['verseNumber'];
        return ListTile(
          title: Text(
            '${quran.getSurahNameEnglish(surahNumber)} - Verse $verseNumber',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            quran.getVerse(surahNumber, verseNumber),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (verseNumber != null) {
        _scrollController.animateTo(
          (verseNumber! - 1) * 100.0, // Adjust the offset as needed
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
          quran.getSurahNameEnglish(surahNumber),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSurahHeader(),
          Expanded(
            child: _buildVersesList(_scrollController),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahHeader() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1F6E5C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            quran.getSurahNameArabic(surahNumber),
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            quran.getSurahNameEnglish(surahNumber),
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${quran.getPlaceOfRevelation(surahNumber)} • ${quran.getVerseCount(surahNumber)} verses',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersesList(ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      itemCount: quran.getVerseCount(surahNumber),
      itemBuilder: (context, index) {
        final verseNumber = index + 1;
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
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
                SizedBox(height: 16),
                Text(
                  quran.getVerse(surahNumber, verseNumber, verseEndSymbol: true),
                  style: TextStyle(
                    fontSize: 24,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  quran.getVerseTranslation(surahNumber, verseNumber, translation: quran.Translation.bengali),
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.5,
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
