import 'package:flutter/material.dart';
import 'dart:math' as math;

class TimeDisplay2 extends StatefulWidget {
  const TimeDisplay2({Key? key}) : super(key: key);

  @override
  State<TimeDisplay2> createState() => _TimeDisplay2State();
}

class _TimeDisplay2State extends State<TimeDisplay2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: GlowingBorderPainter(
            progress: _controller.value,
            glowColors: [ // Use a list of colors for the gradient
              Color(0xFF26A69A).withOpacity(0.8),   // Darker Turquoise
              Color(0xFF4DB6AC).withOpacity(0.8),   // Medium Turquoise
              Color(0xFF80CBC4).withOpacity(0.8),   // Lighter Turquoise
              Colors.white.withOpacity(0.9),        // Soft White
              Color(0xFF80CBC4).withOpacity(0.8),   // Lighter Turquoise
              Color(0xFF4DB6AC).withOpacity(0.8),   // Medium Turquoise
            ],
            borderRadius: 100,
          ),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(4), // Margin for glow effect
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Current Prayer Status
                Text(
                  'এখন চলছে',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                // Prayer Name and Time
                Text(
                  'আসর | 04:06 PM - 12:41 AM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                // Remaining Time
                Text(
                  'সময় বাকি: ২ ঘন্টা ৩০ মিনিট',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                
                 // Separator Line
                Container(
                 width: MediaQuery.of(context).size.width * 0.5, // 50% of screen width
                  height: 1,
                  color: Colors.white.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
                // Bottom Times
                Text(
                  'সেহরি শেষ : 12:41 AM | ইফতার শুরু : 12:41 AM',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12, fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GlowingBorderPainter extends CustomPainter {
  final double progress;
  final List<Color> glowColors; // Use a list of colors
  final double borderRadius;

  GlowingBorderPainter({
    required this.progress,
    required this.glowColors,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    // Create gradient for glow effect
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = SweepGradient(
        colors: glowColors, // Use the list of colors
        stops: [0.0, 0.16, 0.33, 0.5, 0.66, 0.83], // Adjust stops for each color
        startAngle: 0,
        endAngle: math.pi * 2,
        transform: GradientRotation(progress * math.pi * 2),
      ).createShader(rect);

    // Draw the glowing border
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(GlowingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.glowColors != glowColors;
  }
}