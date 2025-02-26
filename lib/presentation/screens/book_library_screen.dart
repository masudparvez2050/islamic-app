import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:religion/presentation/screens/book_details_screen.dart';
import 'package:religion/presentation/widgets/add_2.dart';

class BookLibraryScreen extends StatefulWidget {
  const BookLibraryScreen({Key? key}) : super(key: key);

  @override
  _BookLibraryScreenState createState() => _BookLibraryScreenState();
}

class _BookLibraryScreenState extends State<BookLibraryScreen> {
  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
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
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'ইসলামিক বইসমূহ',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55, // Adjusted for more content space
                      crossAxisSpacing: screenWidth * 0.04,
                      mainAxisSpacing: screenWidth * 0.04,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return _buildBookCard(context, index, screenWidth, screenHeight);
                    },
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

  Widget _buildBookCard(BuildContext context, int index, double screenWidth, double screenHeight) {
    final book = books[index];
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
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Card(
        color: Colors.teal,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.02)),
              child: Image.network(
                book['imageUrl']!,
                height: screenHeight * 0.3, // Slightly reduced height
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        book['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                       'লেখক: ${book['author'] ?? 'অজানা'}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: screenWidth * 0.03,
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
    );
  }
}

