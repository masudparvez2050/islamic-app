import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dharma/presentation/screens/video_details_screen.dart';
import 'package:dharma/presentation/widgets/add_2.dart';

class VideoLibraryScreen extends StatefulWidget {
  const VideoLibraryScreen({Key? key}) : super(key: key);

  @override
  _VideoLibraryScreenState createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  List<Map<String, dynamic>> videos = [];
  bool isLoading = true;

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
          };
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ইসলামিক ভিডিওসমূহ',
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
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        return _buildVideoCard(context, index, screenWidth, screenHeight);
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

  Widget _buildVideoCard(BuildContext context, int index, double screenWidth, double screenHeight) {
    final video = videos[index];
    final videoId = YoutubePlayer.convertUrlToId(video['videoLink']) ?? '';
    final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg'; // YouTube Thumbnail URL

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailsScreen(videoLink: video['videoLink']),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                thumbnailUrl,
                width: double.infinity,
                height: screenHeight * 0.25,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ভিডিও আইডি: ${video['id']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'ভিডিও দেখার জন্য ট্যাপ করুন',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[700],
                    ),
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
