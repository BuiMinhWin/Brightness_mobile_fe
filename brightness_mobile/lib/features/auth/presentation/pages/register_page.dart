import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../controllers/register_controller.dart';
import 'dart:math' as math;

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    _buildLogo(),
                    const SizedBox(height: 20),
                    _buildSignUpTitle(),
                    const SizedBox(height: 25),
                    _buildRegisterForm(context),
                    const SizedBox(height: 20),
                    _buildTermsAndPrivacy(),
                    const SizedBox(height: 25),
                    _buildSignUpButton(context),
                    const SizedBox(height: 20),
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

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF05644C), // Light green
            Color.fromARGB(255, 64, 155, 69), // Medium green
            Color(0xFFE2F043), // Dark green
          ],
        ),
      ),
      child: Stack(
        children: [
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
              'assets/images/logo_white.png',
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
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255), // Yellow
                  letterSpacing: 1.2,
                ),
              ),
              TextSpan(
                text: 'NEST',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255),
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
    return const Text(
      'Sign up',
      style: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w500,
        color: Colors.white,
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
            const SizedBox(height: 16),
            
            // // Username field
            // _buildInputField(
            //   controller: controller.usernameController,
            //   hintText: 'Username',
            //   icon: Icons.person_outline,
            // ),
            // const SizedBox(height: 16),
            
            // // Full Name field
            // _buildInputField(
            //   controller: controller.fullNameController,
            //   hintText: 'Full Name',
            //   icon: Icons.badge_outlined,
            // ),
            // const SizedBox(height: 16),
            
            // // Phone Number field
            // _buildInputField(
            //   controller: controller.phoneController,
            //   hintText: 'Phone Number',
            //   icon: Icons.phone_outlined,
            //   keyboardType: TextInputType.phone,
            // ),
            // const SizedBox(height: 16),
            
            // // Date of Birth field
            // GestureDetector(
            //   onTap: () => _selectDate(context, controller),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25),
            //       border: Border.all(
            //         color: Colors.white,
            //         width: 1.5,
            //       ),
            //     ),
            //     child: TextFormField(
            //       controller: controller.dateOfBirthController,
            //       enabled: false,
            //       style: const TextStyle(color: Colors.white),
            //       decoration: InputDecoration(
            //         hintText: 'Date of Birth',
            //         hintStyle: TextStyle(
            //           color: Colors.white.withOpacity(0.7),
            //           fontSize: 16,
            //         ),
            //         prefixIcon: Icon(
            //           Icons.calendar_today_outlined,
            //           color: Colors.white.withOpacity(0.7),
            //         ),
            //         border: InputBorder.none,
            //         contentPadding: const EdgeInsets.symmetric(
            //           horizontal: 20,
            //           vertical: 16,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16),
            
            // // Gender dropdown
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(25),
            //     border: Border.all(
            //       color: Colors.white,
            //       width: 1.5,
            //     ),
            //   ),
            //   child: DropdownButtonFormField<String>(
            //     value: controller.selectedGender,
            //     dropdownColor: const Color(0xFF4CAF50),
            //     style: const TextStyle(color: Colors.white),
            //     decoration: InputDecoration(
            //       hintText: 'Gender',
            //       hintStyle: TextStyle(
            //         color: Colors.white.withOpacity(0.7),
            //         fontSize: 16,
            //       ),
            //       prefixIcon: Icon(
            //         Icons.person_2_outlined,
            //         color: Colors.white.withOpacity(0.7),
            //       ),
            //       border: InputBorder.none,
            //       contentPadding: const EdgeInsets.symmetric(
            //         horizontal: 20,
            //         vertical: 16,
            //       ),
            //     ),
            //     items: ['Male', 'Female', 'Other'].map((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value, style: const TextStyle(color: Colors.white)),
            //       );
            //     }).toList(),
            //     onChanged: controller.setGender,
            //   ),
            // ),
            // const SizedBox(height: 16),
            
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
            const SizedBox(height: 16),
            
            // Confirm Password field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: !controller.isConfirmPasswordVisible,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
                      controller.isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.7),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, RegisterController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4CAF50),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.setDateOfBirth(picked);
    }
  }

  Widget _buildTermsAndPrivacy() {
    return Row(
      children: [
        Consumer<RegisterController>(
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: 'Terms of use',
                  style: const TextStyle(
                    color: Color(0xFFFFEB3B), // Yellow
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
                  style: const TextStyle(
                    color: Color(0xFFFFEB3B), // Yellow
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
        return Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.signUp(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAEFFC4), // Light green
              foregroundColor: Colors.black, // Dark text
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
                    'Sign up',
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

  Widget _buildAlternativeSignUp() {
    return Column(
      children: [
        const Text(
          'or Sign Up with',
          style: TextStyle(
            color: Color(0xFF004643),
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
                // Google sign up
              },
            ),
            const SizedBox(width: 20),
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: 'Back To Sign In',
            style: const TextStyle(
              color: Color(0xFF004643),
              fontWeight: FontWeight.w600,
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