import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Advertisement3 extends StatefulWidget {
  final String imageUrl;
  final String link;
  final VoidCallback? onDismiss;

  const Advertisement3({
    Key? key,
    required this.imageUrl,
    required this.link,
    this.onDismiss,
  }) : super(key: key);

  @override
  State<Advertisement3> createState() => _Advertisement3State();
}

class _Advertisement3State extends State<Advertisement3> {
  bool _isVisible = true;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Semi-transparent background
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = false;
                });
                widget.onDismiss?.call();
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Centered ad content
          Center(
            child: Container(
              margin: const EdgeInsets.all(32),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                        widget.onDismiss?.call();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Ad content
                  GestureDetector(
                    onTap: () => _launchURL(widget.link),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 300,
                            height: 200,
                            color: Colors.grey[300],
                            child: Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

