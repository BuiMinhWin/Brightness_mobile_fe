import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/home_controller.dart';
import '../../widgets/calorie_card.dart';
import '../../widgets/stats_overview.dart';
import '../../widgets/activity_chart.dart';
import '../../widgets/workout_plan_card.dart';
import '../../widgets/fitness_programs_section.dart';
import '../../widgets/today_info_section.dart';
import '../../widgets/invite_friends_card.dart';
import '../../widgets/bottom_nav_bar.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context.read<HomeController>().refresh(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Calorie Card with cute mascot
                      if (controller.dailyStats != null)
                        CalorieCard(dailyStats: controller.dailyStats!),

                      const SizedBox(height: 20),

                      // Calendar navigation
                      _buildDateNavigation(),

                      const SizedBox(height: 20),

                      // Stats Overview (Calories, Distance, Steps, Points)
                      if (controller.dailyStats != null)
                        StatsOverview(dailyStats: controller.dailyStats!),

                      const SizedBox(height: 20),

                      // Activity Chart
                      if (controller.dailyStats != null)
                        ActivityChart(
                          weeklyData: controller.dailyStats!.weeklyCalories,
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
                      FitnessProgramsSection(programs: controller.fitnessPrograms),

                      const SizedBox(height: 24),

                      // Today's Information Section
                      if (controller.dailyStats != null)
                        TodayInfoSection(dailyStats: controller.dailyStats!),

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
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.settings,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.track_changes,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateNavigation() {
    final days = ['5', '6', '7', 'Today, 8 Jul', '9', '10', '11'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final isToday = days[index] == 'Today, 8 Jul';
          return Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 16 : 8,
              right: index == days.length - 1 ? 16 : 0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isToday ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                days[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isToday ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
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
