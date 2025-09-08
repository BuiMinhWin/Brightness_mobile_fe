import 'package:brightness_mobile/core/usecase/usecase.dart';
import 'package:brightness_mobile/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:brightness_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

class SaveOnboardingData implements UseCase<void, OnboardingData> {
  final OnboardingRepository repository;

  SaveOnboardingData(this.repository);

  @override
  Future<void> call(OnboardingData params) {
    return repository.saveOnboardingData(params);
  }
}
