import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class Advertisement1 extends StatefulWidget {
  final List<String> imageUrls;
  final List<String> links;
  // final String adUnitId; // Google AdMob unit ID

  const Advertisement1({
    Key? key,
    required this.imageUrls,
    required this.links,
    // required this.adUnitId,
  }) : super(key: key);

  @override
  State<Advertisement1> createState() => _Advertisement1State();
}

class _Advertisement1State extends State<Advertisement1> {
  int _currentIndex = 0;
  // BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // _loadBannerAd();
  }

  // void _loadBannerAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: widget.adUnitId,
  //     size: AdSize.banner,
  //     request: AdRequest(),
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isAdLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //   _bannerAd?.load();
  // }

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    final bool canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom Banner Carousel
        Container(
          width: double.infinity,
          height: 100, // Adjust height as needed
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 6),
              autoPlayAnimationDuration: Duration(milliseconds: 1200),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.imageUrls.asMap().entries.map((entry) {
              int index = entry.key;
              String imageUrl = entry.value;
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () => _launchURL(widget.links[index]),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        // Dots Indicator
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: widget.imageUrls.asMap().entries.map((entry) {
        //     return Container(
        //       width: 8.0,
        //       height: 8.0,
        //       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.black.withOpacity(
        //           _currentIndex == entry.key ? 0.9 : 0.4,
        //         ),
        //       ),
        //     );
        //   }).toList(),
        // ),
        // Google AdMob Banner

        // if (_isAdLoaded)
        //   Container(
        //     width: _bannerAd!.size.width.toDouble(),
        //     height: _bannerAd!.size.height.toDouble(),
        //     child: AdWidget(ad: _bannerAd!),
        //   ),
      ],
    );
  }
}