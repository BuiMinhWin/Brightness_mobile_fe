import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Updated to match design
  static const Color primaryColor = Color(
    0xFF242760,
  ); // Dark purple/blue from design
  static const Color secondaryColor = Color(
    0xFFAEFFC4,
  ); // Green for save button
  static const Color feedBarColor = Color(0xFF16A34A); // Green for feed bar
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);

  // Background Colors
  static const Color backgroundColor = Color(
    0xFFFFFFFF,
  ); // Pure white background
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937); // Dark text
  static const Color textSecondary = Color(0xFF6B7280); // Medium gray
  static const Color textHint = Color(
    0xFF9CA3AF,
  ); // Light gray for placeholders

  // Border Colors
  static const Color borderColor = Color(0xFFE5E7EB); // Light gray border
  static const Color borderFocusedColor = Color(0xFF6B46C1); // Purple focus
  static const Color borderErrorColor = Color(0xFFEF4444);

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusCircular = 50.0;

  // Font Sizes
  static const double fontSizeXS = 12.0;
  static const double fontSizeS = 14.0;
  static const double fontSizeM = 16.0;
  static const double fontSizeL = 18.0;
  static const double fontSizeXL = 20.0;
  static const double fontSizeXXL = 24.0;
  static const double fontSizeTitle = 28.0;

  // Font Weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;

  // Icon Sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;

  // Button Heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;

  // Input Field Heights
  static const double inputHeightM = 48.0;
  static const double inputHeightL = 56.0;

  // Avatar Sizes
  static const double avatarSizeS = 40.0;
  static const double avatarSizeM = 60.0;
  static const double avatarSizeL = 80.0;
  static const double avatarSizeXL = 120.0;

  // Avatar sizes New
  static const double avatarS = 32;
  static const double avatarM = 40;
  static const double avatarL = 56;

  // Shadow
  static const double shadowBlur = 4;
  static const double shadowOffset = 2;

  // Text Styles
  static const TextStyle textStyleHeadline1 = TextStyle(
    fontSize: fontSizeTitle,
    fontWeight: fontWeightBold,
    color: textPrimary,
  );

  static const TextStyle textStyleHeadline2 = TextStyle(
    fontSize: fontSizeXXL,
    fontWeight: fontWeightSemiBold,
    color: textPrimary,
  );

  static const TextStyle textStyleHeadline3 = TextStyle(
    fontSize: fontSizeXL,
    fontWeight: fontWeightSemiBold,
    color: textPrimary,
  );

  static const TextStyle textStyleBody1 = TextStyle(
    fontSize: fontSizeM,
    fontWeight: fontWeightRegular,
    color: textPrimary,
  );

  static const TextStyle textStyleBody2 = TextStyle(
    fontSize: fontSizeS,
    fontWeight: fontWeightRegular,
    color: textSecondary,
  );

  static const TextStyle textStyleCaption = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: fontWeightRegular,
    color: textSecondary,
  );

  static const TextStyle textStyleButton = TextStyle(
    fontSize: fontSizeM,
    fontWeight: fontWeightMedium,
    color: surfaceColor,
  );

  static const TextStyle textStyleLabel = TextStyle(
    fontSize: fontSizeS,
    fontWeight: fontWeightMedium,
    color: textPrimary,
  );

  static const TextStyle textStyleError = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: fontWeightRegular,
    color: errorColor,
  );

  // Input Decoration - Updated to match design
  static InputDecoration inputDecoration({
    required String label,
    String? hint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isError = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: false, // No fill to match design
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusM),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusM),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusM),
        borderSide: const BorderSide(color: borderFocusedColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusM),
        borderSide: const BorderSide(color: borderErrorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusM),
        borderSide: const BorderSide(color: borderErrorColor, width: 1.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingM,
        vertical: spacingM,
      ),
      labelStyle: textStyleLabel.copyWith(
        color: textPrimary,
        fontWeight: fontWeightMedium,
      ),
      hintStyle: textStyleCaption.copyWith(color: textHint),
    );
  }

  // Button Style
  static ButtonStyle primaryButtonStyle({
    double? height,
    double? width,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? primaryColor,
      foregroundColor: foregroundColor ?? surfaceColor,
      elevation: elevationS,
      shadowColor: primaryColor.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusM),
      ),
      minimumSize: Size(width ?? double.infinity, height ?? buttonHeightM),
      textStyle: textStyleButton,
    );
  }

  static ButtonStyle secondaryButtonStyle({double? height, double? width}) {
    return OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusM),
      ),
      minimumSize: Size(width ?? double.infinity, height ?? buttonHeightM),
      textStyle: textStyleButton.copyWith(color: primaryColor),
    );
  }

  // Card Style
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(radiusL),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Section Style
  static BoxDecoration sectionDecoration() {
    return BoxDecoration(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(radiusL),
      border: Border.all(color: borderColor),
    );
  }
}
