// lib/features/yours/data/models/yours.dart
import 'dart:ui';

class DietPlanModel {
  final String id;
  final String title;
  final double progress; // 0.0 to 1.0

  const DietPlanModel({
    required this.id,
    required this.title,
    required this.progress,
  });

  String get progressPercentage => '${(progress * 100).round()}%';
  
  // Additional getters for UI display
  bool get isCompleted => progress >= 1.0;
  bool get isStarted => progress > 0.0;
  
  // Helper method for progress color
  Color get progressColor {
    if (progress < 0.3) return const Color(0xFFFF5722); // Red for low progress
    if (progress < 0.7) return const Color(0xFFFF9800); // Orange for medium progress
    return const Color(0xFF4CAF50); // Green for high progress
  }
  
  // Copy with method for state management
  DietPlanModel copyWith({
    String? id,
    String? title,
    double? progress,
  }) {
    return DietPlanModel(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
    );
  }
  
  // JSON serialization methods (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'progress': progress,
    };
  }
  
  factory DietPlanModel.fromJson(Map<String, dynamic> json) {
    return DietPlanModel(
      id: json['id'] as String,
      title: json['title'] as String,
      progress: (json['progress'] as num).toDouble(),
    );
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietPlanModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          progress == other.progress;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ progress.hashCode;

  @override
  String toString() {
    return 'DietPlanModel(id: $id, title: $title, progress: $progress)';
  }
}