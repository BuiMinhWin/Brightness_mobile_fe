// import '../entities/auth_token.dart';

// abstract class AuthRepository {
//   Future<AuthToken> login({required String username, required String password});
// }

import '../entities/auth_token.dart';
import '../entities/user.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login({
    required String emailOrUsername,
    required String password,
  });

  Future<Either<Failure, AuthToken>> loginWithGoogle();

  Future<Either<Failure, AuthToken>> loginWithFacebook();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, AuthToken>> refreshToken({
    required String refreshToken,
  });

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? username,
    String? fullName,
    // String? firstName, // optional nếu backend có
    // String? lastName,  // optional nếu backend có
    String? phoneNumber,
    String? gender,
    DateTime? dateOfBirth,
    String? profilePicture,
  });
}

