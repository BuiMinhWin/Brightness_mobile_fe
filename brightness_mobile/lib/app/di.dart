import 'package:get_it/get_it.dart';

import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/core/network/dio_client.dart';
import 'package:brightness_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:brightness_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:brightness_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:brightness_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';
import 'package:brightness_mobile/features/onboarding/di.dart';
import 'package:brightness_mobile/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:brightness_mobile/features/home/data/datasources/fitness_data_datasource.dart';
import 'package:brightness_mobile/features/home/presentation/controllers/home_controller.dart';

final sl = GetIt.instance;

Future<void> initServices(AppConfig config) async {
  // Core
  sl.registerLazySingleton<AppConfig>(() => config);
  sl.registerLazySingleton<DioClient>(() => DioClient(config: sl()));

  // Features: Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<DioClient>().dio, baseUrl: config.authBaseUrl),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl()),
  );
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerFactory<LoginController>(() => LoginController(login: sl()));

  // Features: Onboarding
  initOnboardingFeature(sl);
  sl.registerFactory<OnboardingController>(() => OnboardingController(sl()));

  // Features: Home
  sl.registerLazySingleton<FitnessDataDatasource>(() => FitnessDataDatasource());
  sl.registerFactory<HomeController>(() => HomeController(sl()));

  // TODO: Register other feature services (user, catalog, order, payment)
}
