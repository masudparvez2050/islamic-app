import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextItem {
  final String text;
  final String? url;

  const TextItem({required this.text, this.url});
}

class TextSlide extends StatefulWidget {
  static const List<TextItem> defaultItems = [
    TextItem(
      text: 'আলহুদা একাডেমিতে নূরানি কোর্সে ভর্তি চলছে...',
      url: 'https://alhudabd.com/courses/1/#courses',
    ),
    TextItem(
      text: 'আলহুদা একাডেমিতে নাজেরা কোর্সে ভর্তি চলছে...',
      url: 'https://alhudabd.com/courses/2/#courses',
    ),
    TextItem(
      text: 'আলহুদা একাডেমিতে হিফজ কোর্সে ভর্তি চলছে...',
      url: 'https://alhudabd.com/courses/3/#courses',
    ),
  ];

  final double speed;
  final TextStyle? textStyle;
  final Color backgroundColor;

  const TextSlide({
    Key? key,
    this.speed = 100.0,
    this.textStyle,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  State<TextSlide> createState() => _TextSlideState();
}

class _TextSlideState extends State<TextSlide> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  final GlobalKey _contentKey = GlobalKey();
  double _contentWidth = 0.0;
  double _containerWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureAndStartAnimation();
    });
  }

  void _measureAndStartAnimation() {
    final RenderBox? contentBox = _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (contentBox != null) {
      _contentWidth = contentBox.size.width;
      _containerWidth = MediaQuery.of(context).size.width;
      
      // Only start animation if we have valid measurements
      if (_contentWidth > 0 && _containerWidth > 0) {
        _startScrollAnimation();
      }
    }
  }

  void _startScrollAnimation() {
    if (!mounted) return;
    
    _animationController.addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = maxScroll * _animationController.value;
        _scrollController.jumpTo(currentScroll);
      }
    });

    _animationController.repeat();
  }

  Future<void> _launchURL(String? url) async {
    if (url == null) return;
    
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenWidth * 0.04; // 4% of screen width

    return Container(
      height: screenHeight * 0.07, // 7% of screen height
      color: widget.backgroundColor,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          key: _contentKey,
          children: [
            ...TextSlide.defaultItems.map((item) {
              return InkWell(
                onTap: () => _launchURL(item.url),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% of screen width
                  child: Text(
                    item.text,
                    style: widget.textStyle ?? TextStyle(
                      color: const Color(0xFF00BFA5),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
            // Add duplicate items for continuous scrolling
            ...TextSlide.defaultItems.map((item) {
              return InkWell(
                onTap: () => _launchURL(item.url),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% of screen width
                  child: Text(
                    item.text,
                    style: widget.textStyle ?? TextStyle(
                      color: const Color(0xFF00BFA5),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}