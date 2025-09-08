import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_data.dart';
import '../../domain/usecases/save_onboarding_data.dart';

class OnboardingController with ChangeNotifier {
  final SaveOnboardingData _saveOnboardingData;

  OnboardingController(this._saveOnboardingData);

  String _fullName = '';
  int? _age;
  String _gender = 'Male';
  double? _height;
  double? _weight;
  String _fitnessGoal = '';
  String _activityLevel = '';
  List<String> _workoutDays = [];
  String? _medicalInfo;
  double? _waist;
  double? _chest;
  double? _hips;
  String? _progressPhotoPath;
  bool _isLoading = false;
  String? _error;

  String get fullName => _fullName;
  int? get age => _age;
  String get gender => _gender;
  double? get height => _height;
  double? get weight => _weight;
  String get fitnessGoal => _fitnessGoal;
  String get activityLevel => _activityLevel;
  List<String> get workoutDays => _workoutDays;
  String? get medicalInfo => _medicalInfo;
  double? get waist => _waist;
  double? get chest => _chest;
  double? get hips => _hips;
  String? get progressPhotoPath => _progressPhotoPath;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get isValid =>
      _fullName.isNotEmpty &&
      _age != null &&
      _height != null &&
      _weight != null &&
      _fitnessGoal.isNotEmpty &&
      _activityLevel.isNotEmpty;

  void updateFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void updateAge(int value) {
    _age = value;
    notifyListeners();
  }

  void updateGender(String value) {
    _gender = value;
    notifyListeners();
  }

  void updateHeight(double value) {
    _height = value;
    notifyListeners();
  }

  void updateWeight(double value) {
    _weight = value;
    notifyListeners();
  }

  void updateFitnessGoal(String value) {
    _fitnessGoal = value;
    notifyListeners();
  }

  void updateActivityLevel(String value) {
    _activityLevel = value;
    notifyListeners();
  }

  void toggleWorkoutDay(String day) {
    if (_workoutDays.contains(day)) {
      _workoutDays.remove(day);
    } else {
      _workoutDays.add(day);
    }
    notifyListeners();
  }

  void updateMedicalInfo(String? value) {
    _medicalInfo = value;
    notifyListeners();
  }

  void updateWaist(double? value) {
    _waist = value;
    notifyListeners();
  }

  void updateChest(double? value) {
    _chest = value;
    notifyListeners();
  }

  void updateHips(double? value) {
    _hips = value;
    notifyListeners();
  }

  Future<bool> saveOnboardingData() async {
    if (!isValid) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = OnboardingData(
        fullName: _fullName,
        age: _age!,
        gender: _gender,
        height: _height!,
        weight: _weight!,
        fitnessGoal: _fitnessGoal,
        activityLevel: _activityLevel,
        workoutDays: _workoutDays,
        medicalInfo: _medicalInfo,
        waist: _waist,
        chest: _chest,
        hips: _hips,
        progressPhotoPath: _progressPhotoPath,
      );

      await _saveOnboardingData(data);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
