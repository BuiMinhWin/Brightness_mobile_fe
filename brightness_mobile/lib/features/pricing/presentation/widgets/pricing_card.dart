import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class PricingCardWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int? price;
  final List<String> features;
  final String buttonText;
  final Color? buttonColor;
  final VoidCallback? onPressed;
  final bool isPopular;

  const PricingCardWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.price,
    required this.features,
    required this.buttonText,
    this.buttonColor,
    this.onPressed,
    this.isPopular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: isPopular 
            ? Border.all(color: AppColors.primary, width: 2)
            : Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppTheme.textPrimary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: -1,
              left: 20,
              right: 20,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppTheme.radiusM),
                    bottomRight: Radius.circular(AppTheme.radiusM),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Most Popular',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white,
                      fontWeight: AppTheme.fontWeightSemiBold,
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(isPopular ? 28 : AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                if (price == null)
                  Text(
                    title,
                    style: AppTextStyles.h1.copyWith(
                      color: AppTheme.textPrimary,
                      fontSize: AppTheme.fontSizeTitle,
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: AppTheme.textStyleHeadline1.copyWith(
                          fontSize: AppTheme.fontSizeXXL + 8,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: AppTextStyles.body1.copyWith(
                            color: AppTheme.textSecondary,
                            fontWeight: AppTheme.fontWeightMedium,
                          ),
                        ),
                    ],
                  ),
                
                const SizedBox(height: AppTheme.spacingL),
                
                // Features List
                ...features.map((feature) => _buildFeatureItem(feature)),
                
                const SizedBox(height: AppTheme.spacingL),
                
                // Action Button
                SizedBox(
                  width: double.infinity,
                  height: AppTheme.buttonHeightM + 2,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: AppTheme.primaryButtonStyle(
                      backgroundColor: buttonColor ?? AppColors.secondary,
                    ).copyWith(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: AppTheme.spacingS + 4),
          Expanded(
            child: Text(
              feature,
              style: AppTextStyles.body1.copyWith(
                color: AppTheme.textSecondary,
                fontSize: AppTheme.fontSizeS + 1,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}