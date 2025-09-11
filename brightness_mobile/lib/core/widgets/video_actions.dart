import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VideoActions extends StatefulWidget {
  final VoidCallback? onSaveOffline;
  final VoidCallback? onBookmark;
  final bool isBookmarked;
  final bool isSavedOffline;
  final bool isLoading;

  const VideoActions({
    super.key,
    this.onSaveOffline,
    this.onBookmark,
    this.isBookmarked = false,
    this.isSavedOffline = false,
    this.isLoading = false,
  });

  @override
  State<VideoActions> createState() => _VideoActionsState();
}

class _VideoActionsState extends State<VideoActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Save Offline Button
          Expanded(
            child: _buildSaveOfflineButton(),
          ),
          const SizedBox(width: 12),
          
          // Bookmark Button
          _buildBookmarkButton(),
        ],
      ),
    );
  }

  Widget _buildSaveOfflineButton() {
    return ElevatedButton.icon(
      onPressed: widget.isLoading ? null : widget.onSaveOffline ?? _handleSaveOffline,
      icon: widget.isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Icon(
              widget.isSavedOffline ? Icons.check : Icons.download,
              size: 18,
            ),
      label: Text(
        widget.isSavedOffline ? 'Saved Offline' : 'Save Offline',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.secondaryColor, // Green color
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        minimumSize: const Size(0, 44),
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: widget.onBookmark ?? _handleBookmark,
        icon: Icon(
          widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: widget.isBookmarked ? AppTheme.primaryColor : AppTheme.textSecondary,
          size: 20,
        ),
      ),
    );
  }

  void _handleSaveOffline() {
    setState(() {
      // Simulate loading state
    });
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          // Update saved state
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.isSavedOffline 
                  ? 'Video removed from offline storage'
                  : 'Video saved for offline viewing',
            ),
            backgroundColor: AppTheme.successColor,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _handleBookmark() {
    setState(() {
      // Toggle bookmark state
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isBookmarked 
              ? 'Video removed from bookmarks'
              : 'Video added to bookmarks',
        ),
        backgroundColor: AppTheme.successColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
