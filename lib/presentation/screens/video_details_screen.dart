import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dharma/presentation/widgets/add_2.dart';

class VideoDetailsScreen extends StatefulWidget {
  final String videoLink;

  const VideoDetailsScreen({Key? key, required this.videoLink}) : super(key: key);

  @override
  _VideoDetailsScreenState createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoLink) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ভিডিও বিস্তারিত',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.055,
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
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.03), // 3% of screen width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025), // 2.5% of screen width
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // 2% of screen height
                  Text(
                    'ভিডিও বিস্তারিত',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // 5% of screen width
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // 1% of screen height
                  Text(
                    'এই ভিডিওটি ইসলামিক জ্ঞান অর্জনের জন্য উপযুক্ত। সম্পূর্ণ ভিডিও দেখতে নিচের বাটনে ক্লিক করুন।',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04, // 4% of screen width
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add advertisement widget at the bottom
          SizedBox(
            height: screenHeight * 0.065, // Adjust the height as needed
            child: Advertisement2(),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.08), // Adjust the padding as needed
        child: FloatingActionButton.extended(
          onPressed: () => _launchYouTubeApp(widget.videoLink),
          icon: Icon(Icons.open_in_new, color: Colors.white),
          label: Text(
            "ইউটিউবে দেখুন",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF00BFA5),
        ),
      ),
    );
  }

  Future<void> _launchYouTubeApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open YouTube app')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}