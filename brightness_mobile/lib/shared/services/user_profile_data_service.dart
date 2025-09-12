import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/feed_section.dart';

/// User Profile Model
class UserProfile {
  final String userId;
  final String userName;
  final String jobTitle;
  final String location;
  final String hobby;
  final String rank;
  final int postsCount;
  final int likesCount;
  final String? profileImageUrl;
  final bool isOwnProfile;
  final bool isFriend;
  final String? bio;
  final String? joinDate;
  final String? lastActive;

  const UserProfile({
    required this.userId,
    required this.userName,
    required this.jobTitle,
    required this.location,
    required this.hobby,
    required this.rank,
    required this.postsCount,
    required this.likesCount,
    this.profileImageUrl,
    this.isOwnProfile = false,
    this.isFriend = false,
    this.bio,
    this.joinDate,
    this.lastActive,
  });
}

/// Edit Profile Form Data Model
class EditProfileData {
  final String userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? dateOfBirth;
  final String? location;
  final String? hobby;
  final String? occupation;
  final String? profileImageUrl;
  final List<String>? interests;
  final String? phoneNumber;
  final String? website;
  final String? bio;
  final Map<String, String>? socialLinks;
  final Map<String, bool>? privacySettings;

  const EditProfileData({
    required this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dateOfBirth,
    this.location,
    this.hobby,
    this.occupation,
    this.profileImageUrl,
    this.interests,
    this.phoneNumber,
    this.website,
    this.bio,
    this.socialLinks,
    this.privacySettings,
  });

  EditProfileData copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? dateOfBirth,
    String? location,
    String? hobby,
    String? occupation,
    String? profileImageUrl,
    List<String>? interests,
    String? phoneNumber,
    String? website,
    String? bio,
    Map<String, String>? socialLinks,
    Map<String, bool>? privacySettings,
  }) {
    return EditProfileData(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      hobby: hobby ?? this.hobby,
      occupation: occupation ?? this.occupation,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      interests: interests ?? this.interests,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      bio: bio ?? this.bio,
      socialLinks: socialLinks ?? this.socialLinks,
      privacySettings: privacySettings ?? this.privacySettings,
    );
  }
}

class UserProfileDataService {
  static const String _profileDataPath = 'assets/temps/user_profile_data.json';
  static const String _editProfileDataPath = 'assets/temps/edit_profile_data.json';

  /// Loads user profile data from JSON file
  static Future<UserProfile> getUserProfile({String? userId}) async {
    try {
      final String response = await rootBundle.loadString(_profileDataPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final Map<String, dynamic> profileJson = data['profile'];
      return _parseUserProfileFromJson(profileJson);
    } catch (e) {
      print('Error loading user profile: $e');
      return _getDefaultUserProfile();
    }
  }

  /// Loads user posts from JSON file
  static Future<List<PostData>> getUserPosts({String? userId}) async {
    try {
      final String response = await rootBundle.loadString(_profileDataPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final List<dynamic> postsJson = data['posts'];
      return postsJson.map((postJson) => _parsePostDataFromJson(postJson)).toList();
    } catch (e) {
      print('Error loading user posts: $e');
      return [];
    }
  }

  /// Loads edit profile form data from JSON file
  static Future<EditProfileData> getEditProfileData({String? userId}) async {
    try {
      final String response = await rootBundle.loadString(_editProfileDataPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final Map<String, dynamic> profileJson = data['profile'];
      return _parseEditProfileDataFromJson(profileJson);
    } catch (e) {
      print('Error loading edit profile data: $e');
      return _getDefaultEditProfileData();
    }
  }

  /// Loads country options from JSON file
  static Future<List<Map<String, String>>> getCountryOptions() async {
    try {
      final String response = await rootBundle.loadString(_editProfileDataPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final List<dynamic> countriesJson = data['countries'];
      return countriesJson.map((country) => {
        'value': country['value'] as String,
        'label': country['label'] as String,
      }).toList();
    } catch (e) {
      print('Error loading country options: $e');
      return [];
    }
  }

  /// Loads hobby options from JSON file
  static Future<List<String>> getHobbyOptions() async {
    try {
      final String response = await rootBundle.loadString(_editProfileDataPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final List<dynamic> hobbiesJson = data['hobbies'];
      return hobbiesJson.cast<String>();
    } catch (e) {
      print('Error loading hobby options: $e');
      return [];
    }
  }

  /// Loads occupation options from JSON file
  static Future<List<String>> getOccupationOptions() async {
    try {
      final String response = await rootBundle.loadString(_editProfileDataPath);
      final Map<String, dynamic> data = json.decode(response);
      
      final List<dynamic> occupationsJson = data['occupations'];
      return occupationsJson.cast<String>();
    } catch (e) {
      print('Error loading occupation options: $e');
      return [];
    }
  }

  /// Saves edit profile data (simulates API call)
  static Future<bool> saveEditProfileData(EditProfileData profileData) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // In a real app, this would make an API call to save the data
      print('Saving profile data for user: ${profileData.userId}');
      print('Updated fields: ${profileData.firstName}, ${profileData.lastName}, ${profileData.email}');
      
      return true;
    } catch (e) {
      print('Error saving profile data: $e');
      return false;
    }
  }

  /// Parses UserProfile from JSON
  static UserProfile _parseUserProfileFromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] ?? 'unknown',
      userName: json['userName'] ?? 'Unknown User',
      jobTitle: json['jobTitle'] ?? 'Unknown Job',
      location: json['location'] ?? 'Unknown Location',
      hobby: json['hobby'] ?? 'Unknown Hobby',
      rank: json['rank'] ?? 'Member',
      postsCount: json['postsCount'] ?? 0,
      likesCount: json['likesCount'] ?? 0,
      profileImageUrl: json['profileImageUrl'],
      isOwnProfile: json['isOwnProfile'] ?? false,
      isFriend: json['isFriend'] ?? false,
      bio: json['bio'],
      joinDate: json['joinDate'],
      lastActive: json['lastActive'],
    );
  }

