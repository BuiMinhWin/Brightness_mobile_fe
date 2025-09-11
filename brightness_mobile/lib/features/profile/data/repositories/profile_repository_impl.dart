import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../shared/models/profile_model.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  // Mock implementation - replace with actual API calls
  
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock profile data - Updated to match design
    final mockProfile = ProfileModel(
      id: '1',
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
      interests: ['Football'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
    
    return Right(ProfileEntity.fromModel(mockProfile));
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock successful update
    final updatedProfile = profile.copyWith(
      updatedAt: DateTime.now(),
    );
    
    return Right(updatedProfile);
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(File imageFile) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 3));
    
    // Mock successful upload - return a mock URL
    final mockImageUrl = 'https://example.com/profile-images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    
    return Right(mockImageUrl);
  }
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
