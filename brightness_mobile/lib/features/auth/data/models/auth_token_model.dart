
import 'dart:convert';
import '../../domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresAt,
    super.tokenType,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['access_token'] ?? json['accessToken'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refreshToken'] ?? '',
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : json['expiresAt'] != null
              ? DateTime.parse(json['expiresAt'])
              : DateTime.now().add(const Duration(hours: 1)),
      tokenType: json['token_type'] ?? json['tokenType'] ?? 'Bearer',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.toIso8601String(),
      'token_type': tokenType,
    };
  }

  factory AuthTokenModel.fromEntity(AuthToken token) {
    return AuthTokenModel(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
      expiresAt: token.expiresAt,
      tokenType: token.tokenType,
    );
  }
}