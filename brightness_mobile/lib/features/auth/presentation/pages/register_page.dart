import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../controllers/register_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import 'dart:math' as math;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with circular patterns
          _buildBackground(),
          // Register form content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildLogo(),
                    const SizedBox(height: AppTheme.spacingM + 4),
                    _buildSignUpTitle(),
                    const SizedBox(height: 25),
                    _buildRegisterForm(context),
                    const SizedBox(height: AppTheme.spacingM + 4),
                    _buildTermsAndPrivacy(),
                    const SizedBox(height: 25),
                    _buildSignUpButton(context),
                    const SizedBox(height: AppTheme.spacingM + 4),
                    _buildAlternativeSignUp(),
                    const SizedBox(height: 25),
                    _buildSignInSection(context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildCircularPattern(double size, double opacity) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CircularPatternPainter(opacity: opacity),
      ),
    );
  }

  Widget _buildBackground() {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.customGradientStart,
            Color.fromARGB(255, 64, 155, 69),
            AppColors.customGradientEnd,
          ],
        ),
      ),
    child: Stack(
      children: [
        Positioned.fill(
          child: Transform.translate(
            offset: const Offset(60, -140),
            child: Transform.scale(
              scale: 1.5, 
              child: SvgPicture.asset(
                'assets/images/Background_login.svg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        // Circular pattern elements
        Positioned(
          top: -50,
          right: -100,
          child: _buildCircularPattern(200, 0.1),
        ),
        Positioned(
          top: 100,
          left: -80,
          child: _buildCircularPattern(160, 0.08),
        ),
        Positioned(
          bottom: 200,
          right: -60,
          child: _buildCircularPattern(180, 0.12),
        ),
        Positioned(
          bottom: -100,
          left: -120,
          child: _buildCircularPattern(240, 0.15),
        ),
        Positioned(
          top: 300,
          right: 50,
          child: _buildCircularPattern(100, 0.06),
        ),
      ],
    ),
  );
}

  Widget _buildLogo() {
    return Column(
      children: [
        // Logo JPG
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.0),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo_white.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        // BrightNest text
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'BRIGHT',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 25,
                  fontWeight: AppTheme.fontWeightBold,
                  color: AppColors.white,
                  letterSpacing: 1.2,
                ),
              ),
              TextSpan(
                text: 'NEST',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 25,
                  fontWeight: AppTheme.fontWeightBold,
                  color: AppColors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpTitle() {
    return Text(
      'Sign up',
      style: AppTextStyles.h1.copyWith(
        fontSize: 60,
        fontWeight: AppTheme.fontWeightMedium,
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            // Email field
            _buildInputField(
              controller: controller.emailController,
              hintText: 'Email',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: AppTheme.spacingM),
            
            // Password field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.white,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible,
                style: AppTextStyles.body1.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                fillColor: Colors.transparent,
                hintText: 'Password',
                hintStyle: AppTextStyles.body1.copyWith(
                  color: AppColors.white.withOpacity(0.7),
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.white.withOpacity(0.7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.white, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.white, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM + 4,
                  vertical: AppTheme.spacingM,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            
            // Confirm Password field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.white,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: !controller.isConfirmPasswordVisible,
                style: AppTextStyles.body1.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                fillColor: Colors.transparent,
                hintText: 'Confirm Password',
                hintStyle: AppTextStyles.body1.copyWith(
                  color: AppColors.white.withOpacity(0.7),
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.white.withOpacity(0.7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.white, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: AppColors.white, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM + 4,
                  vertical: AppTheme.spacingM,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool obscureText = false,
  VoidCallback? onSuffixTap,
  bool isPassword = false,
  bool isPasswordVisible = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    style: AppTextStyles.body1.copyWith(color: AppColors.white),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.body1.copyWith(
        color: AppColors.white.withOpacity(0.7),
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.white.withOpacity(0.7),
      ),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.white.withOpacity(0.7),
              ),
              onPressed: onSuffixTap,
            )
          : null,
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.white, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.white, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM + 4,
        vertical: AppTheme.spacingM,
      ),
    ),
  );
}

  Widget _buildTermsAndPrivacy() {
    return Row(
      children: [
        Consumer<RegisterController>(
          builder: (context, controller, child) {
            return Checkbox(
              value: controller.agreeToTerms,
              onChanged: controller.setAgreeToTerms,
              fillColor: WidgetStateProperty.all(AppColors.white),
              checkColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
              ),
            );
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'By creating an account, I agree to our ',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.white,
                fontSize: AppTheme.fontSizeS + 1,
              ),
              children: [
                TextSpan(
                  text: 'Terms of use',
                  style: TextStyle(
                    color: AppColors.bright,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to Terms of use
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppColors.bright,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigate to Privacy Policy
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return SizedBox(
          width: double.infinity,
          height: AppTheme.buttonHeightL,
          child: ElevatedButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.signUp(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor,
              foregroundColor: AppTheme.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: controller.isLoading
                ? CircularProgressIndicator(
                    color: AppTheme.textPrimary,
                  )
                : Text(
                    'Sign up',
                    style: AppTextStyles.button.copyWith(
                      color: AppTheme.textPrimary,
                      fontSize: 25,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildAlternativeSignUp() {
    return Column(
      children: [
        Text(
          'or Sign Up with',
          style: AppTextStyles.body1.copyWith(
            color: AppColors.customGradientStart,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM + 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              assetPath: 'assets/images/google.png',
              onPressed: () {
                // Google sign up
              },
            ),
            const SizedBox(width: AppTheme.spacingM + 4),
            _buildSocialButton(
              assetPath: 'assets/images/facebook.png',
              onPressed: () {
                // Facebook sign up
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String assetPath,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.textPrimary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          assetPath,
          width: 38,
          height: 38,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildSignInSection(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Already have account ? ",
        style: AppTextStyles.body1.copyWith(
          color: AppColors.customGradientStart,
        ),
        children: [
          TextSpan(
            text: 'Back To Sign In',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.customGradientStart,
              fontWeight: AppTheme.fontWeightSemiBold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate back to LoginPage
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }
}

// Custom painter for circular patterns (reused from LoginPage)
class CircularPatternPainter extends CustomPainter {
  final double opacity;

  CircularPatternPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw multiple concentric circles
    for (int i = 1; i <= 4; i++) {
      final radius = maxRadius * (i / 4);
      canvas.drawCircle(center, radius, paint);
    }

    // Add some decorative dots
    final dotPaint = Paint()
      ..color = AppColors.white.withOpacity(opacity * 0.7)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (3.14159 / 180);
      final x = center.dx + (maxRadius * 0.8) * math.cos(angle);
      final y = center.dy + (maxRadius * 0.8) * math.sin(angle);
      canvas.drawCircle(Offset(x, y), 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}