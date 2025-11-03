import 'package:dio/dio.dart';

import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/token_storage.dart';
import '../../../../core/utils/jwt_utils.dart';

abstract class AuthRemoteDataSource {
  Future<bool> isUserLoggedIn();
  Future<AuthTokenModel> login({
    required String emailOrUsername,
    required String password,
  });

  Future<AuthTokenModel> loginWithGoogle();
  Future<AuthTokenModel> loginWithFacebook();
  Future<void> logout();
  Future<AuthTokenModel> refreshToken({required String refreshToken});
  Future<UserModel> getCurrentUser();
  Future<void> forgotPassword({required String email});
  Future<void> resetPassword(
      {required String token, required String newPassword});
  Future<void> register({
    required String email,
    required String password,
    String? username,
    String? fullName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? profilePicture,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final TokenStorage tokenStorage;
  final Dio _authDio;

  AuthRemoteDataSourceImpl({
    required DioClient dioClient,
    required this.tokenStorage,
  }) : _authDio = dioClient.forAuthService();

  @override
  Future<bool> isUserLoggedIn() async {
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null && !JwtUtils.isTokenExpired(accessToken)) {
      return true;
    }

    final refreshTokenValue = await tokenStorage.getRefreshToken();
    if (refreshTokenValue != null) {
      try {
        await refreshToken(refreshToken: refreshTokenValue);
        return true;
      } catch (e) {
        await _clearTokens();
        return false;
      }
    }

    return false;
  }

  @override
  Future<AuthTokenModel> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      final response = await _authDio.post(
        '/Authentication/login',
        data: {
          'email': emailOrUsername,
          'email_or_username': emailOrUsername,
          'password': password,
        },
      );

      final body = _asMap(response.data);
      if (response.statusCode == 200) {
        final payload = _asMap(body['data'] ?? body);
        final token = AuthTokenModel.fromJson(payload);
        await _persistTokens(token);
        return token;
      }

      final message = body['message'] ?? 'Login failed';
      if (response.statusCode == 401) {
        throw AuthException(message: message, statusCode: response.statusCode);
      }
      throw ServerException(message: message, statusCode: response.statusCode);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<AuthTokenModel> loginWithGoogle() {
    throw const ServerException(
      message: 'Google sign-in is not available yet.',
      statusCode: 501,
    );
  }

  @override
  Future<AuthTokenModel> loginWithFacebook() {
    throw const ServerException(
      message: 'Facebook sign-in is not available yet.',
      statusCode: 501,
    );
  }

  @override
  Future<void> logout() async {
    final refresh = await tokenStorage.getRefreshToken();
    try {
      await _authDio.post(
        '/Authentication/revoke',
        data: refresh != null && refresh.isNotEmpty
            ? {'refreshToken': refresh}
            : null,
      );
    } on DioException catch (e) {
      _handleDioError(e, swallowAuthErrors: true);
    } finally {
      await _clearTokens();
    }
  }

  @override
  Future<AuthTokenModel> refreshToken({required String refreshToken}) async {
    try {
      final response = await _authDio.post(
        '/Authentication/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      final body = _asMap(response.data);
      if (response.statusCode == 200) {
        final payload = _asMap(body['data'] ?? body);
        final token = AuthTokenModel.fromJson(payload);
        await _persistTokens(token);
        return token;
      }

      final message = body['message'] ?? 'Token refresh failed';
      throw ServerException(message: message, statusCode: response.statusCode);
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      throw const AuthException(message: 'Access token is missing');
    }

    final userId = JwtUtils.extractUserId(accessToken);
    if (userId == null) {
      throw const AuthException(message: 'Cannot extract user id from token');
    }

    try {
      final response = await _authDio.get('/Authentication/$userId');
      if (response.statusCode == 200) {
        final payload = _asMap(response.data);
        return UserModel.fromJson(payload);
      }

      if (response.statusCode == 404) {
        throw ServerException(message: 'User not found', statusCode: 404);
      }

      final body = _asMap(response.data);
      throw ServerException(
        message: body['message'] ?? 'Failed to fetch user profile',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) {
    throw const ServerException(
      message: 'Password recovery is not available yet.',
      statusCode: 501,
    );
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) {
    throw const ServerException(
      message: 'Password recovery is not available yet.',
      statusCode: 501,
    );
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    String? username,
    String? fullName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? profilePicture,
  }) async {
    try {
      final response = await _authDio.post(
        '/Authentication/register',
        data: {
          'email': email,
          'password': password,
          'userName': username,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth?.toIso8601String(),
          'gender': gender,
          'profilePicture': profilePicture,
        },
      );

      final body = _asMap(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final flag = body['flag'] ?? body['success'];
        if (flag is bool && !flag) {
          throw ServerException(
            message: body['message'] ?? 'Registration failed',
            statusCode: response.statusCode,
          );
        }
        return;
      }

      throw ServerException(
        message: body['message'] ?? 'Registration failed',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  // ------------------------------------------------------------------------
  // Helpers
  Future<void> _persistTokens(AuthTokenModel token) async {
    await tokenStorage.setAccessToken(token.accessToken);
    await tokenStorage.setRefreshToken(token.refreshToken);
  }

  Future<void> _clearTokens() async {
    await tokenStorage.setAccessToken(null);
    await tokenStorage.setRefreshToken(null);
  }

  Never _handleDioError(
    DioException error, {
    bool swallowAuthErrors = false,
  }) {
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.badCertificate) {
      throw const NetworkException(
        message: 'Unable to reach the server. Please check your connection.',
      );
    }

    final status = error.response?.statusCode;
    final body = _asMap(error.response?.data);
    final message =
        body['message'] ?? error.message ?? 'Unexpected server error.';

    if (!swallowAuthErrors && status == 401) {
      throw AuthException(message: message, statusCode: status);
    }

    throw ServerException(message: message, statusCode: status);
  }

  Map<String, dynamic> _asMap(dynamic source) {
    if (source is Map<String, dynamic>) {
      return source;
    }
    if (source is Map) {
      return Map<String, dynamic>.from(source);
    }
    return {};
  }
}
