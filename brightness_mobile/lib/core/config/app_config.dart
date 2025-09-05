import 'app_flavor.dart';

class AppConfig {
  final AppFlavor flavor;
  final String title;
  // Base URLs per microservice
  final Uri authBaseUrl;
  final Uri userBaseUrl;
  final Uri catalogBaseUrl;
  final Uri orderBaseUrl;
  final Uri paymentBaseUrl;

  const AppConfig({
    required this.flavor,
    required this.title,
    required this.authBaseUrl,
    required this.userBaseUrl,
    required this.catalogBaseUrl,
    required this.orderBaseUrl,
    required this.paymentBaseUrl,
  });

  factory AppConfig.forFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.prod:
        return AppConfig(
          flavor: flavor,
          title: 'Brightness Mobile',
          authBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_AUTH_BASE_URL',
              defaultValue: 'https://api.example.com/auth')),
          userBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_USER_BASE_URL',
              defaultValue: 'https://api.example.com/user')),
          catalogBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_CATALOG_BASE_URL',
              defaultValue: 'https://api.example.com/catalog')),
          orderBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_ORDER_BASE_URL',
              defaultValue: 'https://api.example.com/order')),
          paymentBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_PAYMENT_BASE_URL',
              defaultValue: 'https://api.example.com/payment')),
        );
      case AppFlavor.stg:
        return AppConfig(
          flavor: flavor,
          title: 'Brightness Mobile (Staging)',
          authBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_AUTH_BASE_URL',
              defaultValue: 'https://stg.api.example.com/auth')),
          userBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_USER_BASE_URL',
              defaultValue: 'https://stg.api.example.com/user')),
          catalogBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_CATALOG_BASE_URL',
              defaultValue: 'https://stg.api.example.com/catalog')),
          orderBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_ORDER_BASE_URL',
              defaultValue: 'https://stg.api.example.com/order')),
          paymentBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_PAYMENT_BASE_URL',
              defaultValue: 'https://stg.api.example.com/payment')),
        );
      case AppFlavor.dev:
      default:
        return AppConfig(
          flavor: flavor,
          title: 'Brightness Mobile (Dev)',
          authBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_AUTH_BASE_URL',
              defaultValue: 'http://localhost:8081')),
          userBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_USER_BASE_URL',
              defaultValue: 'http://localhost:8082')),
          catalogBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_CATALOG_BASE_URL',
              defaultValue: 'http://localhost:8083')),
          orderBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_ORDER_BASE_URL',
              defaultValue: 'http://localhost:8084')),
          paymentBaseUrl: Uri.parse(const String.fromEnvironment(
              'API_PAYMENT_BASE_URL',
              defaultValue: 'http://localhost:8085')),
        );
    }
  }
}

