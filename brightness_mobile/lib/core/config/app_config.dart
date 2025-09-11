// // import 'app_flavor.dart';

// // class AppConfig {
// //   final AppFlavor flavor;
// //   final String title;
// //   // Base URLs per microservice
// //   final Uri authBaseUrl;
// //   final Uri userBaseUrl;
// //   final Uri catalogBaseUrl;
// //   final Uri orderBaseUrl;
// //   final Uri paymentBaseUrl;


// //   const AppConfig({
// //     required this.flavor,
// //     required this.title,
// //     required this.authBaseUrl,
// //     required this.userBaseUrl,
// //     required this.catalogBaseUrl,
// //     required this.orderBaseUrl,
// //     required this.paymentBaseUrl,
// //   });

// //   factory AppConfig.forFlavor(AppFlavor flavor) {
// //     switch (flavor) {
// //       case AppFlavor.prod:
// //         return AppConfig(
// //           flavor: flavor,
// //           title: 'Brightness Mobile',
// //           authBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_AUTH_BASE_URL',
// //               defaultValue: 'https://api.example.com/auth')),
// //           userBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_USER_BASE_URL',
// //               defaultValue: 'https://api.example.com/user')),
// //           catalogBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_CATALOG_BASE_URL',
// //               defaultValue: 'https://api.example.com/catalog')),
// //           orderBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_ORDER_BASE_URL',
// //               defaultValue: 'https://api.example.com/order')),
// //           paymentBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_PAYMENT_BASE_URL',
// //               defaultValue: 'https://api.example.com/payment')),
// //         );
// //       case AppFlavor.stg:
// //         return AppConfig(
// //           flavor: flavor,
// //           title: 'Brightness Mobile (Staging)',
// //           authBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_AUTH_BASE_URL',
// //               defaultValue: 'https://stg.api.example.com/auth')),
// //           userBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_USER_BASE_URL',
// //               defaultValue: 'https://stg.api.example.com/user')),
// //           catalogBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_CATALOG_BASE_URL',
// //               defaultValue: 'https://stg.api.example.com/catalog')),
// //           orderBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_ORDER_BASE_URL',
// //               defaultValue: 'https://stg.api.example.com/order')),
// //           paymentBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_PAYMENT_BASE_URL',
// //               defaultValue: 'https://stg.api.example.com/payment')),
// //         );
// //       case AppFlavor.dev:
// //       default:
// //         return AppConfig(
// //           flavor: flavor,
// //           title: 'Brightness Mobile (Dev)',
// //           authBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_AUTH_BASE_URL',
// //               defaultValue: 'http://localhost:8081')),
// //           userBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_USER_BASE_URL',
// //               defaultValue: 'http://localhost:8082')),
// //           catalogBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_CATALOG_BASE_URL',
// //               defaultValue: 'http://localhost:8083')),
// //           orderBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_ORDER_BASE_URL',
// //               defaultValue: 'http://localhost:8084')),
// //           paymentBaseUrl: Uri.parse(const String.fromEnvironment(
// //               'API_PAYMENT_BASE_URL',
// //               defaultValue: 'http://localhost:8085')),
// //         );
// //     }
// //   }
// // }

class AppConfig {
  final String flavor;
  final String authBaseUrl;
  final String userBaseUrl;
  final String catalogBaseUrl;
  final String orderBaseUrl;
  final String paymentBaseUrl;
  final bool enableLogging;

  const AppConfig({
    required this.flavor,
    required this.authBaseUrl,
    required this.userBaseUrl,
    required this.catalogBaseUrl,
    required this.orderBaseUrl,
    required this.paymentBaseUrl,
    this.enableLogging = false,
  });

  factory AppConfig.dev() {
    return const AppConfig(
      flavor: 'dev',
      authBaseUrl: 'http://localhost:8081',
      userBaseUrl: 'http://localhost:8082',
      catalogBaseUrl: 'http://localhost:8083',
      orderBaseUrl: 'http://localhost:8084',
      paymentBaseUrl: 'http://localhost:8085',
      enableLogging: true,
    );
  }

  factory AppConfig.staging() {
    return const AppConfig(
      flavor: 'stg',
      authBaseUrl: 'https://api-stg.brightnest.com/auth',
      userBaseUrl: 'https://api-stg.brightnest.com/user',
      catalogBaseUrl: 'https://api-stg.brightnest.com/catalog',
      orderBaseUrl: 'https://api-stg.brightnest.com/order',
      paymentBaseUrl: 'https://api-stg.brightnest.com/payment',
      enableLogging: true,
    );
  }

