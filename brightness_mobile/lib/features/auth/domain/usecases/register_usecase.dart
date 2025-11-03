import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/usecase/usecase.dart';

class RegisterParams {
  final String email;
  final String password;
  final String? username;
  final String? fullName;
  final String? phoneNumber;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? profilePicture;

  const RegisterParams({
    required this.email,
    required this.password,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.profilePicture,
  });
}

class RegisterUseCase implements UseCaseRegister<void, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    if (params.email.isEmpty) {
      return Left(ValidationFailure('Email is required'));
    }

    if (params.password.isEmpty) {
      return Left(ValidationFailure('Password is required'));
    }

    if (params.password.length < 6) {
      return Left(ValidationFailure('Password must be at least 6 characters'));
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(params.email)) {
      return Left(ValidationFailure('Invalid email format'));
    }

    return repository.register(
      email: params.email,
      password: params.password,
      username: params.username,
      fullName: params.fullName,
      phoneNumber: params.phoneNumber,
      gender: params.gender,
      dateOfBirth: params.dateOfBirth,
      profilePicture: params.profilePicture,
    );
  }

  /// Convenience helper for callers who don't want to instantiate RegisterParams.
  Future<Either<Failure, void>> execute({
    required String email,
    required String password,
    String? username,
    String? fullName,
    String? phoneNumber,
    String? gender,
    DateTime? dateOfBirth,
    String? profilePicture,
  }) {
    return call(RegisterParams(
      email: email,
      password: password,
      username: username,
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      dateOfBirth: dateOfBirth,
      profilePicture: profilePicture,
    ));
  }
}
