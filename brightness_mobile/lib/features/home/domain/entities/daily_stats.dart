class DailyStats {
  final DateTime date;
  final double calories;
  final double distance; // in meters
  final int steps;
  final int points;
  final List<double> weeklyCalories; // 7 days data for chart

  const DailyStats({
    required this.date,
    required this.calories,
    required this.distance,
    required this.steps,
    required this.points,
    required this.weeklyCalories,
  });
}
