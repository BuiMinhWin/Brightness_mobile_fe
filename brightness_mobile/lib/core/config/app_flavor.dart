enum AppFlavor { dev, stg, prod }

class F {
  static AppFlavor? _flavor;

  static AppFlavor get flavor => _flavor ?? AppFlavor.dev;

  static void setFlavor(AppFlavor f) {
    _flavor = f;
  }

  static AppFlavor fromEnv() {
    final name = const String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (name.toLowerCase()) {
      case 'prod':
        return AppFlavor.prod;
      case 'stg':
      case 'stage':
      case 'staging':
        return AppFlavor.stg;
      default:
        return AppFlavor.dev;
    }
  }
}

