// import 'package:flutter/foundation.dart';

// import '../../domain/entities/auth_token.dart';
// import '../../domain/usecases/login_usecase.dart';

// class LoginController extends ChangeNotifier {
//   final LoginUseCase _login;
//   LoginController({required LoginUseCase login}) : _login = login;

//   bool _loading = false;
//   String? _error;
//   AuthToken? _token;

//   bool get loading => _loading;
//   String? get error => _error;
//   AuthToken? get token => _token;

//   Future<void> submit(String username, String password) async {
//     _loading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       _token = await _login(LoginParams(username: username, password: password));
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _loading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/auth_token.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginController({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase;

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        (authToken) {
          _isLoading = false;
          notifyListeners();
          
          // Navigate to home or dashboard
          // Navigator.pushReplacementNamed(context, '/home');
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
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