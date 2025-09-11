import 'package:brightness_mobile/features/pricing/presentation/pages/pricing_page.dart';
import 'package:brightness_mobile/features/yours/data/models/yours.dart';
import 'package:flutter/material.dart';
import '../widgets/diet_plan_card.dart';
import 'event_tracking_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class YoursPageContent extends StatelessWidget {
  const YoursPageContent({Key? key}) : super(key: key);

  static const List<DietPlanModel> dietPlans = [
    DietPlanModel(
      id: '1',
      title: 'HEALTHY DIET',
      progress: 0.45,
    ),
    DietPlanModel(
      id: '2',
      title: 'MORNING YOGA',
      progress: 0.65,
    ),
    DietPlanModel(
      id: '3',
      title: 'CARDIO BLAST',
      progress: 0.20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.customGradient,
      ),
      child: SafeArea(
        child: Column(
          children: [
            buildHeader(context), // Pass context to header
            Expanded(
              key: const Key('diet_plans_expanded'),
              child: buildDietPlansList(context),
            ),
            buildPricingButton(context), // Add pricing button at bottom
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacingL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Yours',
            style: AppTextStyles.h1.copyWith(fontSize: 36),
          ),
          // Alternative: Add pricing button in header
          IconButton(
            onPressed: () => navigateToPricing(context),
            icon: Icon(
              Icons.attach_money,
              color: AppColors.white,
              size: AppTheme.iconSizeL,
            ),
            tooltip: 'View Pricing',
          ),
        ],
      ),
    );
  }

  Widget buildDietPlansList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
      child: ListView.builder(
        itemCount: dietPlans.length,
        itemBuilder: (context, index) {
          return DietPlanCard(
            dietPlan: dietPlans[index],
            onTap: () => navigateToEventTracking(context, dietPlans[index]),
          );
        },
      ),
    );
  }

  Widget buildPricingButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.spacingL),
      child: SizedBox(
        width: double.infinity,
        height: AppTheme.buttonHeightL,
        child: ElevatedButton(
          onPressed: () => navigateToPricing(context),
          style: AppTheme.primaryButtonStyle(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.customGradientStart,
          ).copyWith(
            elevation: WidgetStateProperty.all(AppTheme.elevationM),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.buttonHeightL / 2),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: AppTheme.iconSizeM),
              SizedBox(width: AppTheme.spacingS),
              Text(
                'View Pricing Plans',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.customGradientStart,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToEventTracking(BuildContext context, DietPlanModel dietPlan) {
    print('Navigating to event tracking for: ${dietPlan.title}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventTrackingPage(dietPlan: dietPlan),
        settings: RouteSettings(name: '/event-tracking/${dietPlan.id}'),
      ),
    );
  }

  void navigateToPricing(BuildContext context) {
    Navigator.pushNamed(context, '/pricing');
  }
}