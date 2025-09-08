// import 'package:get_it/get_it.dart';

// import 'package:brightness_mobile/core/config/app_config.dart';
// import 'package:brightness_mobile/core/network/dio_client.dart';
// import 'package:brightness_mobile/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:brightness_mobile/features/auth/data/sources/auth_remote_data_source.dart';
// import 'package:brightness_mobile/features/auth/domain/repositories/auth_repository.dart';
// import 'package:brightness_mobile/features/auth/domain/usecases/login_usecase.dart';
// import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';

// final sl = GetIt.instance;

// Future<void> initServices(AppConfig config) async {
//   // Core
//   sl.registerLazySingleton<AppConfig>(() => config);
//   sl.registerLazySingleton<DioClient>(() => DioClient(config: sl()));

//   // Features: Auth
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(client: sl<DioClient>().dio, baseUrl: config.authBaseUrl),
//   );
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(remote: sl()),
//   );
//   sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl()));
//   sl.registerFactory<LoginController>(() => LoginController(login: sl()));

//   // TODO: Register other feature services (user, catalog, order, payment)
// }
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

  // Data Sources (Data Layer)
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl(),
      config: sl(),
    ),
  );
}
