// import '../../domain/entities/auth_token.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../sources/auth_remote_data_source.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remote;
//   AuthRepositoryImpl({required this.remote});

//   @override
//   Future<AuthToken> login({required String username, required String password}) {
//     return remote.login(username: username, password: password);
//   }
// }

import '../../domain/entities/auth_token.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_data_source.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthToken>> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        emailOrUsername: emailOrUsername,
        password: password,
      );
      return Right(result);
    } on AuthException catch (e) {
       return Left(AuthFailure(e.toString())); 
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> loginWithGoogle() async {
    try {
      final result = await remoteDataSource.loginWithGoogle();
      return Right(result);
    } on ServerException catch (e) {
       return Left(ServerFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
       return Left(ServerFailure('An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> loginWithFacebook() async {
    try {
      final result = await remoteDataSource.loginWithFacebook();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString())
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString())
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final result = await remoteDataSource.refreshToken(
        refreshToken: refreshToken,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString())
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final result = await remoteDataSource.getCurrentUser();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString())
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
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
     return Left(ServerFailure(e.toString())
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
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
      return Left(ServerFailure(e.toString())
      );
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred',
      ));
    }
  }

  // @override
  // Future<Either<Failure, User>> register({
  //   DateTime? dateOfBirth,
  //   required String email,
  //   String? fullName,
  //   String? gender,
  //   required String password,
  //   String? phoneNumber,
  //   String? profilePicture,
  //   String? username,
  // }) async {
  //   try {
  //     final userModel = await remoteDataSource.register(
  //       // Change 'dateOfBirth' to the correct parameter name if needed, or add it to the register method definition.
  //       dateOfBirth: dateOfBirth,
  //       email: email,
  //       fullName: fullName,
  //       gender: gender,
  //       password: password,
  //       phoneNumber: phoneNumber,
  //       profilePicture: profilePicture,
  //       username: username,
  //     );
  //     return Right(userModel);
  //   } catch (e) {
  //     return Left(AuthFailure(e.toString())); // ✅
  //   }
  // }

  // @override
  // Future<Either<Failure, User>> getCurrentUser() async {
  //   try {
  //     final userModel = await remoteDataSource.getCurrentUser();
  //     return Right(userModel);
  //   } catch (e) {
  //     return Left(AuthFailure(e.toString())); // ✅
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> logout() async {
  //   try {
  //     await remoteDataSource.logout();
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(AuthFailure(e.toString())); // ✅
  //   }
  // }

   @override
  Future<Either<Failure, User>> register({
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
      final user = await remoteDataSource.register(
        email: email,
        password: password,
        username: username,
        fullName: fullName,
        phoneNumber: phoneNumber,
        gender: gender,
        dateOfBirth: dateOfBirth,
        profilePicture: profilePicture,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure('Registration failed'));
    }
  }
}