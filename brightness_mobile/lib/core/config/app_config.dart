import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class AppConfig {
  final String flavor;
  final String gatewayBaseUrl;
  final bool enableLogging;

  AppConfig({
    required this.flavor,
    required String gatewayBaseUrl,
    this.enableLogging = false,
  }) : gatewayBaseUrl = _normalizeUrl(gatewayBaseUrl);

  /// Resolve configuration for local development (default flavor).
  factory AppConfig.dev() {
    return AppConfig(
      flavor: 'dev',
      gatewayBaseUrl: _resolveDefaultGateway(),
      enableLogging: true,
    );
  }

  factory AppConfig.staging() {
    const override = String.fromEnvironment(
      'API_GATEWAY_BASE_URL',
      defaultValue: 'https://api-stg.brightness.com',
    );
    return AppConfig(
      flavor: 'stg',
      gatewayBaseUrl: override,
      enableLogging: true,
    );
  }

  factory AppConfig.production() {
    const override = String.fromEnvironment(
      'API_GATEWAY_BASE_URL',
      defaultValue: 'https://api.brightness.com',
    );
    return AppConfig(
      flavor: 'prod',
      gatewayBaseUrl: override,
      enableLogging: false,
    );
  }

  factory AppConfig.fromEnvironment() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (flavor) {
      case 'prod':
        return AppConfig.production();
      case 'stg':
        return AppConfig.staging();
      default:
        return AppConfig.dev();
    }
  }

  /// API Gateway derived service endpoints --------------------------------

  String get authBaseUrl => _serviceBase(
        'auth/api',
        const String.fromEnvironment('API_AUTH_BASE_URL', defaultValue: ''),
      );

  /// Alias for backwards compatibility (user data still lives in Authentication API).
  String get userBaseUrl => _serviceBase(
        'auth/api',
        const String.fromEnvironment('API_USER_BASE_URL', defaultValue: ''),
      );

  String get measurementBaseUrl => _serviceBase(
        'measurement/api',
        const String.fromEnvironment('API_MEASUREMENT_BASE_URL',
            defaultValue: ''),
      );

  String get challengeBaseUrl => _serviceBase(
        'challenge/api',
        const String.fromEnvironment('API_CHALLENGE_BASE_URL',
            defaultValue: ''),
      );

  String get socialBaseUrl => _serviceBase(
        'social/api',
        const String.fromEnvironment('API_SOCIAL_BASE_URL', defaultValue: ''),
      );

  String get billingBaseUrl => _serviceBase(
        'billing/api',
        const String.fromEnvironment('API_BILLING_BASE_URL', defaultValue: ''),
      );

  String get mediaBaseUrl => _serviceBase(
        'media/api',
        const String.fromEnvironment('API_MEDIA_BASE_URL', defaultValue: ''),
      );

  String get chatBaseUrl => _serviceBase(
        'chat/api',
        const String.fromEnvironment('API_CHAT_BASE_URL', defaultValue: ''),
      );

  String get personalCoachBaseUrl => _serviceBase(
        'coach/api',
        const String.fromEnvironment('API_COACH_BASE_URL', defaultValue: ''),
      );

  String get aiOcrBaseUrl => _serviceBase(
        'ai-ocr/api',
        const String.fromEnvironment('API_AI_OCR_BASE_URL', defaultValue: ''),
      );

  /// Legacy property names -------------------------------------------------

  String get catalogBaseUrl => measurementBaseUrl;

  String get orderBaseUrl => challengeBaseUrl;

  String get paymentBaseUrl => billingBaseUrl;

  AppConfig copyWith({
    String? flavor,
    String? gatewayBaseUrl,
    bool? enableLogging,
  }) {
    return AppConfig(
      flavor: flavor ?? this.flavor,
      gatewayBaseUrl: gatewayBaseUrl ?? this.gatewayBaseUrl,
      enableLogging: enableLogging ?? this.enableLogging,
    );
  }

  /// Internal helpers ------------------------------------------------------

  static String _resolveDefaultGateway() {
    const override =
        String.fromEnvironment('API_GATEWAY_BASE_URL', defaultValue: '');
    if (override.isNotEmpty) {
      return _normalizeUrl(override);
    }

    if (kIsWeb) {
      return 'http://14.225.212.36:8088';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'http://10.0.2.2:8088';
      case TargetPlatform.iOS:
        return 'http://127.0.0.1:8088';
      default:
        return 'http://14.225.212.36:8088';
    }
  }

  String _serviceBase(String servicePath, String override) {
    final overrideTrimmed = override.trim();
    if (overrideTrimmed.isNotEmpty) {
      return _normalizeUrl(overrideTrimmed);
    }

    final normalizedPath = _normalizeServicePath(servicePath);
    return '$gatewayBaseUrl/$normalizedPath';
  }

  static String _normalizeUrl(String url) {
    var trimmed = url.trim();
    while (trimmed.endsWith('/')) {
      trimmed = trimmed.substring(0, trimmed.length - 1);
    }
    return trimmed;
  }

  static String _normalizeServicePath(String path) {
    var normalized = path.trim();
    while (normalized.startsWith('/')) {
      normalized = normalized.substring(1);
    }
    return normalized;
  }
}
