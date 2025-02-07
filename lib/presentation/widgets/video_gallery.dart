import 'package:flutter/material.dart';

class VideoGallery extends StatelessWidget {
  const VideoGallery({Key? key}) : super(key: key);

  final List<Map<String, String>> videos = const [
    {
      'title': 'Understanding Surah Al-Fatiha',
      'author': 'Islamic Lectures',
      'thumbnail': 'https://img.youtube.com/vi/vGENRvJOI7I/sddefault.jpg',
      'duration': '15:30',
      'url': 'https://www.youtube.com/embed/mEwxE-vsUIg?si=ZmSekRVQWfhKFUCl'
    },
    {
      'title': 'The Life of Prophet Muhammad (PBUH)',
      'author': 'Islamic History',
      'thumbnail': 'https://img.youtube.com/vi/mEwxE-vsUIg/sddefault.jpg',
      'duration': '45:20',
      'url': 'https://www.youtube.com/embed/vGENRvJOI7I?si=9R57o66wXZ3AjSBt'
    },
    {
      'title': 'Ramadan Preparation Guide',
      'author': 'Islamic Guidance',
      'thumbnail': 'https://img.youtube.com/vi/Pjm30fzSNfY/sddefault.jpg',
      'duration': '22:15',
      'url': 'https://www.youtube.com/embed/VNILGgnv8-8?si=J4SnQf4MEESaYFpY'
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
                'Islamic Videos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA5),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle view all
                },
                child: Text(
                  'View All',
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
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                video['thumbnail']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                video['duration']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {
                                // Handle video tap - open URL
                                print('Opening video: ${video['url']}');
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: const Center(
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      video['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      video['author']!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
