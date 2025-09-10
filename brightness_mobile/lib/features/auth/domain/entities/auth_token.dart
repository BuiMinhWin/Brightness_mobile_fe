
class AuthToken {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String tokenType;

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.tokenType = 'Bearer',
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthToken &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken &&
          expiresAt == other.expiresAt &&
          tokenType == other.tokenType;

  @override
  int get hashCode =>
      accessToken.hashCode ^
      refreshToken.hashCode ^
      expiresAt.hashCode ^
      tokenType.hashCode;
}

