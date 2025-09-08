import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  const LogoutUseCase({required AuthRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> execute() async {
    return await _repository.logout();
  }
}