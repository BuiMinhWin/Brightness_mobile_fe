import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/home_controller.dart';
import '../../widgets/calorie_card.dart';
import '../../widgets/fox_mascot_box.dart';
import '../../widgets/calorie_info_overlay.dart';
import '../../widgets/workout_plan_card.dart';
import '../../widgets/fitness_programs_section.dart';
import '../../widgets/today_info_section.dart';
import '../../widgets/invite_friends_card.dart';
import '../../widgets/activity_chart.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/home_header_bar.dart';
import '../../widgets/stats_overview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dùng để tích lũy khoảng kéo ngang và đổi ngày theo ngưỡng
  double _dragDx = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: const Offset(0, 80),
              child: SizedBox(
                height: 480,
                child: Image.asset(
                  'assets/images/home_bg.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const HomeHeaderBar(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => context.read<HomeController>().refresh(),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),

                          // Stack để chồng Fox Mascot lên Calorie Card
                          SizedBox(
                            height:
                                230, // Tăng chiều cao để chứa đầy đủ Fox bao gồm tai
                            child: Stack(
                              clipBehavior: Clip
                                  .none, // Cho phép Fox tràn ra ngoài không bị cắt
                              children: [
                                // Calorie Card ở dưới
                                if (controller.dailyStats != null)
                                  Positioned(
                                    top:
                                        39.5, // Đẩy Calorie Card xuống để có chỗ cho tai Fox
                                    left: 0,
                                    right: 0,
                                    child: CalorieCard(
                                      dailyStats: controller.dailyStats!,
                                    ),
                                  ),
                                if (controller.dailyStats != null)
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: CalorieInfoOverlay(
                                      dailyStats: controller.dailyStats!,
                                    ),
                                  ),

                                // Fox Mascot ở trên, positioned ở bên phải
                                Positioned(
                                  top: 0, // Điều chỉnh lại để tai không bị cắt
                                  right: -38, // Dịch Fox sang phải nhiều hơn
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Kích thước Fox vừa phải để không bị cắt tai
                                      final screenWidth = MediaQuery.of(
                                        context,
                                      ).size.width;
                                      final foxSize =
                                          screenWidth *
                                          0.60; // Giảm một chút để tai không bị cắt

                                      return Transform.translate(
                                        offset: const Offset(
                                          0,
                                          1,
                                        ), // kéo Fox xuống một chút
                                        child: FoxMascotBox(
                                          size: foxSize,
                                          right: 5,
                                          bottom: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 1),

                          // Calendar navigation
                          _buildDateNavigationFixedPositions(),

                          const SizedBox(height: 0),

                          // Stats Overview (Calories, Distance, Steps, Points)
                          if (controller.dailyStats != null)
                            StatsOverview(
                              dailyStats: controller.dailyStats!,
                              opacity: 0,
                            ),

                          const SizedBox(height: 12),

                          // Activity Chart
                          if (controller.dailyStats != null)
                            ActivityChart(
                              weeklyData: controller.dailyStats!.weeklyCalories,
                              opacity: 0,
                            ),

                          const SizedBox(height: 24),

                          // My Plan Section
                          _buildSectionTitle("My Plan", "July, 2021"),
                          const SizedBox(height: 16),

                          if (controller.workoutPlans.isNotEmpty)
                            ...controller.workoutPlans.map(
                              (plan) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: WorkoutPlanCard(workoutPlan: plan),
                              ),
                            ),

                          const SizedBox(height: 24),

                          // Recent Plan Section
                          FitnessProgramsSection(
                            programs: controller.fitnessPrograms,
                          ),

                          const SizedBox(height: 24),

                          // Today's Information Section
                          if (controller.dailyStats != null)
                            TodayInfoSection(
                              dailyStats: controller.dailyStats!,
                            ),

                          const SizedBox(height: 24),

                          // Invite Friends Card
                          const InviteFriendsCard(),

                          const SizedBox(height: 100), // Space for bottom nav
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildDateNavigationFixedPositions() {
    final controller = context.watch<HomeController>();

    final selected = DateTime(
      controller.selectedDate.year,
      controller.selectedDate.month,
      controller.selectedDate.day,
    );
    final dates = List.generate(7, (i) => selected.add(Duration(days: i - 3)));

    String monthAbbrev(int m) => const [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][m - 1];

    return SizedBox(
      height: 80,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          _dragDx += details.delta.dx;
          const stepPx = 40.0; // mỗi 40px đổi 1 ngày
          final home = context.read<HomeController>();
          while (_dragDx <= -stepPx) {
            _dragDx += stepPx;
            final d = DateTime(
              home.selectedDate.year,
              home.selectedDate.month,
              home.selectedDate.day,
            ).add(const Duration(days: 1));
            home.setSelectedDate(d);
          }
          while (_dragDx >= stepPx) {
            _dragDx -= stepPx;
            final d = DateTime(
              home.selectedDate.year,
              home.selectedDate.month,
              home.selectedDate.day,
            ).subtract(const Duration(days: 1));
            home.setSelectedDate(d);
          }
        },
        onHorizontalDragEnd: (_) {
          _dragDx = 0;
        },
        child: Stack(
          children: [
            // Hàng 7 ô ngày, vị trí cố định
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: List.generate(dates.length, (index) {
                  final d = dates[index];
                  final isSelected =
                      d.year == selected.year &&
                      d.month == selected.month &&
                      d.day == selected.day;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () =>
                              context.read<HomeController>().setSelectedDate(d),
                          child: AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              // Luôn trong suốt; chip nổi sẽ hiển thị chọn
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOut,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: AppColors.textSecondary,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                              child: Text(
                                '${d.day}',
                                key: ValueKey(
                                  'day-${d.day}-${d.month}-${d.year}',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Chip nổi hiển thị đầy đủ nội dung ngày được chọn (luôn ở giữa)
            Align(
              alignment: Alignment.topCenter,
              child: IgnorePointer(
                ignoring: true,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final label =
                        '${selected.day},${monthAbbrev(selected.month)}';
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth - 16, // chừa mép
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              ),
                          child: Container(
                            key: ValueKey(
                              '${selected.day}-${selected.month}-${selected.year}',
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.h2),
            Text(
              subtitle,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Icon(Icons.more_horiz, color: AppColors.textSecondary),
      ],
    );
  }
}
