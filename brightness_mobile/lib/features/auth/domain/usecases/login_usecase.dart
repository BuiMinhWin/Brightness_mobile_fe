import '../../../../core/usecase/usecase.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;
  LoginParams({required this.username, required this.password});
}

class LoginUseCase implements UseCase<AuthToken, LoginParams> {
  final AuthRepository _repo;
  LoginUseCase(this._repo);

  @override
  Future<AuthToken> call(LoginParams params) {
    return _repo.login(username: params.username, password: params.password);
  }
}

