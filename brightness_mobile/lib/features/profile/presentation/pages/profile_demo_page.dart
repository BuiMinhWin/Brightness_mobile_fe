import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import 'edit_profile_page.dart';
import 'user_profile_page.dart';
import 'first_aid_videos_page.dart';
import 'watch_video_page.dart';

class ProfileDemoPage extends StatelessWidget {
  const ProfileDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Profile Demo Hub',
          style: AppTheme.textStyleHeadline3,
        ),
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(),
            const SizedBox(height: AppTheme.spacingXXL),
            
            // Demo pages section
            _buildDemoPagesSection(context),
            const SizedBox(height: AppTheme.spacingXXL),
            
            // Components section
            _buildComponentsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.dashboard,
            size: AppTheme.iconSizeXL * 2,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: AppTheme.spacingL),
          Text(
            'Profile Demo Hub',
            style: AppTheme.textStyleHeadline2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'Navigate through different profile-related screens and components to explore the modular architecture.',
            style: AppTheme.textStyleBody1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDemoPagesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Demo Pages',
          style: AppTheme.textStyleHeadline3,
        ),
        const SizedBox(height: AppTheme.spacingL),
        
        // User Profile Page
        _buildDemoCard(
          title: 'User Profile Page',
          description: 'Complete user profile with posts, stats, and actions',
          icon: Icons.person,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserProfilePage(isOwnProfile: false),
              ),
            );
          },
        ),
        const SizedBox(height: AppTheme.spacingM),
        
        // My Profile Page
        _buildDemoCard(
          title: 'My Profile Page',
          description: 'Own profile view with edit capabilities',
          icon: Icons.account_circle,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserProfilePage(isOwnProfile: true),
              ),
            );
          },
        ),
        const SizedBox(height: AppTheme.spacingM),
        
        // Edit Profile Page
        _buildDemoCard(
          title: 'Edit Profile Page',
          description: 'Form-based profile editing with validation',
          icon: Icons.edit,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            );
          },
        ),
        const SizedBox(height: AppTheme.spacingM),
        
        // First Aid Videos Page
        _buildDemoCard(
          title: 'First Aid Videos Page',
          description: 'Medical videos with iFrame player and category filtering',
          icon: Icons.medical_services,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FirstAidVideosPage(),
              ),
            );
          },
        ),
        const SizedBox(height: AppTheme.spacingM),
        
        // Watch Video Page
        _buildDemoCard(
          title: 'Watch Video Page',
          description: 'Full video player with controls, info, and related videos',
          icon: Icons.play_circle_filled,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const WatchVideoPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildComponentsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reusable Components',
          style: AppTheme.textStyleHeadline3,
        ),
        const SizedBox(height: AppTheme.spacingL),
        
        CustomButton.outline(
          text: 'View All Components',
          onPressed: () {
            _showComponentsInfo(context);
          },
          icon: Icons.info_outline,
        ),
      ],
    );
  }

  Widget _buildDemoCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryColor,
                size: AppTheme.iconSizeL,
              ),
            ),
            const SizedBox(width: AppTheme.spacingL),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.textStyleBody1.copyWith(
                      fontWeight: AppTheme.fontWeightSemiBold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    description,
                    style: AppTheme.textStyleCaption,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textSecondary,
              size: AppTheme.iconSizeS,
            ),
          ],
        ),
      ),
    );
  }

  void _showComponentsInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Implemented Components'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Components
              _buildComponentSection('Profile Components'),
              _buildComponentItem('ProfileHeader', 'Avatar, name, job, location, hobby labels'),
              _buildComponentItem('StatsRow', 'Posts and likes metrics display'),
              _buildComponentItem('ActionButtons', 'Edit profile and Add friend buttons'),
              _buildComponentItem('PostCard', 'User posts with content and images'),
              _buildComponentItem('FeedSection', 'Scrollable posts list with loading states'),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Video Components
              _buildComponentSection('Video Components'),
              _buildComponentItem('VideoAppBar', 'Navigation, title, and filter options'),
              _buildComponentItem('CategoryTabs', 'Horizontal scrollable category filter'),
              _buildComponentItem('SearchBar', 'Video search with voice integration'),
              _buildComponentItem('VideoCard', 'Video player with iFrame and metadata'),
              _buildComponentItem('VideoFeed', 'Scrollable video list with infinite scroll'),
              _buildComponentItem('PullToRefresh', 'Refresh mechanism with loading states'),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Watch Video Components
              _buildComponentSection('Watch Video Components'),
              _buildComponentItem('VideoPlayerHeader', 'Navigation and menu options'),
              _buildComponentItem('MainVideoPlayer', 'Full-width iFrame video player with controls'),
              _buildComponentItem('VideoInfo', 'Title, duration, date, and description'),
              _buildComponentItem('AuthorInfo', 'Author avatar, name, and credentials'),
              _buildComponentItem('VideoActions', 'Save offline and bookmark buttons'),
              _buildComponentItem('RelatedVideos', 'List of related videos without play overlays'),
              _buildComponentItem('VideoListItem', 'Individual related video item'),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Form Components
              _buildComponentSection('Form Components'),
              _buildComponentItem('CustomTextField', 'Text input with validation'),
              _buildComponentItem('CustomDropdownField', 'Dropdown with search support'),
              _buildComponentItem('ProfileAvatar', 'Image picker with camera/gallery'),
              _buildComponentItem('CustomButton', 'Multiple button types with loading'),
              _buildComponentItem('FormSection', 'Grouped form sections'),
              
              const SizedBox(height: AppTheme.spacingL),
              
              // Core Components
              _buildComponentSection('Core Components'),
              _buildComponentItem('AppTheme', 'Consistent styling system'),
              _buildComponentItem('ValidationRules', 'Comprehensive validation'),
              _buildComponentItem('EditProfileController', 'State management with Provider'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS, top: AppTheme.spacingM),
      child: Text(
        title,
        style: AppTheme.textStyleBody1.copyWith(
          fontWeight: AppTheme.fontWeightBold,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }

  Widget _buildComponentItem(String name, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppTheme.successColor,
            size: AppTheme.iconSizeS,
          ),
          const SizedBox(width: AppTheme.spacingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.textStyleBody1.copyWith(
                    fontWeight: AppTheme.fontWeightMedium,
                  ),
                ),
                Text(
                  description,
                  style: AppTheme.textStyleCaption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
