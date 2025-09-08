import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _CalendarHeader(),
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
  const _CalendarHeader();
  static const Color kHeaderGreen = Color(0xFFA7D9B0); // close to figma mint
  static const Color kDotGreen = Color(0xFF1C6B4A);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
          decoration: const BoxDecoration(
            color: kHeaderGreen,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Icon(Icons.arrow_back, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Thursday', style: AppTextStyles.body2),
              const SizedBox(height: 2),
              const Text('08 July', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              const SizedBox(height: 20),
              _CalendarGrid(selectedDay: 11),
              const SizedBox(height: 12),
              const _WeekdayLabels(),
            ],
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 28,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final int selectedDay;
  const _CalendarGrid({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    final days = List<int>.generate(31, (i) => i + 1);
    final underlineDays = {20, 24};
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 16,
        children: days.map((d) {
          final sel = d == selectedDay;
          return SizedBox(
            width: MediaQuery.of(context).size.width / 7 - 10,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (sel)
                    const CircleAvatar(radius: 16, backgroundColor: _CalendarHeader.kDotGreen),
                  Text(
                    '$d',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                    ),
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
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _WeekdayLabels extends StatelessWidget {
  const _WeekdayLabels();
  @override
  Widget build(BuildContext context) {
    const labels = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: labels.map((l) {
        final isWeekend = l == 'Sat' || l == 'Sun' || l == 'Wed' || l == 'Thr' || l == 'Fri';
        final color = (l == 'Sat' || l == 'Sun' || l == 'Wed' || l == 'Thr' || l == 'Fri')
            ? const Color(0xFFFF6B82)
            : AppColors.textPrimary;
        return Text(l, style: AppTextStyles.body2.copyWith(color: color));
      }).toList(),
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
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary)),
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

