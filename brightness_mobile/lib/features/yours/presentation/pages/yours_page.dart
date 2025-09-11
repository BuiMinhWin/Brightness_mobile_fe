import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_navbar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class YoursPage extends StatefulWidget {
  const YoursPage({super.key});

  @override
  State<YoursPage> createState() => _YoursPageState();
}

class _YoursPageState extends State<YoursPage> {
  int _currentNavIndex = 2; // Yours tab is active

  final List<DietPlan> _dietPlans = [
    DietPlan(id: '1', progress: 0.45),
    DietPlan(id: '2', progress: 0.65),
    DietPlan(id: '3', progress: 0.20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.customGradientVertical, // ✅ dùng gradient system
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Yours',
              style: AppTextStyles.h1, // ✅ dùng style system
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
      child: ListView.builder(
        itemCount: _dietPlans.length,
        itemBuilder: (context, index) {
          return _buildDietCard(_dietPlans[index]);
        },
      ),
    );
  }

  Widget _buildDietCard(DietPlan dietPlan) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration(), // ✅ dùng card style
      child: InkWell(
        onTap: () => _onDietCardTap(dietPlan),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Row(
          children: [
            // Diet Icon
            Container(
              width: AppTheme.iconSizeXL,
              height: AppTheme.iconSizeXL,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: AppColors.success,
                size: AppTheme.iconSizeM,
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HEALTHY DIET',
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: dietPlan.progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingS),
                      Text(
                        '${(dietPlan.progress * 100).round()}%',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            // Arrow Icon
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: AppTheme.iconSizeM,
            ),
          ],
        ),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    // Handle navigation to different pages
    switch (index) {
      case 0:
        // Navigate to Home
        break;
      case 1:
        // Navigate to Event
        break;
      case 2:
        // Already on Yours page
        break;
      case 3:
        // Navigate to Video
        break;
      case 4:
        // Navigate to Leaderboard
        break;
    }
  }

  void _onDietCardTap(DietPlan dietPlan) {
    debugPrint('Tapped on diet plan: ${dietPlan.id}');
  }
}

// Data Model
class DietPlan {
  final String id;
  final double progress; // 0.0 to 1.0

  const DietPlan({
    required this.id,
    required this.progress,
  });
}
