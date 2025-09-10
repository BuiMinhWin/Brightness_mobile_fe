import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? onEditProfile;
  final VoidCallback? onAddFriend;
  final String? editButtonText;
  final String? addFriendButtonText;
  final bool isFriend;
  final bool isLoading;

  const ActionButtons({
    super.key,
    this.onEditProfile,
    this.onAddFriend,
    this.editButtonText,
    this.addFriendButtonText,
    this.isFriend = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Edit profile button
          Expanded(
            child: _buildActionButton(
              text: editButtonText ?? 'Edit profile',
              onPressed: onEditProfile,
              isPrimary: true,
            ),
          ),
          const SizedBox(width: 12),
          
          // Add friend button
          Expanded(
            child: _buildActionButton(
              text: isFriend 
                  ? (addFriendButtonText ?? 'Friends')
                  : (addFriendButtonText ?? 'Add friend'),
              onPressed: onAddFriend,
              isPrimary: false,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    VoidCallback? onPressed,
    required bool isPrimary,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.secondaryColor, // Light green background
        foregroundColor: Colors.black, // Dark text
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(0, 48),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
