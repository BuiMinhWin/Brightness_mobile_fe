import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
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

  const ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  ProfileModel copyWith({
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
    return ProfileModel(
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
    return other is ProfileModel &&
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
    return 'ProfileModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, profileImageUrl: $profileImageUrl, bio: $bio, location: $location, website: $website, occupation: $occupation, company: $company)';
  }
}

// Form data model for editing profile
@JsonSerializable()
class ProfileFormData {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? bio;
  String? location;
  String? website;
  String? occupation;
  String? company;
  List<String>? interests;

  ProfileFormData({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.bio,
    this.location,
    this.website,
    this.occupation,
    this.company,
    this.interests,
  });

  factory ProfileFormData.fromProfile(ProfileModel profile) {
    return ProfileFormData(
      firstName: profile.firstName,
      lastName: profile.lastName,
      email: profile.email,
      phoneNumber: profile.phoneNumber,
      dateOfBirth: profile.dateOfBirth,
      gender: profile.gender,
      bio: profile.bio,
      location: profile.location,
      website: profile.website,
      occupation: profile.occupation,
      company: profile.company,
      interests: profile.interests,
    );
  }

  ProfileModel toProfile({String? id, String? profileImageUrl}) {
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
      updatedAt: DateTime.now(),
    );
  }

  factory ProfileFormData.fromJson(Map<String, dynamic> json) =>
      _$ProfileFormDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileFormDataToJson(this);

  ProfileFormData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? bio,
    String? location,
    String? website,
    String? occupation,
    String? company,
    List<String>? interests,
  }) {
    return ProfileFormData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      website: website ?? this.website,
      occupation: occupation ?? this.occupation,
      company: company ?? this.company,
      interests: interests ?? this.interests,
    );
  }

  bool get hasChanges {
    return firstName != null ||
        lastName != null ||
        email != null ||
        phoneNumber != null ||
        dateOfBirth != null ||
        gender != null ||
        bio != null ||
        location != null ||
        website != null ||
        occupation != null ||
        company != null ||
        (interests != null && interests!.isNotEmpty);
  }

  @override
  String toString() {
    return 'ProfileFormData(firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, bio: $bio, location: $location, website: $website, occupation: $occupation, company: $company, interests: $interests)';
  }
}
