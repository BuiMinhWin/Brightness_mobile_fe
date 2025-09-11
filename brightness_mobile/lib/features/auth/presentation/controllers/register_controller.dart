// lib/features/auth/presentation/controllers/register_controller.dart
import 'package:flutter/material.dart';
import '../../domain/usecases/register_usecase.dart';
import 'package:intl/intl.dart';

class RegisterController extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;

  RegisterController({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase;

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // State variables
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = false;
  String? _selectedGender;
  DateTime? _dateOfBirth;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get agreeToTerms => _agreeToTerms;
  String? get selectedGender => _selectedGender;
  DateTime? get dateOfBirth => _dateOfBirth;
  String? get errorMessage => _errorMessage;

  // Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  // Set agree to terms
  void setAgreeToTerms(bool? value) {
    _agreeToTerms = value ?? false;
    notifyListeners();
  }

  // Set gender
  void setGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  // Set date of birth
  void setDateOfBirth(DateTime date) {
    _dateOfBirth = date;
    dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(date);
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Validate form
  bool _validateForm() {
    // Check required fields
    if (emailController.text.trim().isEmpty) {
      _errorMessage = 'Email is required';
      notifyListeners();
      return false;
    }

    if (usernameController.text.trim().isEmpty) {
      _errorMessage = 'Username is required';
      notifyListeners();
      return false;
    }

    if (fullNameController.text.trim().isEmpty) {
      _errorMessage = 'Full name is required';
      notifyListeners();
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      _errorMessage = 'Phone number is required';
      notifyListeners();
      return false;
    }

    if (_dateOfBirth == null) {
      _errorMessage = 'Date of birth is required';
      notifyListeners();
      return false;
    }

    if (_selectedGender == null || _selectedGender!.isEmpty) {
      _errorMessage = 'Gender is required';
      notifyListeners();
      return false;
    }

    if (passwordController.text.isEmpty) {
      _errorMessage = 'Password is required';
      notifyListeners();
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      _errorMessage = 'Please confirm your password';
      notifyListeners();
      return false;
    }

    // Email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(emailController.text.trim())) {
      _errorMessage = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }

    // Phone validation
    final phoneRegExp = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegExp.hasMatch(phoneController.text.trim())) {
      _errorMessage = 'Please enter a valid phone number';
      notifyListeners();
      return false;
    }

    // Password validation
    if (passwordController.text.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      notifyListeners();
      return false;
    }

    // Password confirmation
    if (passwordController.text != confirmPasswordController.text) {
      _errorMessage = 'Passwords do not match';
      notifyListeners();
      return false;
    }

    // Age validation (must be at least 13 years old)
    final now = DateTime.now();
    final age = now.year - _dateOfBirth!.year;
    if (age < 13) {
      _errorMessage = 'You must be at least 13 years old to register';
      notifyListeners();
      return false;
    }

    // Terms and conditions
    if (!_agreeToTerms) {
      _errorMessage = 'Please agree to Terms of Use and Privacy Policy';
      notifyListeners();
      return false;
    }

    return true;
  }

  // Register method
  Future<void> signUp(BuildContext context) async {
    if (!_validateForm()) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _registerUseCase.execute(
        email: emailController.text.trim(),
        password: passwordController.text,
        username: usernameController.text.trim(),
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        gender: _selectedGender,
        dateOfBirth: _dateOfBirth,
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
        (user) {
          _isLoading = false;
          notifyListeners();
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful! Please login.'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          // Navigate back to login page
          Navigator.pushReplacementNamed(context, '/login');
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

  // Social sign up methods
  Future<void> signUpWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    
    // TODO: Implement Google sign up
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUpWithFacebook() async {
    _isLoading = true;
    notifyListeners();
    
    // TODO: Implement Facebook sign up
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}