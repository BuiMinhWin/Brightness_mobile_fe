import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/profile_header.dart';
import '../../../../core/widgets/stats_row.dart';
import '../../../../core/widgets/action_buttons.dart';
import '../../../../core/widgets/feed_section.dart';
import '../../../../shared/services/user_profile_data_service.dart';
import '../controllers/navigation_controller.dart';

class UserProfilePage extends StatefulWidget {
  final String? userId;
  final bool isOwnProfile;

  const UserProfilePage({super.key, this.userId, this.isOwnProfile = false});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isLoading = false;
  bool _isAddingFriend = false;

  // Profile data loaded from JSON
  UserProfile? _profile;
  List<PostData> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final profile = await UserProfileDataService.getUserProfile(
        userId: widget.userId,
      );
      final posts = await UserProfileDataService.getUserPosts(
        userId: widget.userId,
      );

      if (mounted) {
        setState(() {
          _profile = profile;
          _posts = posts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: _isLoading || _profile == null
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryColor),
            )
          : _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        widget.isOwnProfile ? 'My Profile' : (_profile?.userName ?? 'Profile'),
        style: const TextStyle(
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
      actions: [
        if (!widget.isOwnProfile)
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.textPrimary),
            onPressed: _showMoreOptions,
          ),
      ],
    );
  }

  Widget _buildBody() {
    if (_profile == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primaryColor),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile header section
          Container(
            padding: const EdgeInsets.all(24),
            child: ProfileHeader(
              name: _profile!.userName,
              jobTitle: _profile!.jobTitle,
              location: _profile!.location,
              hobby: _profile!.hobby,
              rank: _profile!.rank,
              onImageTap: _handleImageTap,
            ),
          ),

          // Stats section
          StatsRow(
            postsCount: _profile!.postsCount,
            likesCount: _profile!.likesCount,
          ),

          // Action buttons
          ActionButtons(
            onEditProfile: widget.isOwnProfile ? _handleEditProfile : null,
            onAddFriend: widget.isOwnProfile ? null : _handleAddFriend,
            editButtonText: 'Edit profile',
            addFriendButtonText: _profile!.isFriend ? 'Friends' : 'Add friend',
            isFriend: _profile!.isFriend,
            isLoading: _isAddingFriend,
          ),

          const SizedBox(height: 24),

          // Posts/Activity feed section
          FeedSection(
            posts: _posts,
            isLoading: _isLoading,
            onPostTap: _handlePostTap,
            onLike: _handlePostLike,
            onComment: _handlePostComment,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _handleImageTap() {
    if (widget.isOwnProfile) {
      // Show image picker for own profile
      _showImageSourceDialog();
    } else {
      // Show full screen image for other profiles
      _showFullScreenImage();
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: AppTheme.primaryColor,
              ),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                // Handle camera
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppTheme.primaryColor,
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                // Handle gallery
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFullScreenImage() {
    // Implement full screen image view
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.surfaceColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image placeholder
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  color: AppTheme.textHint.withOpacity(0.2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    size: 120,
                    color: AppTheme.textHint,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${_profile?.userName ?? 'User'}\'s Profile Picture',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleEditProfile() {
    // Navigate to edit profile page using NavigationController
    context.read<NavigationController>().navigateToEditProfile(
      context: context,
    );
  }

  void _handleAddFriend() async {
    setState(() {
      _isAddingFriend = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (_profile != null) {
      setState(() {
        _isAddingFriend = false;
        _profile = UserProfile(
          userId: _profile!.userId,
          userName: _profile!.userName,
          jobTitle: _profile!.jobTitle,
          location: _profile!.location,
          hobby: _profile!.hobby,
          rank: _profile!.rank,
          postsCount: _profile!.postsCount,
          likesCount: _profile!.likesCount,
          profileImageUrl: _profile!.profileImageUrl,
          isOwnProfile: _profile!.isOwnProfile,
          isFriend: !_profile!.isFriend,
          bio: _profile!.bio,
          joinDate: _profile!.joinDate,
          lastActive: _profile!.lastActive,
        );
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _profile!.isFriend
                ? 'Friend request sent!'
                : 'Friend request cancelled',
          ),
          backgroundColor: AppTheme.successColor,
        ),
      );
    }
  }

  void _handlePostTap(PostData post) {
    // Navigate to post detail page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on post by ${post.userName}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handlePostLike(PostData post) {
    setState(() {
      final index = _posts.indexOf(post);
      if (index != -1) {
        _posts[index] = post.copyWith(
          isLiked: !post.isLiked,
          likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
        );
      }
    });
  }

  void _handlePostComment(PostData post) {
    // Navigate to comments page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Comments for ${post.userName}\'s post'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'More Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.report, color: AppTheme.errorColor),
              title: const Text('Report User'),
              onTap: () {
                Navigator.pop(context);
                _showReportDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppTheme.errorColor),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                _showBlockDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report User'),
        content: const Text('Are you sure you want to report this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User reported successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text('Are you sure you want to block this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User blocked successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }
}
