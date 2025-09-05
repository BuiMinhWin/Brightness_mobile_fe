abstract class Failure implements Exception {
  final String message;
  final Object? cause;
  const Failure(this.message, {this.cause});

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause});
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.cause});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.cause});
}
