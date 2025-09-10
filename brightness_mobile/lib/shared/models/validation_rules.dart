
class ValidationRules {
  // Common validation patterns
  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String urlPattern = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';
  static const String namePattern = r'^[a-zA-Z\s]+$';

  // Validation functions
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(emailPattern);
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove all non-digit characters except +
    final cleanPhone = value.replaceAll(RegExp(r'[^\d+]'), '');
    
    if (cleanPhone.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    
    if (cleanPhone.length > 15) {
      return 'Phone number cannot exceed 15 digits';
    }
    
    return null;
  }

  static String? validateName(String? value, {String? fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    
    if (value.trim().length > 50) {
      return '$fieldName cannot exceed 50 characters';
    }
    
    final nameRegex = RegExp(namePattern);
    if (!nameRegex.hasMatch(value.trim())) {
      return '$fieldName can only contain letters and spaces';
    }
    
    return null;
  }

  static String? validateFirstName(String? value) {
    return validateName(value, fieldName: 'First name');
  }

  static String? validateLastName(String? value) {
    return validateName(value, fieldName: 'Last name');
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    
    if (value.length > 128) {
      return 'Password cannot exceed 128 characters';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? validateURL(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // URL is optional
    }
    
    final urlRegex = RegExp(urlPattern);
    if (!urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  static String? validateWebsite(String? value) {
    return validateURL(value);
  }

  static String? validateBio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Bio is optional
    }
    
    if (value.trim().length > 500) {
      return 'Bio cannot exceed 500 characters';
    }
    
    return null;
  }

  static String? validateDateOfBirth(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Date of birth is optional
    }
    
    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      final age = now.year - date.year;
      
      if (age < 13) {
        return 'You must be at least 13 years old';
      }
      
      if (age > 120) {
        return 'Please enter a valid date of birth';
      }
      
      if (date.isAfter(now)) {
        return 'Date of birth cannot be in the future';
      }
      
    } catch (e) {
      return 'Please enter a valid date';
    }
    
    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Gender is optional
    }
    
    final validGenders = ['male', 'female', 'other', 'prefer_not_to_say'];
    if (!validGenders.contains(value.toLowerCase())) {
      return 'Please select a valid gender';
    }
    
    return null;
  }

  static String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Location is optional
    }
    
    if (value.trim().length > 100) {
      return 'Location cannot exceed 100 characters';
    }
    
    return null;
  }

  static String? validateOccupation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Occupation is optional
    }
    
    if (value.trim().length > 100) {
      return 'Occupation cannot exceed 100 characters';
    }
    
    return null;
  }

  static String? validateCompany(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Company is optional
    }
    
    if (value.trim().length > 100) {
      return 'Company name cannot exceed 100 characters';
    }
    
    return null;
  }

  static String? validateMinLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.trim().length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }
    
    return null;
  }

  static String? validateMaxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return null; // Empty values are handled by required validation
    }
    
    if (value.trim().length > maxLength) {
      return '${fieldName ?? 'This field'} cannot exceed $maxLength characters';
    }
    
    return null;
  }

  static String? validateRange(String? value, int minLength, int maxLength, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final length = value.trim().length;
    if (length < minLength || length > maxLength) {
      return '${fieldName ?? 'This field'} must be between $minLength and $maxLength characters';
    }
    
    return null;
  }

  static String? validateNumeric(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (double.tryParse(value.trim()) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    return null;
  }

  static String? validateInteger(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (int.tryParse(value.trim()) == null) {
      return '${fieldName ?? 'This field'} must be a valid integer';
    }
    
    return null;
  }

  static String? validatePositiveNumber(String? value, {String? fieldName}) {
    final numericError = validateNumeric(value, fieldName: fieldName);
    if (numericError != null) return numericError;
    
    final number = double.parse(value!.trim());
    if (number <= 0) {
      return '${fieldName ?? 'This field'} must be greater than 0';
    }
    
    return null;
  }

  static String? validateAge(String? value) {
    final numericError = validateInteger(value, fieldName: 'Age');
    if (numericError != null) return numericError;
    
    final age = int.parse(value!.trim());
    if (age < 13) {
      return 'You must be at least 13 years old';
    }
    
    if (age > 120) {
      return 'Please enter a valid age';
    }
    
    return null;
  }

  // Custom validation for specific use cases
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    
    final username = value.trim();
    
    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }
    
    if (username.length > 30) {
      return 'Username cannot exceed 30 characters';
    }
    
    // Username can only contain letters, numbers, underscores, and hyphens
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!usernameRegex.hasMatch(username)) {
      return 'Username can only contain letters, numbers, underscores, and hyphens';
    }
    
    // Username cannot start or end with underscore or hyphen
    if (username.startsWith('_') || username.startsWith('-') ||
        username.endsWith('_') || username.endsWith('-')) {
      return 'Username cannot start or end with underscore or hyphen';
    }
    
    return null;
  }

  static String? validateInterests(List<String>? interests) {
    if (interests == null || interests.isEmpty) {
      return null; // Interests are optional
    }
    
    if (interests.length > 10) {
      return 'You can select up to 10 interests';
    }
    
    for (final interest in interests) {
      if (interest.trim().isEmpty) {
        return 'Interest cannot be empty';
      }
      
      if (interest.trim().length > 50) {
        return 'Interest cannot exceed 50 characters';
      }
    }
    
    return null;
  }

  // Form validation helper
  static Map<String, String?> validateProfileForm({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? bio,
    String? location,
    String? website,
    String? occupation,
    String? company,
    List<String>? interests,
  }) {
    return {
      'firstName': validateFirstName(firstName),
      'lastName': validateLastName(lastName),
      'email': validateEmail(email),
      'phoneNumber': validatePhoneNumber(phoneNumber),
      'dateOfBirth': validateDateOfBirth(dateOfBirth),
      'gender': validateGender(gender),
      'bio': validateBio(bio),
      'location': validateLocation(location),
      'website': validateWebsite(website),
      'occupation': validateOccupation(occupation),
      'company': validateCompany(company),
      'interests': validateInterests(interests),
    };
  }

  // Check if form is valid
  static bool isFormValid(Map<String, String?> errors) {
    return errors.values.every((error) => error == null);
  }

  // Get first error message
  static String? getFirstError(Map<String, String?> errors) {
    for (final error in errors.values) {
      if (error != null) return error;
    }
    return null;
  }

  // Get all error messages
  static List<String> getAllErrors(Map<String, String?> errors) {
    return errors.values.where((error) => error != null).cast<String>().toList();
  }
}

