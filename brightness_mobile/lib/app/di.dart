
import 'package:brightness_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/register_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Core
import '../core/config/app_config.dart';

// Auth feature
import '../features/auth/data/sources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/google_sign_in_usecase.dart';
import '../features/auth/domain/usecases/facebook_sign_in_usecase.dart';
import '../features/auth/domain/usecases/logout_usecase.dart';
import '../features/auth/presentation/controllers/login_controller.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<AppConfig>(
    () => AppConfig.fromEnvironment(),
  );

  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  // Auth feature
  await _initAuth();
}

Future<void> _initAuth() async {
  // Controllers (Presentation Layer)
  sl.registerFactory<LoginController>(
    () => LoginController(loginUseCase: sl()),
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

  // Data Sources (Data Layer)
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl(),
      config: sl(),
    ),
  );
}
