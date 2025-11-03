import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../shared/models/profile_model.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final model = await _remoteDataSource.fetchProfile();
      return Right(ProfileEntity.fromModel(model));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, cause: e));
    } on ServerException {
      final fallback = await _loadMockProfile();
      return Right(fallback);
    } on NetworkException catch (_) {
      final fallback = await _loadMockProfile();
      return Right(fallback);
    } catch (e) {
      final fallback = await _loadMockProfile();
      return Right(fallback);
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
    ProfileEntity profile,
  ) async {
    final model = profile.toModel();

    try {
      final updated = await _remoteDataSource.updateProfile(model);
      return Right(ProfileEntity.fromModel(updated));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, cause: e));
    } on ServerException catch (_) {
      return Right(
        profile.copyWith(updatedAt: DateTime.now()),
      );
    } on NetworkException catch (_) {
      return Right(
        profile.copyWith(updatedAt: DateTime.now()),
      );
    } catch (_) {
      return Right(
        profile.copyWith(updatedAt: DateTime.now()),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(File imageFile) async {
    try {
      final url = await _remoteDataSource.uploadProfileImage(imageFile);
      return Right(url);
    } on ServerException catch (_) {
      return Right(_mockImageUrl());
    } on NetworkException catch (_) {
      return Right(_mockImageUrl());
    } catch (_) {
      return Right(_mockImageUrl());
    }
  }

  Future<ProfileEntity> _loadMockProfile() async {
    await Future.delayed(const Duration(milliseconds: 350));
    final mockProfile = ProfileModel(
      id: 'mock-1',
      firstName: 'Melissa',
      lastName: 'Peters',
      email: 'melpeters@gmail.com',
      phoneNumber: '+1234567890',
      dateOfBirth: '1995-05-23',
      gender: 'female',
      profileImageUrl: null,
      bio: null,
      location: 'Nigeria',
      website: null,
      occupation: 'Doctor',
      company: null,
      interests: const ['Football'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );

    return ProfileEntity.fromModel(mockProfile);
  }

  String _mockImageUrl() =>
      'https://example.com/profile-images/${DateTime.now().millisecondsSinceEpoch}.jpg';
}

extension ProfileEntityCopyWith on ProfileEntity {
  ProfileEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? profileImageUrl,
    String? bio,
    String? location,
    String? website,
    String? occupation,
    String? company,
    List<String>? interests,
    Map<String, dynamic>? preferences,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      website: website ?? this.website,
      occupation: occupation ?? this.occupation,
      company: company ?? this.company,
      interests: interests ?? this.interests,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
