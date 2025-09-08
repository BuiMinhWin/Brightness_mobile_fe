import '../entities/onboarding_data.dart';

abstract class OnboardingRepository {
  Future<void> saveOnboardingData(OnboardingData data);
}