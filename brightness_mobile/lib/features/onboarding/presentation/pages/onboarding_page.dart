import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/basic_info_section.dart';
import '../widgets/fitness_goals_section.dart';
import '../widgets/activity_level_section.dart';
import '../widgets/workout_schedule_section.dart';
import '../widgets/medical_info_section.dart';
import '../widgets/body_measurements_section.dart';
import '../widgets/progress_photo_section.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Consumer<OnboardingController>(
        builder: (context, controller, child) {
          return Container(
            decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildTitle(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  BasicInfoSection(),
                                  SizedBox(height: 24),
                                  FitnessGoalsSection(),
                                  SizedBox(height: 24),
                                  ActivityLevelSection(),
                                  SizedBox(height: 24),
                                  WorkoutScheduleSection(),
                                  SizedBox(height: 24),
                                  MedicalInfoSection(),
                                  SizedBox(height: 24),
                                  BodyMeasurementsSection(),
                                  SizedBox(height: 24),
                                  ProgressPhotoSection(),
                                  SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(13),
                                  blurRadius: 10,
                                  offset: const Offset(0, -5),
                                ),
                              ],
                            ),
                            child: CustomButton(
                              text: "Create My Fitness Plan",
                              isDisabled: !controller.isValid,
                              isLoading: controller.isLoading,
                              backgroundColor: AppColors.primary,
                              onPressed: () async {
                                final success = await controller.saveOnboardingData();
                                if (success && context.mounted) {
                                  Navigator.of(context).pushReplacementNamed('/home');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Profile created successfully!',
                                      ),
                                      backgroundColor: AppColors.primary,
                                    ),
                                  );
                                } else if (controller.error != null && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(controller.error!),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: 24,
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            "Let's Get You Started!",
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "Help us create your perfect fitness plan",
            style: TextStyle(fontSize: 16, color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
