import 'package:flutter/material.dart';
import '../../domain/entities/daily_stats.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/fitness_program.dart';
import '../../data/datasources/fitness_data_datasource.dart';

class HomeController with ChangeNotifier {
  final FitnessDataDatasource datasource;

  HomeController(this.datasource);

  DailyStats? dailyStats;
  List<WorkoutPlan> workoutPlans = const [];
  List<FitnessProgram> fitnessPrograms = const [];
  bool isLoading = false;
  String? error;
  int selectedNavIndex = 0;

  void initialize() {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final ds = await datasource.getDailyStats();
      final plans = await datasource.getWorkoutPlans();
      final progs = await datasource.getFitnessPrograms();
      dailyStats = ds;
      workoutPlans = plans;
      fitnessPrograms = progs;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  void selectNavItem(int index) {
    selectedNavIndex = index;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadHomeData();
  }
}
