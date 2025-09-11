
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/config/app_config.dart';

abstract class AuthRemoteDataSource {
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
  Future<void> resetPassword({required String token, required String newPassword});
  Future<UserModel> register({
    required String email,
    required String password,
    String? username,
    String? fullName,
    String? phoneNumber, DateTime? dateOfBirth, String? gender, String? profilePicture, 
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final AppConfig config;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.config,
  });

  @override
  Future<AuthTokenModel> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email_or_username': emailOrUsername,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthTokenModel.fromJson(data['data'] ?? data);
      } else if (response.statusCode == 401) {
        throw AuthException(
          message: 'Invalid credentials',
          statusCode: response.statusCode,
        );
      } else {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is AuthException || e is ServerException) {
        rethrow;
      }
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<AuthTokenModel> loginWithGoogle() async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/google'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthTokenModel.fromJson(data['data'] ?? data);
      } else {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Google sign in failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<AuthTokenModel> loginWithFacebook() async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/facebook'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthTokenModel.fromJson(data['data'] ?? data);
      } else {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Facebook sign in failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Logout failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<AuthTokenModel> refreshToken({required String refreshToken}) async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/refresh'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'refresh_token': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AuthTokenModel.fromJson(data['data'] ?? data);
      } else {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Token refresh failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await client.get(
        Uri.parse('${config.userBaseUrl}/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data['data'] ?? data);
      } else {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Failed to get user',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/forgot-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode != 200) {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Failed to send reset email',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('${config.authBaseUrl}/auth/reset-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'token': token,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        final errorData = json.decode(response.body);
        throw ServerException(
          message: errorData['message'] ?? 'Failed to reset password',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException(message: 'Network error occurred');
    }
  }


// Update the interface to match your database fields
@override
Future<UserModel> register({
  DateTime? dateOfBirth,
  required String email,
  String? fullName,
  String? gender,
  required String password,
  String? phoneNumber,
  String? profilePicture,
  String? username,
}) async {
  try {
    final response = await client.post(
      Uri.parse('${config.authBaseUrl}/auth/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
        'username': username,
        'full_name': fullName,
        'phone_number': phoneNumber,
        'date_of_birth': dateOfBirth?.toIso8601String(),
        'gender': gender,
        'profile_picture': profilePicture,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['data'] ?? data);
    } else {
      final errorData = json.decode(response.body);
      throw ServerException(
        message: errorData['message'] ?? 'Registration failed',
        statusCode: response.statusCode,
      );
    }
  } catch (e) {
    if (e is ServerException) rethrow;
    throw NetworkException(message: 'Network error occurred');
  }
}
}