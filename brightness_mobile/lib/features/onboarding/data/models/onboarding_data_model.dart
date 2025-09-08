import '../../domain/entities/onboarding_data.dart';

class OnboardingDataModel extends OnboardingData {
  const OnboardingDataModel({
    required super.fullName,
    required super.age,
    required super.gender,
    required super.height,
    required super.weight,
    required super.fitnessGoal,
    required super.activityLevel,
    required super.workoutDays,
    super.medicalInfo,
    super.waist,
    super.chest,
    super.hips,
    super.progressPhotoPath,
  });

  factory OnboardingDataModel.fromJson(Map<String, dynamic> json) {
    return OnboardingDataModel(
      fullName: json['fullName'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      fitnessGoal: json['fitnessGoal'] as String,
      activityLevel: json['activityLevel'] as String,
      workoutDays: List<String>.from(json['workoutDays'] as List),
      medicalInfo: json['medicalInfo'] as String?,
      waist: json['waist'] != null ? (json['waist'] as num).toDouble() : null,
      chest: json['chest'] != null ? (json['chest'] as num).toDouble() : null,
      hips: json['hips'] != null ? (json['hips'] as num).toDouble() : null,
      progressPhotoPath: json['progressPhotoPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'fitnessGoal': fitnessGoal,
      'activityLevel': activityLevel,
      'workoutDays': workoutDays,
      'medicalInfo': medicalInfo,
      'waist': waist,
      'chest': chest,
      'hips': hips,
      'progressPhotoPath': progressPhotoPath,
    };
  }
}
