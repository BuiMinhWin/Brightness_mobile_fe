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

  // New colors
  static const Color warning = Color(0xFFFFA726); // Orange/Amber
  static const Color successLight = Color(0xFF81C784); // Light green
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color greenlight = Color(0xFFF1F8E9); // Red

  // Icons
  static const Color iconInactive = Color(0xFFBDBDBD);

    // Shadow
  static const Color shadow = Color(0x1A000000); // black with opacity

  // Neutral colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color bright =  Color(0xFFFED700);
  static const Color black = Colors.black;

 // Border & Shadow
  static const Color borderLight = Color(0xFFE0E0E0);

  // Brand / Primary
  static const Color primaryLightBlue = Color(0xFF64B5F6);

  // Success
  static const Color successDark = Color(0xFF2E7D32);

  // Purple
  static const Color purpleDark = Color(0xFF6A1B9A);
  static const Color purpleLight = Color(0xFFBA68C8);

  // Orange
  static const Color orangeDark = Color(0xFFE65100);
  static const Color orangeLight = Color(0xFFFFB74D);

  // Red
  static const Color redDark = Color(0xFFC62828);
  static const Color redLight = Color(0xFFEF5350);

  // Teal
  static const Color tealDark = Color(0xFF00695C);
  static const Color tealLight = Color(0xFF4DB6AC);

   // Brand colors
  static const Color primaryBlue = Color(0xFF2196F3);

  // Custom gradient colors
  static const Color customGradientStart = Color(0xFF05844C); // Dark green
  static const Color customGradientEnd = Color(0xFFE2F043);   // Light yellow-green

  // Existing gradients
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

  // New custom gradient matching the design
  static const LinearGradient customGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.38, 0.88],
    colors: [
      customGradientStart, // #05844C at 38%
      customGradientEnd,   // #E2F043 at 88%
    ],
  );

  // Alternative vertical version
  static const LinearGradient customGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.38, 0.88],
    colors: [
      customGradientStart, // #05844C at 38%
      customGradientEnd,   // #E2F043 at 88%
    ],
  );

  // Radial gradient version for special effects
  static const RadialGradient customRadialGradient = RadialGradient(
    center: Alignment.topLeft,
    radius: 1.5,
    stops: [0.38, 0.88],
    colors: [
      customGradientStart, // #05844C at 38%
      customGradientEnd,   // #E2F043 at 88%
    ],
  );

    static const LinearGradient customGradientLogin = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.05, 0.9],
    colors: [
      customGradientEnd, 
      customGradientStart, 
    ],
  );

  // Alternative vertical version
  static const LinearGradient customGradientVerticalLogin = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.05, 0.9],
    colors: [
     customGradientEnd, 
      customGradientStart,   // #E2F043 at 88%
    ],
  );

  // Radial gradient version for special effects
  static const RadialGradient customRadialGradientLogin = RadialGradient(
    center: Alignment.topLeft,
    radius: 1.5,
    stops: [0.05, 0.9],
    colors: [
     customGradientEnd, 
      customGradientStart, 
    ],
  );
}