import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class StepsDetailPage extends StatelessWidget {
  const StepsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    const double headerBase =
        204; // visual height of white header content (keeps header tight to content)
    final double headerHeight = headerBase + paddingTop; // full space needed

    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F4), // pink background
      body: Stack(
        children: [
          // Base scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spacer to make room for the white header overlay
                SizedBox(height: headerHeight),

                // Content below header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Stats (semi-transparent to see background)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '4880',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF20B486),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            '14%',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Total Kilocalories',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    _Metric(value: '480', label: 'Calories'),
                                    _Metric(value: '24:06', label: 'Time'),
                                    _Metric(value: '4.84', label: 'Kilometers'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Friends Activity Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Friends Activity',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.more_horiz, color: Colors.grey.shade600),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Friends List
                      _buildFriendItem(
                        'Alfred Owen',
                        '400 Calories',
                        '2.1k Steps',
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                      ),
                      const SizedBox(height: 16),
                      _buildFriendItem(
                        'Linh Nguyen',
                        '680 Calories',
                        '4.1k Steps',
                        'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // (Removed) Wavy divider between header and background

          // Overlay: header – back, Steps, Daily, Today
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SafeArea(
              child: CustomPaint(
                // Paint the white header shape with a wavy bottom
                painter: HeaderBackgroundPainter(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Back button only
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(24),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF0C6B5D),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Row 2: Icon, title, counter, and dropdown
                      Row(
                        children: [
                          // Circular gradient icon like mock
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFE9F7F2), Color(0xFFF4FBF8)],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.directions_walk,
                                color: Color(0xFF0C6B5D),
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Steps',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '1240 Steps',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xFFEDEDED)),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Daily',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Today',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Thu, 08 July',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Friend item styled card

  Widget _buildFriendItem(
    String name,
    String calories,
    String steps,
    String imageUrl,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 26, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  calories,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F7F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  size: 16,
                  color: Colors.teal.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  steps,
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the wavy chart
class WaveChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerY = height / 2;

    path.moveTo(0, centerY + 20);

    // Create a wavy pattern
    for (double x = 0; x <= width; x += 20) {
      final y = centerY + 20 * math.sin((x / width) * 4 * math.pi);
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Wavy green border that sits on top of the gradient header
class WaveBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = const Color(0xFF20B486)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final Path path = Path();

    final double height = size.height;
    final double width = size.width;
    final double baseline = height - 36; // place wave near bottom
    final double amplitude = 14;
    final double cycles = 3.5; // number of waves across width

    path.moveTo(0, baseline);
    for (double x = 0; x <= width; x += 2) {
      final double t = x / width;
      final double y =
          baseline + amplitude * math.sin(t * cycles * 2 * math.pi);
      path.lineTo(x, y);
    }

    // Draw the stroke
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Metric line item mimicking design
class _Metric extends StatelessWidget {
  final String value;
  final String label;
  const _Metric({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F7F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.place,
                size: 12,
                color: Color(0xFF20B486),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

// Thin wavy divider placed below header
class WaveEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = const Color(0xFF0C6B5D)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final double width = size.width;
    final double amplitude = 9;
    final double baseline = amplitude + 4; // near top
    final double cycles = 3.2;

    path.moveTo(0, baseline);
    for (double x = 0; x <= width; x += 2) {
      final t = x / width;
      final y = baseline + amplitude * math.sin(t * cycles * 2 * math.pi);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Draws a green wave exactly at the bottom of the header container
// Paints the full white header with a wavy bottom edge and green stroke
class HeaderBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    const double amplitude = 9; // wave height
    const double cycles = 3.2; // number of waves across width
    final double strokeWidth = 5;

    // Baseline for the wave, slightly above the bottom so the stroke is visible
    final double baseline = size.height - amplitude - strokeWidth / 2;

    // Build the filled shape (white) with a wavy bottom
    final Path shape = Path()
      ..moveTo(0, 0)
      ..lineTo(width, 0)
      ..lineTo(width, baseline);

    for (double x = width; x >= 0; x -= 2) {
      final double t = x / width;
      final double y =
          baseline + amplitude * math.sin(t * cycles * 2 * math.pi);
      shape.lineTo(x, y);
    }
    shape.close();

    // Subtle shadow under the header
    canvas.drawShadow(shape, Colors.black.withOpacity(0.10), 8, false);

    // Fill header background
    final fill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(shape, fill);

    // Draw the green wave stroke on top
    final Path wave = Path()..moveTo(0, baseline);
    for (double x = 0; x <= width; x += 2) {
      final double t = x / width;
      final double y =
          baseline + amplitude * math.sin(t * cycles * 2 * math.pi);
      wave.lineTo(x, y);
    }

    final stroke = Paint()
      ..color = const Color(0xFF0C6B5D)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(wave, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
