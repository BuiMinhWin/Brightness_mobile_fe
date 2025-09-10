import 'package:get_it/get_it.dart';

import 'package:brightness_mobile/core/config/app_config.dart';
import 'package:brightness_mobile/core/network/dio_client.dart';
import 'package:brightness_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:brightness_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:brightness_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:brightness_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:brightness_mobile/features/auth/presentation/controllers/login_controller.dart';
import 'package:brightness_mobile/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:brightness_mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:brightness_mobile/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:brightness_mobile/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:brightness_mobile/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/video_controller.dart';
import 'package:brightness_mobile/features/profile/presentation/controllers/navigation_controller.dart';

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

  // Features: Profile
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  sl.registerFactory<GetProfileUsecase>(() => GetProfileUsecase(sl()));
  sl.registerFactory<UpdateProfileUsecase>(() => UpdateProfileUsecase(sl()));
  sl.registerFactory<UploadProfileImageUsecase>(() => UploadProfileImageUsecase(sl()));
  sl.registerFactory<EditProfileController>(() => createEditProfileController());
  
  // Video and Navigation Controllers
  sl.registerFactory<VideoController>(() => VideoController());
  sl.registerFactory<NavigationController>(() => NavigationController());

  // TODO: Register other feature services (user, catalog, order, payment)
}
