import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class StepsDetailPage extends StatelessWidget {
  const StepsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _TodayTitle(),
                    SizedBox(height: 12),
                    _TrendCard(),
                    SizedBox(height: 18),
                    _KcalNumber(),
                    SizedBox(height: 4),
                    _MetricsRow(),
                    SizedBox(height: 24),
                    _FriendsTitle(),
                    SizedBox(height: 12),
                    _FriendItem(
                      name: 'Alfred Owen',
                      calories: '400 Calories',
                      steps: '2.1k Steps',
                      avatarColor: Color(0xFFFFE0B2),
                    ),
                    SizedBox(height: 12),
                    _FriendItem(
                      name: 'Linh Nguyen',
                      calories: '680 Calories',
                      steps: '4.1k Steps',
                      avatarColor: Color(0xFFBBDEFB),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.directions_walk, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Steps', style: AppTextStyles.h2),
                SizedBox(height: 2),
                Text('1 240 Steps', style: AppTextStyles.body2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: const [
                Text('Daily', style: AppTextStyles.body1),
                SizedBox(width: 6),
                Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayTitle extends StatelessWidget {
  const _TodayTitle();
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today', style: AppTextStyles.body2),
        SizedBox(height: 6),
        Text('Thu, 08 July', style: AppTextStyles.h2),
      ],
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF1F2), // light pink
            Colors.white.withOpacity(0.0),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomPaint(
        painter: _WavePainter(color: const Color(0xFF1B5E20)),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final Color color;
  _WavePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = color;

    final path = Path();
    final h = size.height * 0.55;
    path.moveTo(0, h);
    final w = size.width;
    // Draw a smooth wave across the width
    path.cubicTo(w * 0.1, h - 28, w * 0.2, h + 16, w * 0.3, h - 10);
    path.cubicTo(w * 0.4, h - 32, w * 0.5, h + 22, w * 0.6, h);
    path.cubicTo(w * 0.7, h - 20, w * 0.8, h + 18, w * 0.9, h - 6);
    path.cubicTo(w * 0.95, h - 14, w, h - 2, w, h - 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _KcalNumber extends StatelessWidget {
  const _KcalNumber();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '4880',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF16A34A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.arrow_upward, size: 14, color: AppColors.white),
                  SizedBox(width: 2),
                  Text('14%', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text('Total Kilocalories', style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow();
  Widget _item(String value, String label) => Column(
        children: [
          Row(
            children: const [
              Icon(Icons.place, color: Color(0xFF16A34A), size: 12),
              SizedBox(width: 4),
            ],
          ),
          Text(value, style: AppTextStyles.h2.copyWith(fontSize: 16)),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary)),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item('480', 'Calories'),
          _item('24:06', 'Time'),
          _item('4.84', 'Kilometers'),
        ],
      ),
    );
  }
}

class _FriendsTitle extends StatelessWidget {
  const _FriendsTitle();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Friends Activity', style: AppTextStyles.h2),
        Icon(Icons.more_horiz, color: AppColors.textSecondary),
      ],
    );
  }
}

class _FriendItem extends StatelessWidget {
  final String name;
  final String calories;
  final String steps;
  final Color avatarColor;
  const _FriendItem({required this.name, required this.calories, required this.steps, required this.avatarColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 22, backgroundColor: avatarColor, child: const Icon(Icons.person, color: AppColors.white)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.h2.copyWith(fontSize: 16)),
                const SizedBox(height: 2),
                Text(calories, style: AppTextStyles.body2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.directions_walk, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(steps, style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

