import 'dart:convert';

/// Utility helpers for working with JWT access tokens.
class JwtUtils {
  const JwtUtils._();

  static bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final normalized = base64Url.normalize(parts[1]);
      final payload = json.decode(utf8.decode(base64Url.decode(normalized)));

      if (payload is Map<String, dynamic>) {
        final expiry = payload['exp'];
        if (expiry is int) {
          final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
          return DateTime.now().isAfter(expiryDate);
        }
      }
      return true; // Assume expired if no valid expiry claim is found
    } catch (_) {
      return true;
    }
  }

  /// Extracts the subject/user id from a JWT access token.
  ///
  /// This looks for a number of common claim keys such as `nameid`, `sub`, or `id`.
  /// Returns `null` when no identifier can be parsed.
  static String? extractUserId(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final normalized = base64Url.normalize(parts[1]);
      final payload = json.decode(utf8.decode(base64Url.decode(normalized)));

      if (payload is Map<String, dynamic>) {
        const candidates = ['nameid', 'sub', 'id', 'Id', 'uid'];
        for (final key in candidates) {
          final value = payload[key];
          if (value is String && value.isNotEmpty) {
            return value;
          }
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
