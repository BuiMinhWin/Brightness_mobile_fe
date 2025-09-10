import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';

class ProfileAvatar extends StatefulWidget {
  final String? imageUrl;
  final VoidCallback? onTap;
  final double size;
  final bool showEditIcon;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;
  final String? placeholderText;
  final Function(File)? onImageSelected;
  final Function(String)? onImageUrlChanged;
  final bool allowGallery;
  final bool allowCamera;
  final String? errorMessage;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.onTap,
    this.size = AppTheme.avatarSizeXL,
    this.showEditIcon = true,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
    this.placeholderText,
    this.onImageSelected,
    this.onImageUrlChanged,
    this.allowGallery = true,
    this.allowCamera = true,
    this.errorMessage,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _showImageSourceDialog,
      child: Stack(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.backgroundColor ?? AppTheme.backgroundColor,
              border: Border.all(
                color: widget.errorMessage != null 
                    ? AppTheme.borderErrorColor 
                    : AppTheme.borderColor,
                width: 2,
              ),
            ),
            child: _buildAvatarContent(),
          ),
          if (widget.showEditIcon && !widget.isLoading)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: widget.size * 0.3,
                height: widget.size * 0.3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: widget.iconColor ?? AppTheme.surfaceColor,
                  size: widget.size * 0.15,
                ),
              ),
            ),
          if (widget.isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.3),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      );
    }

    // Show selected image first
    if (_selectedImage != null) {
      return ClipOval(
        child: Image.file(
          _selectedImage!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
        ),
      );
    }

    // Show network image if available
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          widget.imageUrl!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: AppTheme.primaryColor,
              ),
            );
          },
        ),
      );
    }

    // Show placeholder
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.backgroundColor ?? AppTheme.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: widget.size * 0.4,
            color: widget.iconColor ?? AppTheme.textSecondary,
          ),
          if (widget.placeholderText != null) ...[
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              widget.placeholderText!,
              style: AppTheme.textStyleCaption.copyWith(
                fontSize: widget.size * 0.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    if (!widget.allowGallery && !widget.allowCamera) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => _ImageSourceBottomSheet(
        allowGallery: widget.allowGallery,
        allowCamera: widget.allowCamera,
        onImageSourceSelected: _pickImage,
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        setState(() {
          _selectedImage = imageFile;
        });
        
        widget.onImageSelected?.call(imageFile);
        widget.onImageUrlChanged?.call(image.path);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
}

class _ImageSourceBottomSheet extends StatelessWidget {
  final bool allowGallery;
  final bool allowCamera;
  final Function(ImageSource) onImageSourceSelected;

  const _ImageSourceBottomSheet({
    required this.allowGallery,
    required this.allowCamera,
    required this.onImageSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Image Source',
            style: AppTheme.textStyleHeadline3,
          ),
          const SizedBox(height: AppTheme.spacingL),
          if (allowCamera)
            _ImageSourceOption(
              icon: Icons.camera_alt,
              title: 'Camera',
              onTap: () {
                Navigator.pop(context);
                onImageSourceSelected(ImageSource.camera);
              },
            ),
          if (allowGallery)
            _ImageSourceOption(
              icon: Icons.photo_library,
              title: 'Gallery',
              onTap: () {
                Navigator.pop(context);
                onImageSourceSelected(ImageSource.gallery);
              },
            ),
          const SizedBox(height: AppTheme.spacingM),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: AppTheme.iconSizeL),
      title: Text(title, style: AppTheme.textStyleBody1),
      onTap: onTap,
    );
  }
}

// Alternative implementation with more customization options
class AdvancedProfileAvatar extends StatefulWidget {
  final String? imageUrl;
  final VoidCallback? onTap;
  final double size;
  final bool showEditIcon;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;
  final String? placeholderText;
  final Function(File)? onImageSelected;
  final Function(String)? onImageUrlChanged;
  final bool allowGallery;
  final bool allowCamera;
  final String? errorMessage;
  final Widget? customPlaceholder;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final double borderWidth;
  final Color? borderColor;

  const AdvancedProfileAvatar({
    super.key,
    this.imageUrl,
    this.onTap,
    this.size = AppTheme.avatarSizeXL,
    this.showEditIcon = true,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
    this.placeholderText,
    this.onImageSelected,
    this.onImageUrlChanged,
    this.allowGallery = true,
    this.allowCamera = true,
    this.errorMessage,
    this.customPlaceholder,
    this.borderRadius,
    this.shadows,
    this.borderWidth = 2.0,
    this.borderColor,
  });

  @override
  State<AdvancedProfileAvatar> createState() => _AdvancedProfileAvatarState();
}

class _AdvancedProfileAvatarState extends State<AdvancedProfileAvatar> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _showImageSourceDialog,
      child: Stack(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
              color: widget.backgroundColor ?? AppTheme.backgroundColor,
              border: Border.all(
                color: widget.errorMessage != null 
                    ? AppTheme.borderErrorColor 
                    : widget.borderColor ?? AppTheme.borderColor,
                width: widget.borderWidth,
              ),
              boxShadow: widget.shadows,
            ),
            child: _buildAvatarContent(),
          ),
          if (widget.showEditIcon && !widget.isLoading)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: widget.size * 0.3,
                height: widget.size * 0.3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: widget.iconColor ?? AppTheme.surfaceColor,
                  size: widget.size * 0.15,
                ),
              ),
            ),
          if (widget.isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      );
    }

    // Show selected image first
    if (_selectedImage != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
        child: Image.file(
          _selectedImage!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
        ),
      );
    }

    // Show network image if available
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
        child: Image.network(
          widget.imageUrl!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: AppTheme.primaryColor,
              ),
            );
          },
        ),
      );
    }

    // Show placeholder
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    if (widget.customPlaceholder != null) {
      return widget.customPlaceholder!;
    }

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
        color: widget.backgroundColor ?? AppTheme.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: widget.size * 0.4,
            color: widget.iconColor ?? AppTheme.textSecondary,
          ),
          if (widget.placeholderText != null) ...[
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              widget.placeholderText!,
              style: AppTheme.textStyleCaption.copyWith(
                fontSize: widget.size * 0.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    if (!widget.allowGallery && !widget.allowCamera) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => _ImageSourceBottomSheet(
        allowGallery: widget.allowGallery,
        allowCamera: widget.allowCamera,
        onImageSourceSelected: _pickImage,
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final File imageFile = File(image.path);
        setState(() {
          _selectedImage = imageFile;
        });
        
        widget.onImageSelected?.call(imageFile);
        widget.onImageUrlChanged?.call(image.path);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
}
