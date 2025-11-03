import 'package:brightness_mobile/app/router.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  LoginController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get agreeToTerms => _agreeToTerms;
  String? get errorMessage => _errorMessage;

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Set agree to terms
  void setAgreeToTerms(bool? value) {
    _agreeToTerms = value ?? false;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Validate form
  bool _validateForm() {
    if (emailController.text.trim().isEmpty) {
      _errorMessage = 'Email or username is required';
      notifyListeners();
      return false;
    }

    if (passwordController.text.isEmpty) {
      _errorMessage = 'Password is required';
      notifyListeners();
      return false;
    }

    if (!_agreeToTerms) {
      _errorMessage = 'Please agree to Terms of Use and Privacy Policy';
      notifyListeners();
      return false;
    }

    return true;
  }

  // Sign in method
  Future<void> signIn(BuildContext context) async {
    if (!_validateForm()) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _loginUseCase.execute(
        emailController.text.trim(),
        passwordController.text,
      );

      result.fold(
        (failure) {
          _errorMessage = failure.message;
          _isLoading = false;
          notifyListeners();

          // Show error snackbar
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_errorMessage!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        (authToken) {
          _isLoading = false;
          notifyListeners();

          // Navigate to home or dashboard
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, AppRouter.home);
          }
        },
      );
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Logout method
  Future<void> logout(BuildContext context) async {
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _logoutUseCase.execute();

      result.fold(
        (failure) {
          _errorMessage = failure.message;
          notifyListeners();

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_errorMessage!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        (_) {
          emailController.clear();
          passwordController.clear();
          _agreeToTerms = false;
          _isLoading = false;
          _isPasswordVisible = false;
          _errorMessage = null;
          notifyListeners();

          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.login,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      _errorMessage = 'Failed to log out. Please try again.';
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  // Social sign in methods
  Future<void> signInWithGoogle() async {
    // Implement Google sign in
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithFacebook() async {
    // Implement Facebook sign in
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
