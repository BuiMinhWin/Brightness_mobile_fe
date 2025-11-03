import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../shared/models/validation_rules.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Country options
  final List<DropdownOption> countryOptions = const [
    DropdownOption(value: 'nigeria', label: 'Nigeria'),
    DropdownOption(value: 'usa', label: 'United States'),
    DropdownOption(value: 'uk', label: 'United Kingdom'),
    DropdownOption(value: 'canada', label: 'Canada'),
    DropdownOption(value: 'australia', label: 'Australia'),
    DropdownOption(value: 'germany', label: 'Germany'),
    DropdownOption(value: 'france', label: 'France'),
    DropdownOption(value: 'japan', label: 'Japan'),
    DropdownOption(value: 'china', label: 'China'),
    DropdownOption(value: 'india', label: 'India'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditProfileController>().initialize();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: Consumer<EditProfileController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          return _buildBody(controller);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(EditProfileController controller) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  _buildProfileSection(controller),
                  const SizedBox(height: 32),
                  _buildFormFields(controller),
                ],
              ),
            ),
          ),
          _buildSaveButton(controller),
        ],
      ),
    );
  }

  Widget _buildProfileSection(EditProfileController controller) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: AppTheme.primaryColor,
                  width: 3,
                ),
              ),
              child: controller.profile != null && controller.profile!.profileImageUrl != null
                  ? ClipOval(
                      child: Image.network(
                        controller.profile!.profileImageUrl!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderAvatar();
                        },
                      ),
                    )
                  : _buildPlaceholderAvatar(),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: GestureDetector(
                onTap: () => _showImageSourceDialog(controller),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceholderAvatar() {
    return const Icon(
      Icons.person,
      size: 60,
      color: Colors.white,
    );
  }

  Widget _buildFormFields(EditProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField(
          label: 'Name',
          value: controller.formData.firstName != null && controller.formData.lastName != null
              ? '${controller.formData.firstName} ${controller.formData.lastName}'
              : null,
          onChanged: (value) {
            // Handle name splitting if needed
            final parts = value.split(' ');
            if (parts.isNotEmpty) {
              controller.updateField('firstName', parts[0]);
              if (parts.length > 1) {
                controller.updateField('lastName', parts.sublist(1).join(' '));
              }
            }
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Email',
          value: controller.formData.email,
          onChanged: (value) => controller.updateField('email', value),
          validator: ValidationRules.validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Password',
          value: '************', // Masked password
          onChanged: (value) {
            // Handle password change
          },
          isPassword: true,
          validator: (value) {
            // Password validation can be optional for editing
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Date of Birth',
          value: controller.formData.dateOfBirth,
          onChanged: (value) => controller.updateField('dateOfBirth', value),
          validator: ValidationRules.validateDateOfBirth,
          readOnly: true,
          onTap: () => _selectDate(controller),
          suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Country/Region',
          value: controller.formData.location,
          onChanged: (value) => controller.updateField('location', value),
          validator: ValidationRules.validateLocation,
          suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.textSecondary),
          onTap: () => _showCountryPicker(controller),
          readOnly: true,
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Hobby',
          value: controller.formData.interests?.isNotEmpty == true 
              ? controller.formData.interests!.first 
              : null,
          onChanged: (value) => controller.updateField('hobby', value),
          validator: (value) => null, // Optional field
        ),
        const SizedBox(height: 20),
        _buildFormField(
          label: 'Job',
          value: controller.formData.occupation,
          onChanged: (value) => controller.updateField('occupation', value),
          validator: ValidationRules.validateOccupation,
        ),
        const SizedBox(height: 40), // Extra space before save button
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    String? value,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: isPassword,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: const TextStyle(
              color: AppTheme.textHint,
              fontSize: 16,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            filled: false,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(EditProfileController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: controller.hasChanges && controller.isFormValid
            ? () => _saveProfile(controller)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: controller.isSaving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Save changes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  void _showImageSourceDialog(EditProfileController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Image Source',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppTheme.primaryColor),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                // Handle camera selection
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppTheme.primaryColor),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                // Handle gallery selection
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(EditProfileController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.formData.dateOfBirth != null
          ? DateTime.tryParse(controller.formData.dateOfBirth!) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.updateField('dateOfBirth', picked.toIso8601String().split('T')[0]);
    }
  }

  void _showCountryPicker(EditProfileController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Select Country/Region',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: countryOptions.length,
                itemBuilder: (context, index) {
                  final option = countryOptions[index];
                  final isSelected = option.value == controller.formData.location?.toLowerCase();
                  
                  return ListTile(
                    title: Text(option.label),
                    selected: isSelected,
                    onTap: () {
                      controller.updateField('location', option.label);
                      Navigator.pop(context);
                    },
                    trailing: isSelected ? const Icon(Icons.check, color: AppTheme.primaryColor) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile(EditProfileController controller) async {
    if (!_formKey.currentState!.validate()) {
      _scrollToFirstError();
      return;
    }

    final success = await controller.saveProfile();
    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  void _scrollToFirstError() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
