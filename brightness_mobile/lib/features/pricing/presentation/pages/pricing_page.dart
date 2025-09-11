import 'package:brightness_mobile/core/navigation/main_navigation_controller.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.customGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom app bar with gradient background
              Padding(
                padding: EdgeInsets.all(AppTheme.spacingM),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MainNavigationController(),
                          ),
                          (route) => false,
                        );
                      }
                    ),
                    Expanded(
                      child: Text(
                        'Pricing',
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),
              
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                  child: Column(
                    children: [
                      SizedBox(height: AppTheme.spacingL),
                      
                      // Free Plan Card
                      _buildPlanCard(
                        context: context,
                        title: 'Free',
                        price: null,
                        isCurrentPlan: true,
                        features: [
                          'First aid for gym accident, emergency info',
                          'Gamification',
                          'Community blog access',
                          'Chatbot AI (Limited)',
                        ],
                        buttonText: 'Your Current Plan',
                        buttonColor: AppColors.loseWeightColor,
                        onPressed: null, // Disabled since it's current plan
                      ),
                      
                      SizedBox(height: AppTheme.spacingL),
                      
                      // Premium Plan 1
                      _buildPlanCard(
                        context: context,
                        title: '79.000',
                        subtitle: '/month',
                        price: 79000,
                        isCurrentPlan: false,
                        features: [
                          'AI workout personalization (73.8% demand)',
                          'Full tracking & exclusive programs',
                          'Enhanced chatbot, no ads',
                          'Expert content access',
                          'Included all feature from free tier',
                          'Long-term savings',
                        ],
                        buttonText: 'Order Now',
                        buttonColor: AppColors.loseWeightColor,
                        onPressed: () => _handlePurchase(context, 'premium1'),
                      ),
                      
                      SizedBox(height: AppTheme.spacingL),
                      
                      // Premium Plan 2
                      _buildPlanCard(
                        context: context,
                        title: '599.000',
                        subtitle: '/month',
                        price: 599000,
                        isCurrentPlan: false,
                        features: [
                          'AI workout personalization (73.8% demand)',
                          'Full tracking & exclusive programs',
                          'Enhanced chatbot, no ads',
                          'Expert content access',
                          'Included all feature from free tier',
                          'Long-term savings',
                        ],
                        buttonText: 'Order Now',
                        buttonColor: AppColors.loseWeightColor,
                        onPressed: () => _handlePurchase(context, 'premium2'),
                      ),
                      
                      SizedBox(height: AppTheme.spacingXXL),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required String title,
    String? subtitle,
    int? price,
    required bool isCurrentPlan,
    required List<String> features,
    required String buttonText,
    required Color buttonColor,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Price
          if (price == null)
            Text(
              title,
              style: AppTextStyles.h1.copyWith(
                color: AppColors.textPrimary,
                fontSize: AppTheme.fontSizeTitle,
              ),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: AppTextStyles.body2.copyWith(
                      fontSize: AppTheme.fontSizeM,
                      fontWeight: AppTheme.fontWeightMedium,
                    ),
                  ),
              ],
            ),
          
          SizedBox(height: AppTheme.spacingL),
          
          // Features List
          ...features.map((feature) => _buildFeatureItem(feature)),
          
          SizedBox(height: AppTheme.spacingL),
          
          // Action Button
          SizedBox(
            width: double.infinity,
            height: AppTheme.buttonHeightM,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                disabledBackgroundColor: buttonColor.withOpacity(0.7),
              ),
              child: Text(
                buttonText,
                style: AppTextStyles.button.copyWith(
                  fontSize: AppTheme.fontSizeM,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: AppColors.white,
              size: 12,
            ),
          ),
          SizedBox(width: AppTheme.spacingS + 4),
          Expanded(
            child: Text(
              feature,
              style: AppTextStyles.body1.copyWith(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePurchase(BuildContext context, String planType) {
    // Show purchase dialog or navigate to payment
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          title: Text(
            'Purchase Plan',
            style: AppTextStyles.h2,
          ),
          content: Text(
            'You selected the $planType plan. This would normally integrate with your payment system.',
            style: AppTextStyles.body1,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Payment integration would be implemented here',
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    backgroundColor: AppColors.customGradientStart,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.customGradientStart,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
              ),
              child: Text(
                'Proceed',
                style: AppTextStyles.button.copyWith(
                  fontSize: AppTheme.fontSizeS,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}