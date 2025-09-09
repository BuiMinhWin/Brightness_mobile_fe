import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    _buildLogo(),
                    const SizedBox(height: 30),
                    _buildSignInTitle(),
                    const SizedBox(height: 35),
                    _buildLoginForm(context),
                    const SizedBox(height: 24),
                    _buildForgotPassword(),
                    const SizedBox(height: 15),
                    _buildTermsAndPrivacy(),
                    const SizedBox(height: 30),
                    _buildSignInButton(context),
                    const SizedBox(height: 24),
                    _buildAlternativeSignIn(),
                    const SizedBox(height: 32),
                    _buildSignUpSection(context), // có thể thay đổi tùy theo cách gọi nút
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
      decoration: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE2F043), // Light green
          Color.fromARGB(255, 64, 155, 69), // Medium green
          Color(0xFF05644C), // Dark green
        ],
      ).createShader(
        const Rect.fromLTRB(0, 0, 1, 1),
      ) != null
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE2F043), // Light green
                  Color.fromARGB(255, 64, 155, 69), // Medium green
                  Color(0xFF05644C), // Dark green
                ],
              ),
            )
          : const BoxDecoration(
              color: Color(0xFF4CAF50),
            ),
      child: Stack(
        children: [
          // Circular pattern SVG elements
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
    return Container(
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
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 16),
      // BrightNest text
      RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'BRIGHT',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFED700), // Yellow
                letterSpacing: 1.2,
              ),
            ),
            TextSpan(
              text: 'NEST',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF095747),
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
    return const Text(
      'Sign in',
      style: TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.w500,
        color: Colors.white,
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
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email or User Name',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Password field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
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
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontWeight: FontWeight.w500,
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
              fillColor: MaterialStateProperty.all(Colors.white),
              checkColor: const Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'By creating an account, I agree to our ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: 'Terms of use',
                  style: TextStyle(
                    color: Color(0xFFFFEB3B), // Yellow
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFFFFEB3B), // Yellow
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
        return Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.signIn(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAEFFC4), // Light green
              foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Dark green text
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            child: controller.isLoading
                ? const CircularProgressIndicator(
                    color: Color(0xFF2E7D32),
                  )
                : const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
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
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialButton(
            assetPath: 'assets/images/google.png',
            onPressed: () {
              // Google sign in
            },
          ),
          const SizedBox(width: 20),
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
    width: 64, // tăng kích thước
    height: 64,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: IconButton(
      onPressed: onPressed,
      icon: Image.asset(
        assetPath,
        width: 38,  // logo to hơn
        height: 38,
        fit: BoxFit.contain,
      ),
    ),
  );
}

  // Widget _buildSignUpSection() {
  //   return RichText(
  //     text: TextSpan(
  //       text: "Don't have account ? ",
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 16,
  //       ),
  //       children: [
  //         TextSpan(
  //           text: 'Sign Up',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
 Widget _buildSignUpSection(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have account ? ",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.w600,
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
      ..color = Colors.white.withOpacity(opacity)
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
      ..color = Colors.white.withOpacity(opacity * 0.7)
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