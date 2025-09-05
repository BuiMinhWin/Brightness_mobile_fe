import '../entities/auth_token.dart';

abstract class AuthRepository {
  Future<AuthToken> login({required String username, required String password});
}

