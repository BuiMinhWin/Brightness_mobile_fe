import 'package:brightness_mobile/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:brightness_mobile/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:brightness_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveOnboardingData(OnboardingData data) {
    return localDataSource.saveOnboardingData(data);
  }
}
