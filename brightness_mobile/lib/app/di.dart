import 'package:brightness_mobile/core/services/shared_prefs_token_storage.dart';
import 'package:brightness_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/register_controller.dart';
import 'package:get_it/get_it.dart';

// Core
import '../core/config/app_config.dart';
import '../core/network/dio_client.dart';
import '../core/services/token_storage.dart';

// Auth feature
import '../features/auth/data/sources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/google_sign_in_usecase.dart';
import '../features/auth/domain/usecases/facebook_sign_in_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import '../features/auth/presentation/controllers/login_controller.dart';
import 'package:brightness_mobile/features/onboarding/di.dart';
import 'package:brightness_mobile/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:brightness_mobile/features/home/data/datasources/fitness_data_datasource.dart';
import 'package:brightness_mobile/features/home/presentation/controllers/home_controller.dart';
import 'package:brightness_mobile/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:brightness_mobile/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:brightness_mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:brightness_mobile/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:brightness_mobile/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:brightness_mobile/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/video_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/navigation_controller.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<AppConfig>(
    () => AppConfig.fromEnvironment(),
  );

  // Token storage + Dio client (for new API flows)
  final tokenStorage = await SharedPrefsTokenStorage.create();
  sl.registerSingleton<TokenStorage>(tokenStorage);

  sl.registerLazySingleton<DioClient>(
      () => DioClient(config: sl(), tokenStorage: sl()));

  // Auth feature
  await _initAuth();
}

Future<void> _initAuth() async {
  // Controllers (Presentation Layer)
  sl.registerFactory<LoginController>(
    () => LoginController(
      loginUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // Use Cases (Domain Layer)
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GoogleSignInUseCase>(
    () => GoogleSignInUseCase(repository: sl()),
  );

  sl.registerLazySingleton<FacebookSignInUseCase>(
    () => FacebookSignInUseCase(repository: sl()),
  );

  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(repository: sl()),
  );

  // Repository (Domain Layer)
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));

  // Controller
  sl.registerFactory(() => RegisterController(registerUseCase: sl()));

  // Features: Onboarding
  initOnboardingFeature(sl);
  sl.registerFactory<OnboardingController>(() => OnboardingController(sl()));

  // Features: Home
  sl.registerLazySingleton<FitnessDataDatasource>(
      () => FitnessDataDatasource());
  sl.registerFactory<HomeController>(() => HomeController(sl()));
  // Features: Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      dioClient: sl(),
      tokenStorage: sl(),
      config: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory<GetProfileUsecase>(() => GetProfileUsecase(sl()));
  sl.registerFactory<UpdateProfileUsecase>(() => UpdateProfileUsecase(sl()));
  sl.registerFactory<UploadProfileImageUsecase>(
      () => UploadProfileImageUsecase(sl()));
  sl.registerFactory<EditProfileController>(
      () => createEditProfileController());

  // Video and Navigation Controllers
  sl.registerFactory<VideoController>(() => VideoController());
  sl.registerFactory<NavigationController>(() => NavigationController());

  // Data Sources (Data Layer)
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      dioClient: sl(),
      tokenStorage: sl(),
    ),
  );
}
