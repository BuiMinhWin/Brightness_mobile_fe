import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'dart:math' as math;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with circular patterns
          _buildBackground(),
          // Login form content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    _buildLogo(),
                    const SizedBox(height: 30),
                    _buildSignInTitle(),
                    const SizedBox(height: 35),
                    _buildLoginForm(context),
                    const SizedBox(height: AppTheme.spacingL),
                    _buildForgotPassword(),
                    const SizedBox(height: 15),
                    _buildTermsAndPrivacy(),
                    const SizedBox(height: 30),
                    _buildSignInButton(context),
                    const SizedBox(height: AppTheme.spacingL),
                    _buildAlternativeSignIn(),
                    const SizedBox(height: AppTheme.spacingXL),
                    _buildSignUpSection(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildBackground() {
  return Container(
    decoration: const BoxDecoration(
      gradient: AppColors.customGradientLogin,
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

  Widget _buildCircularPattern(double size, double opacity) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CircularPatternPainter(opacity: opacity),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        // Logo JPG
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.0),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
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
                  fontSize: AppTheme.fontSizeL + 6,
                  fontWeight: AppTheme.fontWeightBold,
                  color: AppColors.bright,
                  letterSpacing: 1.2,
                ),
              ),
              TextSpan(
                text: 'NEST',
                style: AppTextStyles.h2.copyWith(
                  fontSize: AppTheme.fontSizeL + 6,
                  fontWeight: AppTheme.fontWeightBold,
                  color: AppColors.customGradientStart,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignInTitle() {
    return Text(
      'Sign in',
      style: AppTextStyles.h1.copyWith(
        fontSize: 70,
        fontWeight: AppTheme.fontWeightMedium,
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return Column(
          children: [
            // Email/Username field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.white,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.emailController,
                style: AppTextStyles.body1.copyWith(color: AppColors.white),
                decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: 'Email or User Name',
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
          ],
        );
      },
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigate to forgot password
        },
        child: Text(
          'Forget Password ?',
          style: AppTextStyles.body1.copyWith(
            color: AppColors.white.withOpacity(0.9),
            fontWeight: AppTheme.fontWeightMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Row(
      children: [
        Consumer<LoginController>(
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
                    color: AppColors.customGradientEnd,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppColors.customGradientEnd,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return SizedBox(
          width: double.infinity,
          height: AppTheme.buttonHeightL,
          child: ElevatedButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.signIn(context),
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
                    'Sign in',
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

  Widget _buildAlternativeSignIn() {
    return Column(
      children: [
        Text(
          'or Sign In with',
          style: AppTextStyles.body1.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM + 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              assetPath: 'assets/images/google.png',
              onPressed: () {
                // Google sign in
              },
            ),
            const SizedBox(width: AppTheme.spacingM + 4),
            _buildSocialButton(
              assetPath: 'assets/images/facebook.png',
              onPressed: () {
                // Facebook sign in
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

  Widget _buildSignUpSection(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have account ? ",
        style: AppTextStyles.body1.copyWith(
          color: AppColors.white,
        ),
        children: [
          TextSpan(
            text: 'Sign Up',
            style: AppTextStyles.body1.copyWith(
              color: AppColors.white,
              fontWeight: AppTheme.fontWeightSemiBold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to RegisterPage
                Navigator.pushNamed(context, '/register');
              },
          ),
        ],
      ),
    );
  }
}

// Custom painter for circular patterns
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