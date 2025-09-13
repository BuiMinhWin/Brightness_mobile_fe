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
    dio.interceptors.add(SimpleLoggingInterceptor(enabled: config.enableLogging));

    // Auth header
    if (tokenStorage != null) {
      dio.interceptors.add(AuthInterceptor(tokenStorage!));
    }
  }

  // Optionally provide clients pointing to specific service base URLs
  Dio forAuthService() => _withBaseUrl(config.authBaseUrl);
  Dio forUserService() => _withBaseUrl(config.userBaseUrl);
  Dio forCatalogService() => _withBaseUrl(config.catalogBaseUrl);
  Dio forOrderService() => _withBaseUrl(config.orderBaseUrl);
  Dio forPaymentService() => _withBaseUrl(config.paymentBaseUrl);

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
