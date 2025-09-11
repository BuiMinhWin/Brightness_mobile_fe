// import '../../../../core/usecase/usecase.dart';
// import '../entities/auth_token.dart';
// import '../repositories/auth_repository.dart';

// class LoginParams {
//   final String username;
//   final String password;
//   LoginParams({required this.username, required this.password});
// }

// class LoginUseCase implements UseCase<AuthToken, LoginParams> {
//   final AuthRepository _repo;
//   LoginUseCase(this._repo);

//   @override
//   Future<AuthToken> call(LoginParams params) {
//     return _repo.login(username: params.username, password: params.password);
//   }
// }

import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';

class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<Either<Failure, AuthToken>> execute(
    String emailOrUsername,
    String password,
  ) async {
    // Add validation logic here if needed
      if (emailOrUsername.trim().isEmpty) {
      return Left(ValidationFailure('Email or username cannot be empty'));
    }

    if (password.isEmpty) {
      return Left(ValidationFailure('Password cannot be empty'));
    }

    if (password.length < 6) {
      return Left(ValidationFailure('Password must be at least 6 characters long'));
    }

    return await _repository.login(
      emailOrUsername: emailOrUsername.trim(),
      password: password,
    );
  }
}

