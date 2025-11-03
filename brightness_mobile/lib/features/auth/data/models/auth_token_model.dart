import '../../domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresAt,
    super.refreshTokenExpiresAt,
    super.tokenType,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    final accessExpiresAt = _parseDate(
          json['expires_at'] ??
              json['expiresAt'] ??
              json['access_token_expires_at'] ??
              json['accessTokenExpiresAt'],
        ) ??
        DateTime.now().add(const Duration(hours: 1));
    final refreshExpiresAt = _parseDate(
      json['refresh_token_expires_at'] ?? json['refreshTokenExpiresAt'],
    );

    return AuthTokenModel(
      accessToken: json['access_token'] ?? json['accessToken'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refreshToken'] ?? '',
      expiresAt: accessExpiresAt,
      refreshTokenExpiresAt: refreshExpiresAt,
      tokenType: json['token_type'] ?? json['tokenType'] ?? 'Bearer',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.toIso8601String(),
      if (refreshTokenExpiresAt != null)
        'refresh_token_expires_at': refreshTokenExpiresAt!.toIso8601String(),
      'token_type': tokenType,
    };
  }

  factory AuthTokenModel.fromEntity(AuthToken token) {
    return AuthTokenModel(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
      expiresAt: token.expiresAt,
      refreshTokenExpiresAt: token.refreshTokenExpiresAt,
      tokenType: token.tokenType,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
