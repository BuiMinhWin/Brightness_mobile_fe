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
          Positioned.fill(
            child: Image.asset('assets/images/home_bg.png', fit: BoxFit.cover),
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
                          const SizedBox(height: 20),

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
                                          0.75; // Giảm một chút để tai không bị cắt

                                      return FoxMascotBox(
                                        size: foxSize,
                                        right: 0,
                                        bottom: 0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Calendar navigation
                          _buildDateNavigation(),

                          const SizedBox(height: 20),

                          // Stats Overview (Calories, Distance, Steps, Points)
                          if (controller.dailyStats != null)
                            StatsOverview(
                              dailyStats: controller.dailyStats!,
                              opacity: 0,
                            ),

                          const SizedBox(height: 20),

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
