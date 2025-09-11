import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/either_usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUsecase implements EitherUseCase<ProfileEntity, ProfileEntity> {
  final ProfileRepository repository;

  UpdateProfileUsecase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileEntity profile) async {
    return await repository.updateProfile(profile);
  }
}