  /// Parses PostData from JSON
  static PostData _parsePostDataFromJson(Map<String, dynamic> json) {
    return PostData(
      userName: json['userName'] ?? 'Unknown User',
      timestamp: json['timestamp'] ?? 'Unknown time',
      content: json['content'] ?? 'No content',
      imageUrl: json['imageUrl'],
      imageBackgroundColor: _parseColor(json['imageBackgroundColor']),
      isLiked: json['isLiked'] ?? false,
      likeCount: json['likeCount'] ?? 0,
      commentCount: json['commentCount'] ?? 0,
    );
  }

  /// Parses EditProfileData from JSON
  static EditProfileData _parseEditProfileDataFromJson(Map<String, dynamic> json) {
    return EditProfileData(
      userId: json['userId'] ?? 'unknown',
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      dateOfBirth: json['dateOfBirth'],
      location: json['location'],
      hobby: json['hobby'],
      occupation: json['occupation'],
      profileImageUrl: json['profileImageUrl'],
      interests: json['interests'] != null ? List<String>.from(json['interests']) : null,
      phoneNumber: json['phoneNumber'],
      website: json['website'],
      bio: json['bio'],
      socialLinks: json['socialLinks'] != null ? Map<String, String>.from(json['socialLinks']) : null,
      privacySettings: json['privacySettings'] != null ? Map<String, bool>.from(json['privacySettings']) : null,
    );
  }

  /// Converts color string to Color object
  static Color? _parseColor(String? colorString) {
    if (colorString == null) return null;
    
    // Remove # if present
    String cleanColor = colorString.replaceAll('#', '');
    
    // Add alpha if not present
    if (cleanColor.length == 6) {
      cleanColor = 'FF$cleanColor';
    }
    
    try {
      return Color(int.parse(cleanColor, radix: 16));
    } catch (e) {
      print('Error parsing color: $colorString');
      return null;
    }
  }

  /// Default user profile for error cases
  static UserProfile _getDefaultUserProfile() {
    return const UserProfile(
      userId: 'default',
      userName: 'Default User',
      jobTitle: 'Unknown Job',
      location: 'Unknown Location',
      hobby: 'Unknown Hobby',
      rank: 'Member',
      postsCount: 0,
      likesCount: 0,
    );
  }

  /// Default edit profile data for error cases
  static EditProfileData _getDefaultEditProfileData() {
    return const EditProfileData(
      userId: 'default',
    );
  }
}