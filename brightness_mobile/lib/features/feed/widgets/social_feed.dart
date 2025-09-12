import 'package:flutter/material.dart';
import 'social_post_card.dart';
import '../../../shared/services/social_feed_data_service.dart';
import '../post_detail_screen.dart';

class SocialFeed extends StatefulWidget {
  final String selectedTab;

  const SocialFeed({super.key, required this.selectedTab});

  @override
  State<SocialFeed> createState() => _SocialFeedState();
}

class _SocialFeedState extends State<SocialFeed> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<SocialPost> _posts = [];
  bool _isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPosts();
  }

  @override
  void didUpdateWidget(SocialFeed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTab != widget.selectedTab) {
      _loadPosts();
    }
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

  Future<void> _loadPosts() async {
    if (_isInitialLoading) {
      setState(() {
        _isInitialLoading = true;
      });
    }

    try {
      List<SocialPost> posts;
      if (widget.selectedTab.toLowerCase() == 'all') {
        posts = await SocialFeedDataService.getAllPosts();
      } else {
        posts = await SocialFeedDataService.getPostsByCategory(
          widget.selectedTab,
        );
      }

      if (mounted) {
        setState(() {
          _posts = posts;
          _isInitialLoading = false;
        });
      }
    } catch (e) {
      print('Error loading posts: $e');
      if (mounted) {
        setState(() {
          _isInitialLoading = false;
        });
      }
    }
  }

  void _loadMorePosts() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call for pagination
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
    await _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
      );
    }

    if (_posts.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        color: const Color(0xFF4CAF50),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Icon(Icons.feed_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No posts found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pull down to refresh or check back later',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF4CAF50),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
              ),
            );
          }

          final post = _posts[index];
          return SocialPostCard(
            username: post.username,
            timestamp: post.timestamp,
            content: post.content,
            imageUrls: post.imageUrls,
            avatarUrl: post.userAvatar,
            likes: post.likes,
            comments: post.comments,
            shares: post.shares,
            isLiked: post.isLiked,
            isBookmarked: post.isBookmarked,
            onMorePressed: () => _showPostOptions(post),
            onLikePressed: () => _handleLike(post),
            onCommentPressed: () => _handleComment(post),
            onSharePressed: () => _handleShare(post),
            onBookmarkPressed: () => _handleBookmark(post),
            // onImageTap: () => _showImageGallery(post.imageUrls),
            onPostTap: () => _navigateToPostDetail(post),
          );
        },
      ),
    );
  }

  void _showPostOptions(SocialPost post) {
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

  Future<void> _handleLike(SocialPost post) async {
    try {
      final updatedPost = await SocialFeedDataService.toggleLike(post.id);
      if (updatedPost != null && mounted) {
        setState(() {
          final index = _posts.indexWhere((p) => p.id == post.id);
          if (index != -1) {
            _posts[index] = updatedPost;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              updatedPost.isLiked
                  ? 'Liked ${post.username}\'s post'
                  : 'Unliked ${post.username}\'s post',
            ),
            backgroundColor: const Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  void _handleComment(SocialPost post) {
    // TODO: Navigate to comment screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening comments for ${post.username}\'s post'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _handleShare(SocialPost post) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${post.username}\'s post'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  Future<void> _handleBookmark(SocialPost post) async {
    try {
      final updatedPost = await SocialFeedDataService.toggleBookmark(post.id);
      if (updatedPost != null && mounted) {
        setState(() {
          final index = _posts.indexWhere((p) => p.id == post.id);
          if (index != -1) {
            _posts[index] = updatedPost;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              updatedPost.isBookmarked
                  ? 'Bookmarked ${post.username}\'s post'
                  : 'Removed bookmark from ${post.username}\'s post',
            ),
            backgroundColor: const Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      print('Error toggling bookmark: $e');
    }
  }

  // void _showImageGallery(List<String> imageUrls) {
  //   // TODO: Implement image gallery viewer
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Opening image gallery'),
  //       backgroundColor: Color(0xFF4CAF50),
  //     ),
  //   );
  // }

  void _navigateToPostDetail(SocialPost post) {
    print('Navigating to post detail: ${post.id}');
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) =>
                PostDetailScreen(postId: post.id, postData: post),
          ),
        )
        .then((result) {
          print('Returned from post detail');
          // Refresh the feed to get updated data
          _loadPosts();
        })
        .catchError((error) {
          print('Navigation error: $error');
        });
  }
}
