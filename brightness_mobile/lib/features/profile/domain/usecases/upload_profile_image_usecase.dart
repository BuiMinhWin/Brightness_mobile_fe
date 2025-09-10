import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/either_usecase.dart';
import '../repositories/profile_repository.dart';

class UploadProfileImageUsecase implements EitherUseCase<String, File> {
  final ProfileRepository repository;

  UploadProfileImageUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(File imageFile) async {
    return await repository.uploadProfileImage(imageFile);
  }
}
