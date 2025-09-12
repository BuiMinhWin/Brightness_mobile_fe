import 'package:flutter/material.dart';
import 'social_post_card.dart';

class SocialFeed extends StatefulWidget {
  final String selectedTab;

  const SocialFeed({
    super.key,
    required this.selectedTab,
  });

  @override
  State<SocialFeed> createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  Future<void> _onRefresh() async {
    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF4CAF50),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _getPostsForTab().length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _getPostsForTab().length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  color: Color(0xFF4CAF50),
                ),
              ),
            );
          }

          final post = _getPostsForTab()[index];
          return SocialPostCard(
            username: post['username'] as String,
            timestamp: post['timestamp'] as String,
            content: post['content'] as String,
            imageUrls: List<String>.from(post['imageUrls'] ?? []),
            avatarUrl: post['avatarUrl'] as String?,
            likes: post['likes'] as int,
            comments: post['comments'] as int,
            shares: post['shares'] as int,
            isLiked: post['isLiked'] as bool,
            isBookmarked: post['isBookmarked'] as bool,
            onMorePressed: () => _showPostOptions(post),
            onLikePressed: () => _handleLike(post),
            onCommentPressed: () => _handleComment(post),
            onSharePressed: () => _handleShare(post),
            onBookmarkPressed: () => _handleBookmark(post),
            onImageTap: () => _showImageGallery(List<String>.from(post['imageUrls'] ?? [])),
            onPostTap: () => _navigateToPostDetail(post),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getPostsForTab() {
    // Sample data - in real app, this would come from API based on selectedTab
    return [
      {
        'id': 'post_001',
        'userId': 'user_001',
        'username': 'Mike Johnson',
        'userAvatar': null,
        'timestamp': '2h ago',
        'createdAt': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        'content': 'Morning workout complete! 💪 Nothing beats the feeling of endorphins after a good gym session. Ready to tackle the day! #Workout #Fitness #Motivation',
        'imageUrls': [],
        'likes': 24,
        'comments': 8,
        'shares': 3,
        'isLiked': false,
        'isBookmarked': false,
        'isFollowing': false,
        'tags': ['Workout', 'Fitness', 'Motivation'],
      },
      {
        'id': 'post_002',
        'userId': 'user_002',
        'username': 'Sarah Chen',
        'userAvatar': null,
        'timestamp': '4h ago',
        'createdAt': DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
        'content': 'Sunday meal prep is complete! 🥗 These healthy bowls are going to fuel my week. Planning and preparation is key to maintaining a healthy lifestyle. #MealPrep #HealthyEating #Nutrition',
        'imageUrls': [],
        'likes': 42,
        'comments': 12,
        'shares': 7,
        'isLiked': true,
        'isBookmarked': true,
        'isFollowing': true,
        'tags': ['MealPrep', 'HealthyEating', 'Nutrition'],
      },
      {
        'id': 'post_003',
        'userId': 'user_003',
        'username': 'Alex Rodriguez',
        'userAvatar': null,
        'timestamp': '6h ago',
        'createdAt': DateTime.now().subtract(const Duration(hours: 6)).toIso8601String(),
        'content': 'Just crushed my personal record on my morning run! 🏃‍♂️ 5K in 22 minutes - feeling unstoppable! Consistency is everything. #Running #PersonalRecord #MorningMotivation',
        'imageUrls': [],
        'likes': 18,
        'comments': 5,
        'shares': 2,
        'isLiked': false,
        'isBookmarked': false,
        'isFollowing': false,
        'tags': ['Running', 'PersonalRecord', 'MorningMotivation'],
      },
      {
        'id': 'post_004',
        'userId': 'user_004',
        'username': 'Emma Wilson',
        'userAvatar': null,
        'timestamp': '8h ago',
        'createdAt': DateTime.now().subtract(const Duration(hours: 8)).toIso8601String(),
        'content': 'Yoga in the park this morning was exactly what I needed. 🌅 The connection between mind and body is incredible. Taking time for mindfulness is so important. #Yoga #Mindfulness #OutdoorWorkout',
        'imageUrls': [],
        'likes': 31,
        'comments': 9,
        'shares': 4,
        'isLiked': true,
        'isBookmarked': false,
        'isFollowing': false,
        'tags': ['Yoga', 'Mindfulness', 'OutdoorWorkout'],
      },
      {
        'id': 'post_005',
        'userId': 'user_005',
        'username': 'David Kim',
        'userAvatar': null,
        'timestamp': '10h ago',
        'createdAt': DateTime.now().subtract(const Duration(hours: 10)).toIso8601String(),
        'content': 'Strength training session complete! 🏋️‍♂️ Progressive overload is the key to growth. Every rep counts when you\'re building towards your goals. #Workout #StrengthTraining #Fitness',
        'imageUrls': [],
        'likes': 15,
        'comments': 3,
        'shares': 1,
        'isLiked': false,
        'isBookmarked': true,
        'isFollowing': true,
        'tags': ['Workout', 'StrengthTraining', 'Fitness'],
      },
    ];
  }

  void _showPostOptions(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report, color: Colors.red),
              title: const Text('Report Post'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement report functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.orange),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement block functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.blue),
              title: const Text('Copy Link'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement copy link functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleLike(Map<String, dynamic> post) {
    // TODO: Implement like functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Liked ${post['username']}\'s post'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _handleComment(Map<String, dynamic> post) {
    // TODO: Navigate to comment screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening comments for ${post['username']}\'s post'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _handleShare(Map<String, dynamic> post) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${post['username']}\'s post'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _handleBookmark(Map<String, dynamic> post) {
    // TODO: Implement bookmark functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bookmarked ${post['username']}\'s post'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _showImageGallery(List<String> imageUrls) {
    // TODO: Implement image gallery viewer
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening image gallery'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _navigateToPostDetail(Map<String, dynamic> post) {
    print('Navigating to post detail: ${post['id']}');
    Navigator.of(context).pushNamed(
      '/post-detail',
      arguments: {
        'postId': post['id'], // Using proper post ID
        'postData': post,
      },
    ).then((result) {
      print('Returned from post detail');
    }).catchError((error) {
      print('Navigation error: $error');
    });
  }
}
