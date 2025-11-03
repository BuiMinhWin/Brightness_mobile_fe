import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/token_storage.dart';
import '../../../../core/utils/jwt_utils.dart';
import '../../../../shared/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> fetchProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<String> uploadProfileImage(File imageFile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({
    required DioClient dioClient,
    required TokenStorage tokenStorage,
    required AppConfig config,
  })  : _dio = dioClient.forAuthService(),
        _tokenStorage = tokenStorage,
        _config = config;

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final AppConfig _config;

  @override
  Future<ProfileModel> fetchProfile() async {
    final userId = await _resolveUserId();

    try {
      final response = await _dio.get('/Authentication/$userId');
      if (response.statusCode == 200) {
        final body = _asMap(response.data);
        if (body.isEmpty) {
          throw const ServerException(
            message: 'Empty profile response',
            statusCode: 500,
          );
        }
        return _mapToProfile(body);
      }

      throw ServerException(
        message: 'Failed to load profile',
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    final userId = await _resolveUserId();
    final payload = _buildUpdatePayload(profile);

    try {
      final response = await _dio.put(
        '/Authentication/$userId',
        data: payload,
      );

      if (response.statusCode == 200) {
        // Authentication service returns only a Response envelope.
        // Fetch the latest profile snapshot to keep client state correct.
        return fetchProfile();
      }

      final body = _asMap(response.data);
      throw ServerException(
        message: body['message'] ?? 'Failed to update profile',
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    throw const ServerException(
      message: 'Profile image upload is not available yet.',
      statusCode: 501,
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  Future<String> _resolveUserId() async {
    final accessToken = await _tokenStorage.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      throw const AuthException(message: 'Missing access token');
    }

    final userId = JwtUtils.extractUserId(accessToken);
    if (userId == null || userId.isEmpty) {
      throw const AuthException(message: 'Unable to determine current user');
    }

    return userId;
  }

  Map<String, dynamic> _buildUpdatePayload(ProfileModel profile) {
    final payload = <String, dynamic>{};

    String? combineName() {
      final first = profile.firstName?.trim();
      final last = profile.lastName?.trim();

      if ((first == null || first.isEmpty) && (last == null || last.isEmpty)) {
        return null;
      }

      if (first == null || first.isEmpty) return last;
      if (last == null || last.isEmpty) return first;
      return '$first $last';
    }

    void addIfNotEmpty(String key, String? value) {
      if (value != null && value.trim().isNotEmpty) {
        payload[key] = value.trim();
      }
    }

    addIfNotEmpty('email', profile.email);
    addIfNotEmpty('fullName', combineName());
    addIfNotEmpty('phoneNumber', profile.phoneNumber);
    addIfNotEmpty('gender', profile.gender);
    addIfNotEmpty('profilePicture', profile.profileImageUrl);
    addIfNotEmpty('dateOfBirth', profile.dateOfBirth);

    if (!payload.containsKey('fullName')) {
      addIfNotEmpty('userName', profile.email);
    }

    return payload;
  }

  ProfileModel _mapToProfile(Map<String, dynamic> json) {
    final rawFullName = _readString(json, 'fullName');
    final rawUserName = _readString(json, 'userName') ??
        _readString(json, 'user_name') ??
        _readString(json, 'username');
    final email = _readString(json, 'email');

    final split = _splitName(rawFullName ?? rawUserName ?? '');
    final firstName = split.$1;
    final lastName = split.$2;

    final createdAt = _parseDateTime(
      _readString(json, 'createdAt') ?? _readString(json, 'created_at'),
    );
    final updatedAt = _parseDateTime(
      _readString(json, 'updatedAt') ?? _readString(json, 'updated_at'),
    );

    final dateOfBirth =
        _readString(json, 'dateOfBirth') ?? _readString(json, 'date_of_birth');

    return ProfileModel(
      id: json['id']?.toString(),
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber:
          _readString(json, 'phoneNumber') ?? _readString(json, 'phone_number'),
      dateOfBirth: dateOfBirth,
      gender: _readString(json, 'gender'),
      profileImageUrl: _resolveAvatarUrl(_readString(json, 'profilePicture')),
      bio: null,
      location: null,
      website: null,
      occupation: null,
      company: null,
      interests: const [],
      preferences: const {},
      createdAt: createdAt,
      updatedAt: updatedAt ?? createdAt,
    );
  }

  List<String> _buildNameParts(String value) =>
      value.split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();

  (String?, String?) _splitName(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return (null, null);

    final parts = _buildNameParts(trimmed);
    if (parts.isEmpty) return (null, null);
    if (parts.length == 1) return (parts.first, null);
    final first = parts.first;
    final last = parts.sublist(1).join(' ');
    return (first, last);
  }

  String? _resolveAvatarUrl(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    if (trimmed.startsWith('http')) return trimmed;
    final path = trimmed.startsWith('/') ? trimmed : '/$trimmed';
    return '${_config.gatewayBaseUrl}$path';
  }

  String? _readString(Map<String, dynamic> source, String key) {
    final value = source[key];
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  DateTime? _parseDateTime(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return {};
  }

  Never _handleDioError(DioException error) {
    if (_isNetworkIssue(error.type)) {
      throw const NetworkException(
        message: 'Unable to reach the server. Please check your connection.',
      );
    }

    final status = error.response?.statusCode;
    final body = _asMap(error.response?.data);
    final message =
        body['message'] ?? error.message ?? 'Unexpected server error.';

    if (status == 401) {
      throw AuthException(message: message, statusCode: status);
    }

    throw ServerException(message: message, statusCode: status);
  }

  bool _isNetworkIssue(DioExceptionType type) {
    return type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.badCertificate;
  }
}
