import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dharma/presentation/screens/video_details_screen.dart';
import 'package:dharma/presentation/widgets/add_2.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VideoLibraryScreen extends StatefulWidget {
  const VideoLibraryScreen({Key? key}) : super(key: key);

  @override
  _VideoLibraryScreenState createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  List<Map<String, dynamic>> videos = [];
  List<Map<String, dynamic>> filteredVideos = [];
  bool isLoading = true;
  String searchQuery = '';
  
  // Categories for filtering
  final List<String> categories = ['সকল', 'ইসলামিক', 'কোরআন', 'হাদিস', 'ফিকাহ'];
  String selectedCategory = 'সকল';

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    final response = await http.get(Uri.parse('https://api.alhudabd.com/ecampus/gallary_video/api'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        videos = data.map((video) {
          return {
            'id': video['id'],
            'videoLink': video['video_link'],
            // You may want to add these fields to your API response
            'title': video['title'] ?? 'ইসলামিক ভিডিও',
            'category': video['category'] ?? 'ইসলামিক',
            'duration': video['duration'] ?? '10:30',
          };
        }).toList();
        filteredVideos = List.from(videos);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load videos');
    }
  }

  void filterVideos() {
    setState(() {
      if (selectedCategory == 'সকল') {
        filteredVideos = videos.where((video) => 
          video['title'].toString().toLowerCase().contains(searchQuery.toLowerCase())
        ).toList();
      } else {
        filteredVideos = videos.where((video) => 
          video['category'] == selectedCategory &&
          video['title'].toString().toLowerCase().contains(searchQuery.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'ইসলামিক ভিডিওসমূহ',
          style: TextStyle(
            color: Colors.black87,
            fontSize: size.width * 0.055,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(size),
          _buildCategoryFilter(size),
          Expanded(
            child: isLoading
                ? _buildSkeletonLoading(size)
                : _buildVideoGrid(size),
          ),
          SizedBox(
            height: size.height * 0.05,
            child: Advertisement2(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          onChanged: (value) {
            searchQuery = value;
            filterVideos();
          },
          decoration: InputDecoration(
            hintText: 'ভিডিও অনুসন্ধান করুন',
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: size.width * 0.04,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.015),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildCategoryFilter(Size size) {
    return Container(
      height: size.height * 0.06,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          
          return Padding(
            padding: EdgeInsets.only(right: size.width * 0.02),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                  filterVideos();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF00BFA5).withOpacity(0.8)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF00BFA5).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(delay: (index * 100).ms, duration: 200.ms);
        },
      ),
    );
  }

  Widget _buildSkeletonLoading(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.14,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.3,
                        height: size.height * 0.015,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        width: size.width * 0.2,
                        height: size.height * 0.01,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate(delay: (index * 50).ms)
            .shimmer(duration: 1200.ms, delay: 500.ms)
            .fadeIn(duration: 700.ms);
        },
      ),
    );
  }

  Widget _buildVideoGrid(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: filteredVideos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videocam_off_rounded,
                    size: size.width * 0.15,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'কোন ভিডিও পাওয়া যায়নি',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms)
          : MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: filteredVideos.length,
              itemBuilder: (context, index) {
                return _buildVideoItem(context, index, size);
              },
            ),
    );
  }

  Widget _buildVideoItem(BuildContext context, int index, Size size) {
    final video = filteredVideos[index];
    final videoId = YoutubePlayer.convertUrlToId(video['videoLink']) ?? '';
    final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailsScreen(videoLink: video['videoLink']),
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
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    height: size.height * 0.14,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: size.height * 0.14,
                      color: Colors.grey[200],
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: size.height * 0.14,
                      color: Colors.grey[300],
                      child: Icon(Icons.error, color: Colors.grey[500]),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video['duration'] ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.03,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: const Color(0xFF00BFA5),
                          size: size.width * 0.06,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'] ?? 'ইসলামিক ভিডিও #${video['id']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    video['category'] ?? 'ইসলামিক',
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms, duration: 300.ms);
  }
}
