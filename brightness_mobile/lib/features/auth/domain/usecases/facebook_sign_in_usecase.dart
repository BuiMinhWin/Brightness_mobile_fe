import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';

class FacebookSignInUseCase {
  final AuthRepository _repository;

  const FacebookSignInUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<Either<Failure, AuthToken>> execute() async {
    return await _repository.loginWithFacebook();
  }
}