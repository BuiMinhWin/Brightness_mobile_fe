import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../shared/models/profile_model.dart';
import '../../../../shared/models/validation_rules.dart';
import '../../../../shared/services/user_profile_data_service.dart';

class EditProfileController extends ChangeNotifier {

  EditProfileController();

  // State variables
  ProfileModel? _profile;
  ProfileFormData _formData = ProfileFormData();
  File? _selectedImage;
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isUploadingImage = false;
  String? _errorMessage;
  String? _successMessage;
  Map<String, String?> _validationErrors = {};

  // Getters
  ProfileModel? get profile => _profile;
  ProfileFormData get formData => _formData;
  File? get selectedImage => _selectedImage;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  bool get isUploadingImage => _isUploadingImage;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  Map<String, String?> get validationErrors => _validationErrors;
  bool get hasChanges => _formData.hasChanges || _selectedImage != null;
  bool get isFormValid => ValidationRules.isFormValid(_validationErrors);

  // Initialize controller
  Future<void> initialize() async {
    await loadProfile();
  }

  // Load profile data
  Future<void> loadProfile() async {
    _setLoading(true);
    _clearMessages();

    try {
      // Load profile data from JSON service
      final editProfileData = await UserProfileDataService.getEditProfileData();
      
      // Convert EditProfileData to ProfileFormData
      _formData = ProfileFormData(
        firstName: editProfileData.firstName,
        lastName: editProfileData.lastName,
        email: editProfileData.email,
        phoneNumber: editProfileData.phoneNumber,
        dateOfBirth: editProfileData.dateOfBirth,
        bio: editProfileData.bio,
        location: editProfileData.location,
        website: editProfileData.website,
        occupation: editProfileData.occupation,
        interests: editProfileData.interests,
      );
      
      _validateForm();
    } catch (e) {
      _setError('An unexpected error occurred: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update form field
  void updateField(String field, String? value) {
    switch (field) {
      case 'firstName':
        _formData = _formData.copyWith(firstName: value);
      case 'lastName':
        _formData = _formData.copyWith(lastName: value);
      case 'email':
        _formData = _formData.copyWith(email: value);
      case 'phoneNumber':
        _formData = _formData.copyWith(phoneNumber: value);
      case 'dateOfBirth':
        _formData = _formData.copyWith(dateOfBirth: value);
      case 'gender':
        _formData = _formData.copyWith(gender: value);
      case 'bio':
        _formData = _formData.copyWith(bio: value);
      case 'location':
        _formData = _formData.copyWith(location: value);
      case 'website':
        _formData = _formData.copyWith(website: value);
      case 'occupation':
        _formData = _formData.copyWith(occupation: value);
      case 'company':
        _formData = _formData.copyWith(company: value);
      case 'hobby':
        // Handle hobby as first interest
        final interests = value != null ? <String>[value] : <String>[];
        _formData = _formData.copyWith(interests: interests);
    }
    
    _validateField(field);
    notifyListeners();
  }

  // Update interests
  void updateInterests(List<String> interests) {
    _formData = _formData.copyWith(interests: interests);
    _validateField('interests');
    notifyListeners();
  }

  // Set selected image
  void setSelectedImage(File? image) {
    _selectedImage = image;
    notifyListeners();
  }

  // Validate specific field
  void _validateField(String field) {
    String? error;
    
    switch (field) {
      case 'firstName':
        error = ValidationRules.validateFirstName(_formData.firstName);
      case 'lastName':
        error = ValidationRules.validateLastName(_formData.lastName);
      case 'email':
        error = ValidationRules.validateEmail(_formData.email);
      case 'phoneNumber':
        error = ValidationRules.validatePhoneNumber(_formData.phoneNumber);
      case 'dateOfBirth':
        error = ValidationRules.validateDateOfBirth(_formData.dateOfBirth);
      case 'gender':
        error = ValidationRules.validateGender(_formData.gender);
      case 'bio':
        error = ValidationRules.validateBio(_formData.bio);
      case 'location':
        error = ValidationRules.validateLocation(_formData.location);
      case 'website':
        error = ValidationRules.validateWebsite(_formData.website);
      case 'occupation':
        error = ValidationRules.validateOccupation(_formData.occupation);
      case 'company':
        error = ValidationRules.validateCompany(_formData.company);
      case 'interests':
        error = ValidationRules.validateInterests(_formData.interests);
    }
    
    _validationErrors[field] = error;
  }

  // Validate entire form
  void _validateForm() {
    _validationErrors = ValidationRules.validateProfileForm(
      firstName: _formData.firstName,
      lastName: _formData.lastName,
      email: _formData.email,
      phoneNumber: _formData.phoneNumber,
      dateOfBirth: _formData.dateOfBirth,
      gender: _formData.gender,
      bio: _formData.bio,
      location: _formData.location,
      website: _formData.website,
      occupation: _formData.occupation,
      company: _formData.company,
      interests: _formData.interests,
    );
  }

  // Save profile
  Future<bool> saveProfile() async {
    if (!isFormValid) {
      _setError('Please fix the validation errors before saving');
      return false;
    }

    _setSaving(true);
    _clearMessages();

    try {
      // Convert ProfileFormData to EditProfileData
      final editProfileData = EditProfileData(
        userId: _profile?.id ?? 'user_001',
        firstName: _formData.firstName,
        lastName: _formData.lastName,
        email: _formData.email,
        phoneNumber: _formData.phoneNumber,
        dateOfBirth: _formData.dateOfBirth,
        bio: _formData.bio,
        location: _formData.location,
        website: _formData.website,
        occupation: _formData.occupation,
        interests: _formData.interests,
        profileImageUrl: _profile?.profileImageUrl,
      );

      // Save using data service
      final success = await UserProfileDataService.saveEditProfileData(editProfileData);
      
      if (success) {
        _setSuccess('Profile updated successfully!');
        return true;
      } else {
        _setError('Failed to save profile');
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      return false;
    } finally {
      _setSaving(false);
    }
  }

  // Reset form to original values
  void resetForm() {
    if (_profile != null) {
      _formData = ProfileFormData.fromProfile(_profile!);
      _selectedImage = null;
      _validateForm();
      _clearMessages();
      notifyListeners();
    } else {
      // If no profile is loaded, reset to empty form
      _formData = ProfileFormData();
      _selectedImage = null;
      _validateForm();
      _clearMessages();
      notifyListeners();
    }
  }

  // Clear all messages
  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  // Set error message
  void _setError(String message) {
    _errorMessage = message;
    _successMessage = null;
    notifyListeners();
  }

  // Set success message
  void _setSuccess(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set saving state
  void _setSaving(bool saving) {
    _isSaving = saving;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear success message
  void clearSuccess() {
    _successMessage = null;
    notifyListeners();
  }

  // Get field error
  String? getFieldError(String field) {
    return _validationErrors[field];
  }

  // Check if field has error
  bool hasFieldError(String field) {
    return _validationErrors[field] != null;
  }

  // Get validation summary
  String? getValidationSummary() {
    final errors = ValidationRules.getAllErrors(_validationErrors);
    if (errors.isEmpty) return null;
    
    if (errors.length == 1) {
      return errors.first;
    }
    
    return 'Please fix ${errors.length} validation errors';
  }

}

// Factory function for dependency injection
EditProfileController createEditProfileController() {
  return EditProfileController();
}
