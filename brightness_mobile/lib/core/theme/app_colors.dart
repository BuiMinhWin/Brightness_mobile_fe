import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00D2AA);
  static const Color primaryLight = Color(0xFF4AE5C3);
  static const Color secondary = Color(0xFF8E44AD);
  static const Color success = Color(0xFF22C55E);
  static const Color lime = Color(0xFFA3E635);

  // Goal colors
  static const Color loseWeightColor = Color(0xFFFF6B35);
  static const Color gainMuscleColor = Color(0xFF4A90E2);
  static const Color maintainHealthColor = Color(0xFF8E44AD);

  // Neutral colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color white = Color(0xFFFFFFFF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, primaryLight],
  );

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7CFF72), Color(0xFF00D084)],
  );
}
