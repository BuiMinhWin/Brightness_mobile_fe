import 'package:dio/dio.dart';

import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Object error) {
  if (error is Failure) return error;

  if (error is DioException) {
    final res = error.response;
    final status = res?.statusCode ?? 0;
    if (status == 401) return AuthFailure('Unauthorized', cause: error);
    if (status >= 400 && status < 500) {
      return ValidationFailure(res?.data is Map && res?.data['message'] is String
          ? res?.data['message'] as String
          : 'Request invalid');
    }
    if (status >= 500) return ServerFailure('Server error', cause: error);
    return NetworkFailure('Network error', cause: error);
  }

  if (error is AuthException) return AuthFailure(error.message, cause: error);
  if (error is ValidationException) {
    return ValidationFailure(error.message, cause: error);
  }
  if (error is ServerException) return ServerFailure(error.message, cause: error);
  if (error is NetworkException) return NetworkFailure(error.message, cause: error);

  return ServerFailure('Unexpected error', cause: error);
}

