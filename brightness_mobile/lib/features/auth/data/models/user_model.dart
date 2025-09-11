// lib/features/auth/data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String email,
    String? username,
    String? password,
    DateTime? dateOfBirth,
    String? gender,
    String? profilePicture,
    String? role,
    String? status,
    required DateTime createdAt,
    String? phoneNumber,
    String? subscriptionPlanId,
    String? fullName,
    String? paymentId,
    DateTime? updatedAt,
  }) : super(
          id: id,
          email: email,
          username: username,
          password: password,
          dateOfBirth: dateOfBirth,
          gender: gender,
          profilePicture: profilePicture,
          role: role,
          status: status,
          createdAt: createdAt,
          phoneNumber: phoneNumber,
          subscriptionPlanId: subscriptionPlanId,
          fullName: fullName,
          paymentId: paymentId,
          updatedAt: updatedAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'],
      password: json['password'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'])
          : json['dateOfBirth'] != null
              ? DateTime.tryParse(json['dateOfBirth'])
              : null,
      gender: json['gender'],
      profilePicture: json['profile_picture'] ?? json['profilePicture'],
      role: json['role'],
      status: json['status'],
      createdAt: json['create_at'] != null
          ? DateTime.parse(json['create_at'])
          : json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(),
      phoneNumber: json['phone_number'] ?? json['phoneNumber'],
      subscriptionPlanId: json['subscription_plan_id'] ?? json['subscriptionPlanId'],
      fullName: json['full_name'] ?? json['fullName'],
      paymentId: json['payment_id'] ?? json['paymentId'],
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'profile_picture': profilePicture,
      'role': role,
      'status': status,
      'create_at': createdAt.toIso8601String(),
      'phone_number': phoneNumber,
      'subscription_plan_id': subscriptionPlanId,
      'full_name': fullName,
      'payment_id': paymentId,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      password: user.password,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      profilePicture: user.profilePicture,
      role: user.role,
      status: user.status,
      createdAt: user.createdAt,
      phoneNumber: user.phoneNumber,
      subscriptionPlanId: user.subscriptionPlanId,
      fullName: user.fullName,
      paymentId: user.paymentId,
      updatedAt: user.updatedAt,
    );
  }
}