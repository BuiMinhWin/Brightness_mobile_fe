class WorkoutPlan {
  final String id;
  final String title;
  final String subtitle;
  final String week;
  final int currentWorkout;
  final int totalWorkouts;
  final String nextExercise;
  final bool isActive;

  const WorkoutPlan({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.week,
    required this.currentWorkout,
    required this.totalWorkouts,
    required this.nextExercise,
    required this.isActive,
  });
}