// Extension for easy validation
extension ValidationExtension on String? {
  String? validateRequired({String? fieldName}) {
    return ValidationRules.validateRequired(this, fieldName: fieldName);
  }

  String? validateEmail() {
    return ValidationRules.validateEmail(this);
  }

  String? validatePhoneNumber() {
    return ValidationRules.validatePhoneNumber(this);
  }

  String? validateName({String? fieldName = 'Name'}) {
    return ValidationRules.validateName(this, fieldName: fieldName);
  }

  String? validateFirstName() {
    return ValidationRules.validateFirstName(this);
  }

  String? validateLastName() {
    return ValidationRules.validateLastName(this);
  }

  String? validatePassword() {
    return ValidationRules.validatePassword(this);
  }

  String? validateURL() {
    return ValidationRules.validateURL(this);
  }

  String? validateBio() {
    return ValidationRules.validateBio(this);
  }

  String? validateDateOfBirth() {
    return ValidationRules.validateDateOfBirth(this);
  }

  String? validateGender() {
    return ValidationRules.validateGender(this);
  }

  String? validateLocation() {
    return ValidationRules.validateLocation(this);
  }

  String? validateOccupation() {
    return ValidationRules.validateOccupation(this);
  }

  String? validateCompany() {
    return ValidationRules.validateCompany(this);
  }

  String? validateMinLength(int minLength, {String? fieldName}) {
    return ValidationRules.validateMinLength(this, minLength, fieldName: fieldName);
  }

  String? validateMaxLength(int maxLength, {String? fieldName}) {
    return ValidationRules.validateMaxLength(this, maxLength, fieldName: fieldName);
  }

  String? validateRange(int minLength, int maxLength, {String? fieldName}) {
    return ValidationRules.validateRange(this, minLength, maxLength, fieldName: fieldName);
  }

  String? validateNumeric({String? fieldName}) {
    return ValidationRules.validateNumeric(this, fieldName: fieldName);
  }

  String? validateInteger({String? fieldName}) {
    return ValidationRules.validateInteger(this, fieldName: fieldName);
  }

  String? validatePositiveNumber({String? fieldName}) {
    return ValidationRules.validatePositiveNumber(this, fieldName: fieldName);
  }

  String? validateUsername() {
    return ValidationRules.validateUsername(this);
  }
}
