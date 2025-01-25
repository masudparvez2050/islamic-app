import 'package:flutter/material.dart';
import 'package:religion/presentation/screens/book_library_screen.dart';
import 'package:religion/presentation/screens/book_details_screen.dart';

class BookLibrary extends StatelessWidget {
  const BookLibrary({Key? key}) : super(key: key);

  final List<Map<String, String>> books = const [
    {
      'title': 'সাহিহ আল বুখারী',
      'author': 'ইমাম বুখারী',
      'cover':
          'https://e7.pngegg.com/pngimages/595/619/png-clipart-sahih-al-bukhari-sahih-muslim-quran-islam-hadith-islam-text-religion.png',
      'category': 'হাদিস'
    },
    {
      'title': 'Riyadus Saliheen',
      'author': 'Imam An-Nawawi',
      'cover':
          'https://darussalamstore.ae/images/thumbnails/detailed/25/darussalam-2017-11-30-15-39-06-id-461_hndk3yamfwwnde1z.webp',
      'category': 'Hadith'
    },
    {
      'title': 'The Sealed Nectar',
      'author': 'Safiur Rahman',
      'cover':
          'https://darussalam.pk/images/thumbnails/detailed/17/darussalam-2017-06-13-12-54-00the-sealed-nectar-2.webp',
      'category': 'Seerah'
    },
    {
      'title': 'Fortress of the Muslim',
      'author': 'Said Al-Qahtani',
      'cover':
          'https://app-uploads-cdn.fera.ai/customer_photos/images/001/002/017/920/original/IMG_5091.jpeg?1733649377',
      'category': 'Dua'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ইসলামিক বই',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA5),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const BookLibraryScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
                child: Text(
                  ' আরও দেখুন',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: books.length,
            itemBuilder: (context, index) {
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
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            book['cover']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        book['author']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
