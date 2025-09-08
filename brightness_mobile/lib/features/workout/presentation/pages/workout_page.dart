import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: const [
            _TopBar(),
            _CalendarHeader(),
            SizedBox(height: 12),
            _WorkoutListSection(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          ),
          const Spacer(),
          const Icon(Icons.auto_awesome_rounded, size: 22, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          const Text('FitCalendar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader();
  static const Color kMint = Color(0xFFDCEFE5);
  static const Color kAccentGreen = Color(0xFF0F6B56);
  static const Color kPill = Color(0xFF77A69A);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 26),
          decoration: const BoxDecoration(
            color: kMint,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: CustomPaint(
            painter: _WavesPainter(),
            child: Column(
              children: const [
                SizedBox(height: 6),
                Text('Thursday, 08 July', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                SizedBox(height: 18),
                _CalendarGrid(),
                SizedBox(height: 10),
                _WeekdayLabels(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 120,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid();

  @override
  Widget build(BuildContext context) {
    // Layout a simple 7x5 grid for July starting on Thu (1 is Thu)
    final days = List<int>.generate(31, (i) => i + 1);
    const selected = {11, 20};
    const underline = {16};

    return AspectRatio(
      aspectRatio: 330 / 210,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final colW = constraints.maxWidth / 7;
          final rowH = constraints.maxHeight / 5.5;

          Widget dayCell(int day) {
            // Compute zero-based column: Thu=0 -> day=1 at index 3
            final index = day + 2; // shift so 1 sits at column 3 (0-based)
            final col = index % 7;
            final row = index ~/ 7;
            final left = col * colW;
            final top = row * rowH;
            final sel = selected.contains(day);
            return Positioned(
              left: left,
              top: top,
              width: colW,
              height: rowH,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    if (sel)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: _CalendarHeader.kAccentGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      '$day',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
                      ),
                    ),
                    if (underline.contains(day) && !sel)
                      Positioned(
                        bottom: -6,
                        child: Container(
                          width: 26,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: _CalendarHeader.kAccentGreen,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }

          // Range pills background (11–14) and (15–20)
          Positioned pill(double topRow, double startCol, double endCol) {
            final pillWidth = (endCol - startCol) * colW - 16; // inner padding
            return Positioned(
              left: startCol * colW + 8,
              top: topRow * rowH + (rowH - 36) / 2,
              child: SizedBox(
                width: pillWidth,
                height: 36,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _CalendarHeader.kPill.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            );
          }

          return Stack(
            children: [
              // Pill for 11–14: row 1, start col 0 -> end col 4 (exclusive)
              pill(1, 0, 4),
              // 15–20 wraps rows: row 2 from col 3 to 7, row 3 from col 0 to 2
              pill(2, 3, 7),
              pill(3, 0, 2),
              for (final d in days) dayCell(d),
            ],
          );
        },
      ),
    );
  }
}

class _WeekdayLabels extends StatelessWidget {
  const _WeekdayLabels();
  @override
  Widget build(BuildContext context) {
    const labels = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: labels.map((l) {
          final highlight = l == 'Sat' || l == 'Sun' || l == 'Wed' || l == 'Thr' || l == 'Fri';
          final color = highlight ? const Color(0xFFFF6B82) : AppColors.textPrimary;
          return Text(l, style: AppTextStyles.body2.copyWith(color: color));
        }).toList(),
      ),
    );
  }
}

class _WorkoutListSection extends StatelessWidget {
  const _WorkoutListSection();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
        children: const [
          _ListHeader(),
          SizedBox(height: 12),
          _MessageCard(),
          SizedBox(height: 16),
          _ActivityTile(
            title: 'Indoor Run',
            subtitle: '35 min',
            distance: '7.12 km',
            kcal: '452 kcal',
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF9FB0), Color(0xFFFFC1D0)],
            ),
            icon: Icons.directions_run,
          ),
          SizedBox(height: 12),
          _ActivityTile(
            title: 'Outdoor Cycle',
            subtitle: '24 min',
            distance: '4.22 km',
            kcal: '248 kcal',
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF7C7C7C), Color(0xFFBDBDBD)],
            ),
            icon: Icons.pedal_bike,
          ),
        ],
      ),
    );
  }
}

class _ListHeader extends StatelessWidget {
  const _ListHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Friday, 16', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                SizedBox(height: 6),
                Text('8 Workouts', style: TextStyle(fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const Text('See All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(width: 10),
          const Icon(Icons.calendar_month, color: AppColors.textPrimary),
        ],
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: const [
          CircleAvatar(radius: 20, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5')),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tell me if you need any modification',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String distance;
  final String kcal;
  final LinearGradient gradient;
  final IconData icon;

  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.kcal,
    required this.gradient,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h2.copyWith(fontSize: 16)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.body2),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(distance, style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.local_fire_department, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(kcal, style: AppTextStyles.body2),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD9C6C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path path(double shift) {
      final p = Path();
      p.moveTo(-40, size.height * (0.15 + shift));
      p.quadraticBezierTo(size.width * 0.2, size.height * (0.1 + shift), size.width * 0.4, size.height * (0.2 + shift));
      p.quadraticBezierTo(size.width * 0.7, size.height * (0.35 + shift), size.width * 1.1, size.height * (0.15 + shift));
      return p;
    }

    for (var i = 0; i < 6; i++) {
      canvas.drawPath(path(i * 0.12), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
