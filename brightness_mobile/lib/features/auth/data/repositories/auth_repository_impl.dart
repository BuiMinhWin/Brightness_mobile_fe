import '../../domain/entities/auth_token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_data_source.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthToken>> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      final token = await remoteDataSource.login(
        emailOrUsername: emailOrUsername,
        password: password,
      );
      return Right(token);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, cause: e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> loginWithGoogle() async {
    try {
      final token = await remoteDataSource.loginWithGoogle();
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> loginWithFacebook() async {
    try {
      final token = await remoteDataSource.loginWithFacebook();
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final token = await remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({
    required String email,
  }) async {
    try {
      await remoteDataSource.forgotPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred', cause: e));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String email,
    required String password,
    String? username,
    String? fullName,
    String? phoneNumber,
    String? gender,
    DateTime? dateOfBirth,
    String? profilePicture,
  }) async {
    try {
      await remoteDataSource.register(
        email: email,
        password: password,
        username: username,
        fullName: fullName,
        phoneNumber: phoneNumber,
        gender: gender,
        dateOfBirth: dateOfBirth,
        profilePicture: profilePicture,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, cause: e));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message, cause: e));
    } catch (e) {
      return Left(ServerFailure('Registration failed', cause: e));
    }
  }
}
