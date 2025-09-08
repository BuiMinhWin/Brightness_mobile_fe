import '../../domain/entities/onboarding_data.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveOnboardingData(OnboardingData data);
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  Future<void> saveOnboardingData(OnboardingData data) async {
    // Here you would typically save the data to a local database or shared preferences.
    // For this example, we'll just simulate a delay.
    await Future.delayed(const Duration(seconds: 1));
  }
}
