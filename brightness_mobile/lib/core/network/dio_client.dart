import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../services/token_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  final AppConfig config;
  final TokenStorage? tokenStorage;
  late final Dio dio;

  DioClient({required this.config, this.tokenStorage}) {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Logging (dev/stg only)
    dio.interceptors
        .add(SimpleLoggingInterceptor(enabled: config.enableLogging));

    // Auth header
    if (tokenStorage != null) {
      dio.interceptors.add(AuthInterceptor(tokenStorage!));
    }
  }

  // Optionally provide clients pointing to specific service base URLs
  Dio forAuthService() => _withBaseUrl(config.authBaseUrl);
  Dio forUserService() => _withBaseUrl(config.userBaseUrl);
  Dio forMeasurementService() => _withBaseUrl(config.measurementBaseUrl);
  Dio forChallengeService() => _withBaseUrl(config.challengeBaseUrl);
  Dio forSocialService() => _withBaseUrl(config.socialBaseUrl);
  Dio forBillingService() => _withBaseUrl(config.billingBaseUrl);
  Dio forMediaService() => _withBaseUrl(config.mediaBaseUrl);
  Dio forChatService() => _withBaseUrl(config.chatBaseUrl);
  Dio forPersonalCoachService() => _withBaseUrl(config.personalCoachBaseUrl);
  Dio forAiOcrService() => _withBaseUrl(config.aiOcrBaseUrl);

  // Legacy helpers retained for backwards compatibility
  Dio forCatalogService() => forMeasurementService();
  Dio forOrderService() => forChallengeService();
  Dio forPaymentService() => forBillingService();

  Dio _withBaseUrl(String baseUrl) {
    final newDio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: dio.options.connectTimeout,
      receiveTimeout: dio.options.receiveTimeout,
      sendTimeout: dio.options.sendTimeout,
      headers: Map<String, Object?>.from(dio.options.headers),
    ));
    newDio.interceptors.addAll(dio.interceptors);
    return newDio;
  }
}
