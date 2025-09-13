import 'package:dio/dio.dart';

class SimpleLoggingInterceptor extends Interceptor {
  final bool enabled;
  SimpleLoggingInterceptor({this.enabled = false});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      // Keep logs concise; rely on Dio pretty logs if needed
      // ignore: avoid_print
      print('[HTTP] → ${options.method} ${options.uri}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (enabled) {
      // ignore: avoid_print
      print('[HTTP] ← ${response.statusCode} ${response.requestOptions.uri}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {
      // ignore: avoid_print
      print('[HTTP] ⨯ ${err.response?.statusCode ?? '-'} ${err.requestOptions.uri}: ${err.message}');
    }
    handler.next(err);
  }
}

