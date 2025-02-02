// import 'package:flutter/material.dart';
// import 'package:quran/quran.dart' as quran;
// import 'package:religion/presentation/widgets/bottom_nav_bar.dart';

// class QuranScreen extends StatefulWidget {
//   const QuranScreen({Key? key}) : super(key: key);

//   @override
//   _QuranScreenState createState() => _QuranScreenState();
// }

// class _QuranScreenState extends State<QuranScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedTab = 0;
//   List<int> _bookmarkedVerses = [];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: Colors.black),
//           onPressed: () {},
//         ),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'رحمن',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'AssalamuAlaikum',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.black),
//             onPressed: () {
//               showSearch(context: context, delegate: QuranSearchDelegate());
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           TabBar(
//             controller: _tabController,
//             labelColor: Color(0xFF1F6E5C),
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Color(0xFF1F6E5C),
//             tabs: [
//               Tab(text: 'Surah'),
//               Tab(text: 'Para'),
//               Tab(text: 'Bookmark'),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildSurahList(),
//                 _buildParaList(),
//                 _buildBookmarkList(),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const BottomNavBar(),
//     );
//   }

//   Widget _buildSurahList() {
//     return ListView.builder(
//       itemCount: 114,
//       itemBuilder: (context, index) {
//         final surahNumber = index + 1;
//         return ListTile(
//           leading: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Color(0xFF1F6E5C).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Text(
//                 surahNumber.toString(),
//                 style: TextStyle(
//                   color: Color(0xFF1F6E5C),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           title: Row(
//             children: [
//               Text(
//                 quran.getSurahNameEnglish(surahNumber),
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 quran.getSurahNameArabic(surahNumber),
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Color(0xFF1F6E5C),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           subtitle: Text(
//             'Verses: ${quran.getVerseCount(surahNumber)}',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SurahDetailScreen(
//                   surahNumber: surahNumber,
//                   onBookmark: _toggleBookmark,
//                   bookmarkedVerses: _bookmarkedVerses,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildParaList() {
//     return ListView.builder(
//       itemCount: 30,
//       itemBuilder: (context, index) {
//         final paraNumber = index + 1;
//         return ListTile(
//           leading: Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Color(0xFF1F6E5C).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Text(
//                 paraNumber.toString(),
//                 style: TextStyle(
//                   color: Color(0xFF1F6E5C),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           title: Text(
//             'Para $paraNumber',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ParaDetailScreen(paraNumber: paraNumber),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildBookmarkList() {
//     return ListView.builder(
//       itemCount: _bookmarkedVerses.length,
//       itemBuilder: (context, index) {
//         final verseKey = _bookmarkedVerses[index];
//         final surahNumber = verseKey ~/ 1000;
//         final verseNumber = verseKey % 1000;
//         return ListTile(
//           title: Text(
//             'Surah ${quran.getSurahNameEnglish(surahNumber)} - Ayah $verseNumber',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SurahDetailScreen(
//                   surahNumber: surahNumber,
//                   onBookmark: _toggleBookmark,
//                   bookmarkedVerses: _bookmarkedVerses,
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void _toggleBookmark(int surahNumber, int verseNumber) {
//     final verseKey = surahNumber * 1000 + verseNumber;
//     setState(() {
//       if (_bookmarkedVerses.contains(verseKey)) {
//         _bookmarkedVerses.remove(verseKey);
//       } else {
//         _bookmarkedVerses.add(verseKey);
//       }
//     });
//   }
// }

// class SurahDetailScreen extends StatelessWidget {
//   final int surahNumber;
//   final Function(int, int) onBookmark;
//   final List<int> bookmarkedVerses;

//   const SurahDetailScreen({
//     Key? key,
//     required this.surahNumber,
//     required this.onBookmark,
//     required this.bookmarkedVerses,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           quran.getSurahNameEnglish(surahNumber),
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.black),
//             onPressed: () {
//               showSearch(context: context, delegate: QuranSearchDelegate());
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildSurahHeader(),
//           Expanded(
//             child: _buildVersesList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSurahHeader() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Color(0xFF1F6E5C),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         children: [
//           Text(
//             quran.getSurahNameArabic(surahNumber),
//             style: TextStyle(
//               fontSize: 32,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             quran.getSurahNameEnglish(surahNumber),
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             '${quran.getPlaceOfRevelation(surahNumber)} • ${quran.getVerseCount(surahNumber)} verses',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVersesList() {
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: quran.getVerseCount(surahNumber),
//       itemBuilder: (context, index) {
//         final verseNumber = index + 1;
//         final verseKey = surahNumber * 1000 + verseNumber;
//         final isBookmarked = bookmarkedVerses.contains(verseKey);
//         return Card(
//           margin: EdgeInsets.only(bottom: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Color(0xFF1F6E5C).withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           verseNumber.toString(),
//                           style: TextStyle(
//                             color: Color(0xFF1F6E5C),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Spacer(),
//                     IconButton(
//                       icon: Icon(Icons.share_outlined),
//                       onPressed: () {},
//                       color: Color(0xFF1F6E5C),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//                       ),
//                       onPressed: () {
//                         onBookmark(surahNumber, verseNumber);
//                       },
//                       color: Color(0xFF1F6E5C),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   quran.getVerse(surahNumber, verseNumber, verseEndSymbol: true),
//                   style: TextStyle(
//                     fontSize: 24,
//                     height: 1.5,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textDirection: TextDirection.rtl,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   quran.getVerseTranslation(surahNumber, verseNumber, translation: quran.Translation.bengali),
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class ParaDetailScreen extends StatelessWidget {
//   final int paraNumber;

//   const ParaDetailScreen({Key? key, required this.paraNumber}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final surahVerses = quran.getSurahVersesInJuzAsList(paraNumber);

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Para $paraNumber',
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.black),
//             onPressed: () {
//               showSearch(context: context, delegate: QuranSearchDelegate());
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: surahVerses.length,
//         itemBuilder: (context, index) {
//           final surahVerse = surahVerses[index];
//           return Card(
//             margin: EdgeInsets.only(bottom: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Surah ${quran.getSurahNameEnglish(surahVerse.surahNumber)} - Ayah ${surahVerse.verseNumber}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     quran.getVerse(surahVerse.surahNumber, surahVerse.verseNumber, verseEndSymbol: true),
//                     style: TextStyle(
//                       fontSize: 24,
//                       height: 1.5,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     quran.getVerseTranslation(surahVerse.surahNumber, surahVerse.verseNumber, translation: quran.Translation.bengali),
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class QuranSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = quran.search(query);
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final result = results[index];
//         return ListTile(
//           title: Text(result.text),
//           subtitle: Text('Surah ${result.surahNumber}, Ayah ${result.verseNumber}'),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SurahDetailScreen(
//                   surahNumber: result.surahNumber,
//                   onBookmark: (surahNumber, verseNumber) {},
//                   bookmarkedVerses: [],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = quran.search(query);
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final suggestion = suggestions[index];
//         return ListTile(
//           title: Text(suggestion.text),
//           subtitle: Text('Surah ${suggestion.surahNumber}, Ayah ${suggestion.verseNumber}'),
//           onTap: () {
//             query = suggestion.text;
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:religion/presentation/widgets/bottom_nav_bar.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

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
          // _buildLastReadCard(),
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
                Center(child: Text('Bookmark View')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: 
const BottomNavBar(),
      // _buildBottomNavigationBar(),
    );
  }

  Widget _buildLastReadCard() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1F6E5C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Positioned(
          //   right: 0,
          //   bottom: 0,
          //   child: Image.network(
          //     '',
          //     height: 100,
          //     width: 100,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Read',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'الفاتحة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ayah no. 1 - Ayah no. 10',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Continue'),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF1F6E5C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
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
                builder: (context) => SurahDetailScreen(surahNumber: surahNumber),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF1F6E5C),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Hadith',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Goal',
          ),
        ],
      ),
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final int surahNumber;

  const SurahDetailScreen({Key? key, required this.surahNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: _buildVersesList(),
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

  Widget _buildVersesList() {
    return ListView.builder(
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
                      onPressed: () {},
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