  factory AppConfig.production() {
    return const AppConfig(
      flavor: 'prod',
      authBaseUrl: 'https://api.brightnest.com/auth',
      userBaseUrl: 'https://api.brightnest.com/user',
      catalogBaseUrl: 'https://api.brightnest.com/catalog',
      orderBaseUrl: 'https://api.brightnest.com/order',
      paymentBaseUrl: 'https://api.brightnest.com/payment',
      enableLogging: false,
    );
  }

  factory AppConfig.fromEnvironment() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    
    switch (flavor) {
      case 'prod':
        return AppConfig.production().copyWith(
          authBaseUrl: const String.fromEnvironment(
            'API_AUTH_BASE_URL',
            defaultValue: 'https://api.brightnest.com/auth',
          ),
          userBaseUrl: const String.fromEnvironment(
            'API_USER_BASE_URL',
            defaultValue: 'https://api.brightnest.com/user',
          ),
          catalogBaseUrl: const String.fromEnvironment(
            'API_CATALOG_BASE_URL',
            defaultValue: 'https://api.brightnest.com/catalog',
          ),
          orderBaseUrl: const String.fromEnvironment(
            'API_ORDER_BASE_URL',
            defaultValue: 'https://api.brightnest.com/order',
          ),
          paymentBaseUrl: const String.fromEnvironment(
            'API_PAYMENT_BASE_URL',
            defaultValue: 'https://api.brightnest.com/payment',
          ),
        );
      case 'stg':
        return AppConfig.staging().copyWith(
          authBaseUrl: const String.fromEnvironment(
            'API_AUTH_BASE_URL',
            defaultValue: 'https://api-stg.brightnest.com/auth',
          ),
          userBaseUrl: const String.fromEnvironment(
            'API_USER_BASE_URL',
            defaultValue: 'https://api-stg.brightnest.com/user',
          ),
          catalogBaseUrl: const String.fromEnvironment(
            'API_CATALOG_BASE_URL',
            defaultValue: 'https://api-stg.brightnest.com/catalog',
          ),
          orderBaseUrl: const String.fromEnvironment(
            'API_ORDER_BASE_URL',
            defaultValue: 'https://api-stg.brightnest.com/order',
          ),
          paymentBaseUrl: const String.fromEnvironment(
            'API_PAYMENT_BASE_URL',
            defaultValue: 'https://api-stg.brightnest.com/payment',
          ),
        );
      default:
        return AppConfig.dev().copyWith(
          authBaseUrl: const String.fromEnvironment(
            'API_AUTH_BASE_URL',
            defaultValue: 'http://localhost:8081',
          ),
          userBaseUrl: const String.fromEnvironment(
            'API_USER_BASE_URL',
            defaultValue: 'http://localhost:8082',
          ),
          catalogBaseUrl: const String.fromEnvironment(
            'API_CATALOG_BASE_URL',
            defaultValue: 'http://localhost:8083',
          ),
          orderBaseUrl: const String.fromEnvironment(
            'API_ORDER_BASE_URL',
            defaultValue: 'http://localhost:8084',
          ),
          paymentBaseUrl: const String.fromEnvironment(
            'API_PAYMENT_BASE_URL',
            defaultValue: 'http://localhost:8085',
          ),
        );
    }
  }

  AppConfig copyWith({
    String? flavor,
    String? authBaseUrl,
    String? userBaseUrl,
    String? catalogBaseUrl,
    String? orderBaseUrl,
    String? paymentBaseUrl,
    bool? enableLogging,
  }) {
    return AppConfig(
      flavor: flavor ?? this.flavor,
      authBaseUrl: authBaseUrl ?? this.authBaseUrl,
      userBaseUrl: userBaseUrl ?? this.userBaseUrl,
      catalogBaseUrl: catalogBaseUrl ?? this.catalogBaseUrl,
      orderBaseUrl: orderBaseUrl ?? this.orderBaseUrl,
      paymentBaseUrl: paymentBaseUrl ?? this.paymentBaseUrl,
      enableLogging: enableLogging ?? this.enableLogging,
    );
  }
}

