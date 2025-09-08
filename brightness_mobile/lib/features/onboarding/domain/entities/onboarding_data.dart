class OnboardingData {
  final String fullName;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String fitnessGoal;
  final String activityLevel;
  final List<String> workoutDays;
  final String? medicalInfo;
  final double? waist;
  final double? chest;
  final double? hips;
  final String? progressPhotoPath;

  const OnboardingData({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.fitnessGoal,
    required this.activityLevel,
    required this.workoutDays,
    this.medicalInfo,
    this.waist,
    this.chest,
    this.hips,
    this.progressPhotoPath,
  });

  OnboardingData copyWith({
    String? fullName,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? fitnessGoal,
    String? activityLevel,
    List<String>? workoutDays,
    String? medicalInfo,
    double? waist,
    double? chest,
    double? hips,
    String? progressPhotoPath,
  }) {
    return OnboardingData(
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      activityLevel: activityLevel ?? this.activityLevel,
      workoutDays: workoutDays ?? this.workoutDays,
      medicalInfo: medicalInfo ?? this.medicalInfo,
      waist: waist ?? this.waist,
      chest: chest ?? this.chest,
      hips: hips ?? this.hips,
      progressPhotoPath: progressPhotoPath ?? this.progressPhotoPath,
    );
  }
}
