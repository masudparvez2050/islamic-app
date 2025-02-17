import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/book_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:religion/presentation/widgets/add_2.dart';

class BookLibraryScreen extends StatelessWidget {
  const BookLibraryScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> books = const [
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    {
      'title': 'সহীহ আল-বুখারী',
      'author': 'ইমাম বুখারী',
      'imageUrl': 'https://www.ruhamashop.com/wp-content/uploads/2021/06/sahih-bukhari-sharif-bangla.jpg'
    },
    // Add more books here
  ];

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
            fontSize: screenWidth * 0.06, // Adjust font size based on screen width
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button color to white
        ),
        backgroundColor: const Color(0xFF00BFA5),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
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
            height: screenHeight * 0.05, // Adjust the height as needed
            child: Advertisement2(),
          ), // Add the Advertisement2 widget here
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
                const BookDetailsScreen(),
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
        color: Colors.teal, // Set background color to teal
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(screenWidth * 0.02)),
              child: Image.network(
                book['imageUrl']!,
                height: screenHeight * 0.25,
                width: double.infinity,
                fit: BoxFit.fitHeight,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: screenHeight * 0.25,
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
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${book['title']} ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    book['author']!,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: screenWidth * 0.035),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
