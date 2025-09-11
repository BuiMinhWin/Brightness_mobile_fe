import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:brightness_mobile/app/router.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    const fullWeekdayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final weekdayFull = fullWeekdayNames[(selectedDate.weekday + 6) % 7];
    final monthStr = monthNames[selectedDate.month - 1];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _CalendarHeader(
              displayedYear: selectedDate.year,
              displayedMonth: selectedDate.month,
              selectedDay: selectedDate.day,
              headerWeekday: weekdayFull,
              headerDateText: monthStr, // Line 2: show only month
              onDayTap: (d) {
                setState(() {
                  selectedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    d,
                  );
                });
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Metric(value: '7580 m', label: 'Distance'),
                  _Metric(value: '9832', label: 'Steps'),
                  _Metric(value: '1248', label: 'Points'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
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
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final int displayedYear;
  final int displayedMonth;
  final int selectedDay;
  final String headerWeekday;
  final String headerDateText;
  final ValueChanged<int> onDayTap;
  const _CalendarHeader({
    super.key,
    required this.displayedYear,
    required this.displayedMonth,
    required this.selectedDay,
    required this.headerWeekday,
    required this.headerDateText,
    required this.onDayTap,
  });
  static const Color kHeaderGreen = Color(0xFFA7D9B0); // close to figma mint
  static const Color kDotGreen = Color(0xFF1C6B4A);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: _CalendarHeaderPainter(
            color: kHeaderGreen,
            radius: 40,
            bulgeDepth: 22,
            bulgeWidth: 160,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 42),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(headerWeekday, style: AppTextStyles.body2),
                const SizedBox(height: 2),
                Text(
                  headerDateText,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                _CalendarGrid(
                  year: displayedYear,
                  month: displayedMonth,
                  selectedDay: selectedDay,
                  onDayTap: onDayTap,
                ),
                const SizedBox(height: 12),
                _WeekdayLabels(highlightWeekday: DateTime.now().weekday),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Painter to create rounded bottom with a small center bulge and a white pill
class _CalendarHeaderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double bulgeDepth;
  final double bulgeWidth;
  const _CalendarHeaderPainter({
    required this.color,
    required this.radius,
    required this.bulgeDepth,
    required this.bulgeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final double bw = bulgeWidth.clamp(60.0, w * 0.8).toDouble();
    final double bd = bulgeDepth.clamp(8.0, 32.0).toDouble();
    final double r = radius.clamp(0.0, 48.0).toDouble();

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(w, 0)
      ..lineTo(w, h - r)
      ..quadraticBezierTo(w, h, w - r, h)
      ..lineTo(cx + bw / 2, h)
      // Create a concave notch (dip) upward into the header instead of bulging out
      ..cubicTo(cx + bw * 0.35, h, cx + bw * 0.25, h - bd, cx, h - bd)
      ..cubicTo(cx - bw * 0.25, h - bd, cx - bw * 0.35, h, cx - bw / 2, h)
      ..lineTo(r, h)
      ..quadraticBezierTo(0, h, 0, h - r)
      ..close();

    canvas.drawPath(path, paint);

    // White pill in the bulge
    final pillW = 30.0;
    final pillH = 12.0;
    // Place the green pill slightly below the bottom boundary so it sits in the dip
    final double pillCY = h + (bd - pillH * 2.2);
    final pillRect = Rect.fromCenter(
      center: Offset(cx, pillCY),
      width: pillW,
      height: pillH,
    );
    final pillPaint = Paint()..color = _CalendarHeader.kHeaderGreen;
    canvas.drawRRect(
      RRect.fromRectAndRadius(pillRect, const Radius.circular(12)),
      pillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CalendarGrid extends StatelessWidget {
  final int year;
  final int month;
  final int selectedDay;
  final ValueChanged<int> onDayTap;
  const _CalendarGrid({
    required this.year,
    required this.month,
    required this.selectedDay,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final days = List<int>.generate(
      DateUtils.getDaysInMonth(year, month),
      (i) => i + 1,
    );
    final underlineDays = {20, 24};
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double spacing = 8;
          final double totalWidth = constraints.maxWidth;
          final double cellWidth =
              (totalWidth - spacing * 6) / 7; // 7 columns, 6 gaps
          return Wrap(
            spacing: spacing,
            runSpacing: 16,
            children: days.map((d) {
              final sel = d == selectedDay;
              return SizedBox(
                width: cellWidth,
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => onDayTap(d),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: sel
                                ? _CalendarHeader.kDotGreen
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 220),
                          style: TextStyle(
                            color: sel ? Colors.white : Colors.black87,
                            fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                          ),
                          child: Text('$d'),
                        ),
                        if (underlineDays.contains(d) && !sel)
                          const Positioned(
                            bottom: -6,
                            child: SizedBox(
                              width: 24,
                              height: 3,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: _CalendarHeader.kDotGreen,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _WeekdayLabels extends StatelessWidget {
  final int highlightWeekday; // 1=Mon ... 7=Sun
  const _WeekdayLabels({required this.highlightWeekday});
  @override
  Widget build(BuildContext context) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const pink = Color(0xFFFF6B82);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (i) {
        final label = labels[i];
        final isToday =
            (i + 1) == highlightWeekday; // DateTime weekday: Mon=1..Sun=7
        return Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: isToday ? pink : AppColors.textPrimary,
            fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
          ),
        );
      }),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;
  const _Metric({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
        ),
      ],
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
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRouter.stepsDetail),
      child: Container(
        padding: const EdgeInsets.all(16),
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
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: gradient,
                shape: BoxShape.circle,
              ),
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
                Text(
                  distance,
                  style: AppTextStyles.body1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(kcal, style: AppTextStyles.body2),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
