import '../../domain/entities/auth_token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl({required this.remote});

  @override
  Future<AuthToken> login({required String username, required String password}) {
    return remote.login(username: username, password: password);
  }
}

