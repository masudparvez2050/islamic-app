import 'package:flutter/material.dart';

class NgajiSection extends StatelessWidget {
  const NgajiSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent News ',
                style: TextStyle(
                  color: Color(0xFF00BFA5),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildNgajiCard(true),
                _buildNgajiCard(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNgajiCard(bool isLive) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF00BFA5).withOpacity(0.1),
      ),
      child: Stack(
        children: [
          if (isLive)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          const Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children: [
                Icon(Icons.remove_red_eye, color: Color(0xFF00BFA5), size: 16),
                SizedBox(width: 4),
                Text(
                  '3.6K viewers',
                  style: TextStyle(color: Color(0xFF00BFA5), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
