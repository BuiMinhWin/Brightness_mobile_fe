import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../domain/entities/daily_stats.dart';

class CalorieCard extends StatelessWidget {
  final DailyStats dailyStats;

  const CalorieCard({super.key, required this.dailyStats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4AE5C3), Color(0xFF7AE582)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today, 8 Jul",
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${dailyStats.calories.toInt()} Kcal",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Calendar",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Cute Fox Mascot
          Positioned(
            right: -10,
            top: -20,
            child: SizedBox(
              width: 120,
              height: 120,
              child: CustomPaint(painter: FoxMascotPainter()),
            ),
          ),
        ],
      ),
    );
  }
}

class FoxMascotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Fox body (orange)
    paint.color = const Color(0xFFFF8A50);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.7),
        width: size.width * 0.6,
        height: size.height * 0.5,
      ),
      paint,
    );

    // Fox head
    paint.color = const Color(0xFFFF8A50);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.35),
        width: size.width * 0.5,
        height: size.height * 0.4,
      ),
      paint,
    );

    // Fox ears
    paint.color = const Color(0xFFFF8A50);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.2),
        width: size.width * 0.15,
        height: size.height * 0.25,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.2),
        width: size.width * 0.15,
        height: size.height * 0.25,
      ),
      paint,
    );

    // Inner ears
    paint.color = const Color(0xFFFFF5E1);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.22),
        width: size.width * 0.08,
        height: size.height * 0.15,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.65, size.height * 0.22),
        width: size.width * 0.08,
        height: size.height * 0.15,
      ),
      paint,
    );

    // Face area (cream)
    paint.color = const Color(0xFFFFF5E1);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.4),
        width: size.width * 0.35,
        height: size.height * 0.3,
      ),
      paint,
    );

    // Eyes (closed, happy)
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;

    // Left eye (arc)
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.42, size.height * 0.35),
        width: 8,
        height: 6,
      ),
      0,
      3.14, // Pi radians (180 degrees)
      false,
      paint,
    );

    // Right eye (arc)
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.58, size.height * 0.35),
        width: 8,
        height: 6,
      ),
      0,
      3.14,
      false,
      paint,
    );

    // Nose
    paint.style = PaintingStyle.fill;
    paint.color = Colors.black;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.42),
        width: 4,
        height: 3,
      ),
      paint,
    );

    // Mouth (happy smile)
    paint.color = Colors.black;
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.45),
        width: 12,
        height: 8,
      ),
      0,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
