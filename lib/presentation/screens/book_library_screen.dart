import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:dharma/presentation/screens/book_details_screen.dart';
import 'package:dharma/presentation/widgets/add_2.dart';

class BookLibraryScreen extends StatefulWidget {
  const BookLibraryScreen({Key? key}) : super(key: key);

  @override
  _BookLibraryScreenState createState() => _BookLibraryScreenState();
}

class _BookLibraryScreenState extends State<BookLibraryScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> books = [];
  bool isLoading = true;
  late AnimationController _animationController;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredBooks = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    fetchBooks();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('https://api.alhudabd.com/library/buybook/api'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        books = data.map((book) {
          return {
            'title': book['title'],
            'imageUrl': 'https://api.alhudabd.com/${book['image']}',
            'link': book['link'],
            'author': book['author'] ?? 'অজানা',
          };
        }).toList();
        filteredBooks = List.from(books);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  void filterBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBooks = List.from(books);
      } else {
        filteredBooks = books.where((book) => 
          book['title'].toString().toLowerCase().contains(query.toLowerCase()) ||
          book['author'].toString().toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

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
        title: !isSearching
            ? Text(
                'ইসলামিক বইসমূহ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.w600,
                ),
              )
            : TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'বই অনুসন্ধান করুন...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: filterBooks,
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  _searchController.clear();
                  filteredBooks = List.from(books);
                } else {
                  isSearching = true;
                }
              });
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00897B),
                Color(0xFF00695C),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 10),
          Expanded(
            child: isLoading
                ? _buildShimmerLoading(screenWidth, screenHeight)
                : filteredBooks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 50, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'কোন বই পাওয়া যায়নি',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: screenWidth * 0.04,
                            mainAxisSpacing: screenWidth * 0.04,
                          ),
                          itemCount: filteredBooks.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                // Staggered animation for items
                                return FadeTransition(
                                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: _animationController,
                                      curve: Interval(
                                        index * 0.05,
                                        1.0,
                                        curve: Curves.easeOut,
                                      ),
                                    ),
                                  ),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(0.0, 0.2),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: _animationController,
                                        curve: Interval(
                                          index * 0.05,
                                          1.0,
                                          curve: Curves.easeOut,
                                        ),
                                      ),
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                              child: _buildBookCard(context, index, screenWidth, screenHeight),
                            );
                          },
                        ),
                      ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
            child: Advertisement2(),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: screenWidth * 0.04,
          mainAxisSpacing: screenWidth * 0.04,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, int index, double screenWidth, double screenHeight) {
    final book = filteredBooks[index];
    
    // Start animation when books are loaded
    if (!_animationController.isAnimating && !_animationController.isCompleted) {
      _animationController.forward();
    }
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BookDetailsScreen(
                  title: book['title'],
                  imageUrl: book['imageUrl'],
                  author: book['author'],
                  link: book['link'],
                ),
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'bookImage_${book['title']}',
                child: Container(
                  height: screenWidth * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Image.network(
                    book['imageUrl']!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.grey[400],
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          book['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.033,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${book['author'] ?? 'অজানা'}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.028,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

