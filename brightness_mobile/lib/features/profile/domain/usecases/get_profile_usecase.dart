import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/either_usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUsecase implements EitherUseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileUsecase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) async {
    return await repository.getProfile();
  }
}
