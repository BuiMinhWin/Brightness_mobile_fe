import '../../domain/entities/daily_stats.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/fitness_program.dart';

class FitnessDataDatasource {
  Future<DailyStats> getDailyStats() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    return DailyStats(
      date: DateTime(2021, 7, 8),
      calories: 1883,
      distance: 7580,
      steps: 9832,
      points: 1248,
      weeklyCalories: const [800, 650, 750, 1000, 1883, 900, 700],
    );
  }

  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      WorkoutPlan(
        id: "1",
        title: "Body Weight",
        subtitle: "Workout",
        week: "WEEK 1",
        currentWorkout: 1,
        totalWorkouts: 5,
        nextExercise: "Lower Strength",
        isActive: true,
      ),
    ];
  }

  Future<List<FitnessProgram>> getFitnessPrograms() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      FitnessProgram(
        id: "1",
        title: "Special",
        type: "special",
        iconPath: "",
        color: "green",
      ),
      FitnessProgram(
        id: "2",
        title: "Beach Ready",
        type: "beach",
        iconPath: "",
        color: "blue",
      ),
      FitnessProgram(
        id: "3",
        title: "Full - Body",
        type: "fullbody",
        iconPath: "",
        color: "teal",
      ),
      FitnessProgram(
        id: "4",
        title: "Challenged",
        type: "challenge",
        iconPath: "",
        color: "purple",
      ),
    ];
  }
}
