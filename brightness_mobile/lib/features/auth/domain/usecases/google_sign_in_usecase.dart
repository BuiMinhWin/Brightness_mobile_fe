import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';

class GoogleSignInUseCase {
  final AuthRepository _repository;

  const GoogleSignInUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<Either<Failure, AuthToken>> execute() async {
    return await _repository.loginWithGoogle();
  }
}