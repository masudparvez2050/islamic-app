import 'package:flutter/material.dart';

class CarouselButtons extends StatefulWidget {
  const CarouselButtons({Key? key}) : super(key: key);

  @override
  _CarouselButtonsState createState() => _CarouselButtonsState();
}

class _CarouselButtonsState extends State<CarouselButtons> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _items = [
    {'title': 'Daily Duas', 'icon': Icons.favorite},
    {'title': 'Islamic Calendar', 'icon': Icons.calendar_today},
    {'title': 'Zakat Calculator', 'icon': Icons.calculate},
    {'title': 'Prayer Times', 'icon': Icons.access_time},
    {'title': 'Qibla Direction', 'icon': Icons.explore},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.8;

    return SizedBox(
      height: 150, // Ensure sufficient height for items
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // Enable smooth scrolling
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: itemWidth, // Ensure items are scrollable
            child: _buildButton(_items[index]),
          );
        },
      ),
    );
  }

  Widget _buildButton(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF00BFA5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle button tap
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'] as IconData, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              Text(
                item['title'] as String,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
