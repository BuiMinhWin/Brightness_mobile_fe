import 'package:brightness_mobile/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:brightness_mobile/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:brightness_mobile/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:brightness_mobile/features/onboarding/domain/usecases/save_onboarding_data.dart';
import 'package:get_it/get_it.dart';

void initOnboardingFeature(GetIt sl) {
  // Usecases
  sl.registerLazySingleton(() => SaveOnboardingData(sl()));

  // Repositories
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );

  // Datasources
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(),
  );
}
