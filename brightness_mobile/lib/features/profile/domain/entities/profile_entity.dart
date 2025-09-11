import '../../../../shared/models/profile_model.dart';

class ProfileEntity {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? profileImageUrl;
  final String? bio;
  final String? location;
  final String? website;
  final String? occupation;
  final String? company;
  final List<String>? interests;
  final Map<String, dynamic>? preferences;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.profileImageUrl,
    this.bio,
    this.location,
    this.website,
    this.occupation,
    this.company,
    this.interests,
    this.preferences,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileEntity.fromModel(ProfileModel model) {
    return ProfileEntity(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      phoneNumber: model.phoneNumber,
      dateOfBirth: model.dateOfBirth,
      gender: model.gender,
      profileImageUrl: model.profileImageUrl,
      bio: model.bio,
      location: model.location,
      website: model.website,
      occupation: model.occupation,
      company: model.company,
      interests: model.interests,
      preferences: model.preferences,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  ProfileModel toModel() {
    return ProfileModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
      profileImageUrl: profileImageUrl,
      bio: bio,
      location: location,
      website: website,
      occupation: occupation,
      company: company,
      interests: interests,
      preferences: preferences,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  String get fullName {
    final first = firstName?.trim() ?? '';
    final last = lastName?.trim() ?? '';
    if (first.isEmpty && last.isEmpty) return '';
    if (first.isEmpty) return last;
    if (last.isEmpty) return first;
    return '$first $last';
  }

  String get displayName {
    return fullName.isNotEmpty ? fullName : email ?? 'User';
  }

  bool get hasProfileImage => profileImageUrl != null && profileImageUrl!.isNotEmpty;

  bool get isComplete {
    return firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileEntity &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.profileImageUrl == profileImageUrl &&
        other.bio == bio &&
        other.location == location &&
        other.website == website &&
        other.occupation == occupation &&
        other.company == company;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      dateOfBirth,
      gender,
      profileImageUrl,
      bio,
      location,
      website,
      occupation,
      company,
    );
  }

  @override
  String toString() {
    return 'ProfileEntity(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, profileImageUrl: $profileImageUrl, bio: $bio, location: $location, website: $website, occupation: $occupation, company: $company)';
  }
}
