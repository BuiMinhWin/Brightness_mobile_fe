import 'package:dio/dio.dart';

import '../config/app_config.dart';

class DioClient {
  final AppConfig config;
  late final Dio dio;

  DioClient({required this.config}) {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Example: attach shared headers or auth token here
          // options.headers['Authorization'] = 'Bearer <token>';
          handler.next(options);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
  }
}

