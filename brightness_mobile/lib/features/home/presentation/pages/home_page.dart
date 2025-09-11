import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/home_controller.dart';
import '../../widgets/calorie_card.dart';
import '../../widgets/fox_mascot_box.dart';
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
          // Background image centered, nudged a bit downward
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: const Offset(0, 80),
              child: SizedBox(
                height: 480, // background band height
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
                          const SizedBox(height: 10),

                          // Stack để chồng Fox Mascot lên Calorie Card
                          SizedBox(
                            height:
                                250, // Tăng chiều cao để chứa đầy đủ Fox bao gồm tai
                            child: Stack(
                              clipBehavior: Clip
                                  .none, // Cho phép Fox tràn ra ngoài không bị cắt
                              children: [
                                // Calorie Card ở dưới
                                if (controller.dailyStats != null)
                                  Positioned(
                                    top:
                                        20, // Đẩy Calorie Card xuống để có chỗ cho tai Fox
                                    left: 0,
                                    right: 0,
                                    child: CalorieCard(
                                      dailyStats: controller.dailyStats!,
                                    ),
                                  ),

                                // Fox Mascot ở trên, positioned ở bên phải
                                Positioned(
                                  top:
                                      -20, // Điều chỉnh lại để tai không bị cắt
                                  right: -35, // Dịch Fox sang phải nhiều hơn
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Kích thước Fox vừa phải để không bị cắt tai
                                      final screenWidth = MediaQuery.of(
                                        context,
                                      ).size.width;
                                      final foxSize =
                                          screenWidth *
                                          0.65; // Giảm một chút để tai không bị cắt

                                      return Transform.translate(
                                        offset: const Offset(
                                          0,
                                          50,
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

                          const SizedBox(height: 20),

                          // Calendar navigation
                          _buildDateNavigationScrollable(),

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

  Widget _buildDateNavigation() {
    final controller = context.watch<HomeController>();
    // Build a 7-day window centered on the currently selected date
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(
      controller.selectedDate.year,
      controller.selectedDate.month,
      controller.selectedDate.day,
    );
    final dates = List.generate(
      7,
      (i) => selected.add(Duration(days: i - 3)), // [selected-3 .. selected+3]
    );

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: List.generate(dates.length, (index) {
            final d = dates[index];
            final isSelected =
                d.year == selected.year &&
                d.month == selected.month &&
                d.day == selected.day;
            final label = isSelected
                ? 'Today, ${d.day} ${monthAbbrev(d.month)}'
                : '${d.day}';

            return Expanded(
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () =>
                      context.read<HomeController>().setSelectedDate(d),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      style: TextStyle(
                        fontSize: isSelected
                            ? 14
                            : 16, // Giảm font size của selected item
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textSecondary,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.15),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        child: isSelected
                            ? Text(
                                label,
                                key: ValueKey(
                                  'sel-${d.day}-${d.month}-${d.year}',
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : SizedBox(
                                width: 36,
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
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDateNavigationScrollable() {
    final controller = context.watch<HomeController>();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, right: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(dates.length, (index) {
            final d = dates[index];
            final isSelected =
                d.year == selected.year &&
                d.month == selected.month &&
                d.day == selected.day;
            final label = isSelected
                ? 'Today, ${d.day} ${monthAbbrev(d.month)}'
                : '${d.day}';

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () =>
                      context.read<HomeController>().setSelectedDate(d),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      style: TextStyle(
                        fontSize: isSelected ? 14 : 14,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textSecondary,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.15),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        child: isSelected
                            ? Text(
                                label,
                                key: ValueKey(
                                  'sel-${d.day}-${d.month}-${d.year}',
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
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
