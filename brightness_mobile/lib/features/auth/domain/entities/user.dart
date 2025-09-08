class User {
  final String id;
  final String email;
  final String? username;
  final String? password;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? profilePicture;
  final String? role;
  final String? status;
  final DateTime createdAt;
  final String? phoneNumber;
  final String? subscriptionPlanId;
  final String? fullName;
  final String? paymentId;
  final DateTime? updatedAt;

  const User({
    required this.id,
    required this.email,
    this.username,
    this.password,
    this.dateOfBirth,
    this.gender,
    this.profilePicture,
    this.role,
    this.status,
    required this.createdAt,
    this.phoneNumber,
    this.subscriptionPlanId,
    this.fullName,
    this.paymentId,
    this.updatedAt,
  });

  /// Getter cho fullName fallback
  String get displayName {
    if (fullName != null && fullName!.isNotEmpty) {
      return fullName!;
    }
    return username ?? email;
  }  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}